/*
   Copyright (C) 2013 Ghazi Triki <ghazi.nocturne@gmail.com>

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
package org.lionart.starlingmvc.wings.application
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.geom.Rectangle;

    import avmplus.getQualifiedClassName;

    import citrus.core.CitrusEngine;
    import citrus.core.State;
    import citrus.core.starling.StarlingState;

    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.core.wings_internal;

    import starling.core.Starling;
    import starling.events.Event;

    /**
     * Extends this class if you create a Starling based game. Don't forget to call <code>setUpStarling</code> function.
     *
     * <p>CitrusEngine can access to the Stage3D power thanks to the <a href="http://starling-framework.org/">Starling Framework</a>.</p>
     */
    public class LemonadeEngine extends CitrusEngine implements IApplication, IWingsApplication
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _starling : Starling;
        private var _xmlWings : XML;
        private var _mainScreen : Class;

        protected var appScale : Number = 1;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function LemonadeEngine( immediateInit : Boolean = true )
        {
            super();

            Wings.wings_internal::registerApp(this);

            if (immediateInit)
            {
                if (stage != null)
                {
                    init();
                }
                else
                {
                    addEventListener(flash.events.Event.ADDED_TO_STAGE, initHandler);
                }
            }
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  xmlWings
        //----------------------------------

        public function get xmlWings() : XML
        {
            return _xmlWings;
        }

        public function set xmlWings( value : XML ) : void
        {
            _xmlWings = value;
        }

        //----------------------------------
        //  starling
        //----------------------------------

        public function get starlingInstance() : Starling
        {
            return _starling;
        }

        public function set starlingInstance( value : Starling ) : void
        {
            _starling = value;
        }

        //----------------------------------
        //  mainScreen
        //----------------------------------

        public function get mainScreen() : Class
        {
            return _mainScreen;
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * Application XML is processed then a Starling insance is created.
         */
        protected function init() : void
        {
            calculateScale();
            wings_internal::removeObfuscationWatermark();
            _starling = Wings.wings_internal::initStarling(stage);
            _starling.addEventListener(starling.events.Event.ROOT_CREATED, rootCreatedHandler);
        }

        override public function destroy() : void
        {

            super.destroy();

            if (_state)
            {

                if (_starling)
                {

                    _starling.stage.removeChild(_state as StarlingState);

                    // Remove Box2D or Nape debug view
                    var debugView : DisplayObject = _starling.nativeStage.getChildByName("debug view");
                    if (debugView)
                    {
                        _starling.nativeStage.removeChild(debugView);
                    }

                    _starling.root.dispose();
                    _starling.dispose();
                }
            }
        }

        //--------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //--------------------------------------------------------------------------

        /**
         * When the application is added to stage when initialise it.
         */
        protected function initHandler( e : flash.events.Event = null ) : void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
            init();
        }

        /**
         * When the starling root is created we start our Starling instance.
         */
        protected function rootCreatedHandler( event : starling.events.Event ) : void
        {
            _starling.removeEventListener(starling.events.Event.ROOT_CREATED, rootCreatedHandler);
            _starling.start();
        }

        protected function calculateScale() : void
        {
            var guiSize : Rectangle = new Rectangle(0, 0, 1024, 600);
            var deviceSize : Rectangle = new Rectangle(0, 0, Math.max(stage.fullScreenWidth, stage.fullScreenHeight), Math.min(stage.fullScreenWidth, stage.fullScreenHeight));
            var appSize : Rectangle = guiSize.clone();
            var appLeftOffset : Number = 0;
            // if device is wider than GUI's aspect ratio, height determines scale
            if ((deviceSize.width / deviceSize.height) > (guiSize.width / guiSize.height))
            {
                appScale = deviceSize.height / guiSize.height;
                appSize.width = deviceSize.width / appScale;
                appLeftOffset = Math.round((appSize.width - guiSize.width) / 2);
            }
            // if device is taller than GUI's aspect ratio, width determines scale
            else
            {
                appScale = deviceSize.width / guiSize.width;
                appSize.height = deviceSize.height / appScale;
                appLeftOffset = 0;
            }
            // scale the entire interface
        /*base.scale = appScale;
           // map stays at the top left and fills the whole screen
           base.map.x = 0; // menus are centered horizontally
           base.menus.x = appLeftOffset;
           //crop some menus which are designed to run off the sides of the screen
           base.scrollRect = appSize;*/
        }

        override protected function handleEnterFrame( e : flash.events.Event ) : void
        {

            if (_starling && _starling.isStarted && _starling.context)
            {

                if (_newState)
                {

                    if (_state)
                    {

                        if (_state is StarlingState)
                        {

                            _state.destroy();
                            _starling.stage.removeChild(_state as StarlingState, true);

                            // Remove Box2D or Nape debug view
                            var debugView : DisplayObject = _starling.nativeStage.getChildByName("debug view");
                            if (debugView)
                            {
                                _starling.nativeStage.removeChild(debugView);
                            }

                        }
                        else
                        {

                            _state.destroy();
                            removeChild(_state as State);
                        }

                    }

                    if (_newState is StarlingState)
                    {

                        _state = _newState;
                        _newState = null;

                        if (_futureState)
                        {
                            _futureState = null;
                        }
                        else
                        {
                            _starling.stage.addChildAt(_state as StarlingState, _stateDisplayIndex);
                            _state.initialize();
                        }
                    }
                }

                if (_stateTransitionning && _stateTransitionning is StarlingState)
                {

                    _futureState = _stateTransitionning;
                    _stateTransitionning = null;

                    _starling.stage.addChildAt(_futureState as StarlingState, _stateDisplayIndex);
                    _futureState.initialize();
                }

            }

            super.handleEnterFrame(e);
        }

        override protected function handleStageDeactivated( e : flash.events.Event ) : void
        {

            if (_playing && _starling)
            {
                _starling.stop();
            }

            super.handleStageDeactivated(e);
        }

        override protected function handleStageActivated( e : flash.events.Event ) : void
        {

            if (_starling && !_starling.isStarted)
            {
                _starling.start();
            }

            super.handleStageActivated(e);
        }

        /**
         * Removes the obfuscation watermarke of the software.
         */
        wings_internal function removeObfuscationWatermark() : void
        {
            var child : DisplayObject;
            var toRemove : Array = [];
            for (var i : int = 0; i < numChildren; i++)
            {
                child = getChildAt(i);
                if (getQualifiedClassName(child) == "flash.text::TextField" || getQualifiedClassName(child) == "flash.display::Shape")
                {
                    // Watermark DisplayObjects are generated with widths below
                    if (child.width == 185.55 || child.width == 203.9)
                    {
                        toRemove.push(child);
                    }
                }
            }

            for each (child in toRemove)
            {
                removeChild(child);
                child = null;
            }
        }
    }
}
