/*
   Copyright (C) 2013-2016 RIADVICE <ghazi.triki@riadvice.tn>

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
package com.riadvice.starlingmvc.wings.application
{
    import com.riadvice.starlingmvc.wings.core.Wings;
    import com.riadvice.starlingmvc.wings.core.wings_internal;

    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.geom.Rectangle;

    import avmplus.getQualifiedClassName;

    import citrus.core.CitrusEngine;
    import citrus.core.IScene;
    import citrus.core.citrus_internal;
    import citrus.core.starling.CitrusStarlingJuggler;
    import citrus.core.starling.StarlingScene;
    import citrus.core.starling.ViewportMode;

    import starling.core.Starling;
    import starling.display.DisplayObjectContainer;
    import starling.events.Event;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;

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

        public var textureScaleFactor : Number = 1;

        protected var _debug : Boolean = false;

        protected var _juggler : CitrusStarlingJuggler;

        protected var _assetSizes : Array = [1];
        protected var _baseWidth : int = -1;
        protected var _baseHeight : int = -1;
        protected var _viewportMode : String = ViewportMode.LEGACY;
        protected var _viewport : Rectangle = new Rectangle();
        protected var _suspendRenderingOnDeactivate : Boolean = false;

        private var _baseRectangle : Rectangle = new Rectangle();
        private var _screenRectangle : Rectangle = new Rectangle();

        private var _viewportBaseRatioWidth : Number = 1;
        private var _viewportBaseRatioHeight : Number = 1;

        private var _starlingRoot : DisplayObjectContainer;


        /**
         * context3D profiles to test for in Ascending order (the more important first).
         * reset this array to a single entry to force one specific profile. <a href="http://wiki.starling-framework.org/manual/constrained_stage3d_profile">More informations</a>.
         */
        protected var _context3DProfiles : Array = ["standardExtended", "standard", "standardConstrained", "baselineExtended", "baseline", "baselineConstrained"];

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

            _juggler = new CitrusStarlingJuggler();
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

        //----------------------------------
        //  baseWidth
        //----------------------------------

        public function get baseWidth() : int
        {
            return _baseWidth;
        }

        public function set baseWidth( value : int ) : void
        {
            _baseWidth = value;
            resetScreenSize();
        }

        //----------------------------------
        //  baseHeight
        //----------------------------------

        public function get baseHeight() : int
        {
            return _baseHeight;
        }

        public function set baseHeight( value : int ) : void
        {
            _baseHeight = value;
            resetScreenSize();
        }

        //----------------------------------
        //  viewportMode
        //----------------------------------

        public function get viewportMode() : String
        {
            return _viewportMode;
        }

        public function set viewportMode( value : String ) : void
        {
            _viewportMode = value;
            resetScreenSize();
            onStageResize.dispatch(_screenWidth, _screenHeight);
        }

        //----------------------------------
        //  juggler
        //----------------------------------

        public function get juggler() : CitrusStarlingJuggler
        {
            return _juggler;
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
            wings_internal::removeObfuscationWatermark();
            _starling = Wings.wings_internal::initStarling(stage);
            _starling.addEventListener(starling.events.Event.ROOT_CREATED, rootCreatedHandler);
        }

        /**
         * @inheritDoc
         */
        override public function destroy() : void
        {

            super.destroy();

            _juggler.purge();

            if (_scene)
            {

                if (_starling)
                {
                    _starling.stage.removeEventListener(starling.events.Event.RESIZE, handleStarlingStageResize);
                    _starling.stage.removeChild(_scene as StarlingScene);
                    _starling.root.dispose();
                    _starling.dispose();
                }
            }
        }

        /**
         * returns the asset size closest to one of the available asset sizes you have (based on <code>Starling.contentScaleFactor</code>).
         * If you design your app with a Starling's stage dimension equals to the Flash's stage dimension, you will have to overwrite
         * this function since the <code>Starling.contentScaleFactor</code> will be always equal to 1.
         * @param	assetSizes Array of numbers listing all asset sizes you use
         * @return
         */
        protected function findTextureScaleFactor( assetSizes : Array ) : Number
        {
            var arr : Array = assetSizes;
            arr.sort(Array.NUMERIC);
            var scaleF : Number = Math.floor(_starling.contentScaleFactor * 1000) / 1000;
            var closest : Number;
            var f : Number;
            for each (f in arr)
            {
                if (!closest || Math.abs(f - scaleF) < Math.abs(closest - scaleF))
                {
                    closest = f;
                }
            }

            return closest;
        }

        protected function resetViewport() : Rectangle
        {
            if (_baseHeight < 0)
            {
                _baseHeight = _screenHeight;
            }
            if (_baseWidth < 0)
            {
                _baseWidth = _screenWidth;
            }

            _viewport.setEmpty();

            _baseRectangle.setTo(0, 0, _baseWidth, _baseHeight);
            _screenRectangle.setTo(0, 0, _screenWidth, _screenHeight);


            switch (_viewportMode)
            {
                case ViewportMode.LETTERBOX:

                    RectangleUtil.fit(_baseRectangle, _screenRectangle, ScaleMode.SHOW_ALL, false, _viewport);

                    _viewport.x = _screenWidth * .5 - _viewport.width * .5;
                    _viewport.y = _screenHeight * .5 - _viewport.height * .5;

                    _starling.stage.stageWidth = _baseWidth;
                    _starling.stage.stageHeight = _baseHeight;

                    break;

                case ViewportMode.FULLSCREEN:
                case ViewportMode.FILL:

                    RectangleUtil.fit(_baseRectangle, _screenRectangle, _viewportMode == ViewportMode.FULLSCREEN ? ScaleMode.SHOW_ALL : ScaleMode.NO_BORDER, false, _viewport);

                    _viewportBaseRatioWidth = _viewport.width / _baseRectangle.width;
                    _viewportBaseRatioHeight = _viewport.height / _baseRectangle.height;
                    _viewport.copyFrom(_screenRectangle);

                    _viewport.x = _screenWidth * .5 - _viewport.width * .5;
                    _viewport.y = _screenHeight * .5 - _viewport.height * .5;

                    _starling.stage.stageWidth = _screenRectangle.width / _viewportBaseRatioWidth;
                    _starling.stage.stageHeight = _screenRectangle.height / _viewportBaseRatioHeight;

                    break;

                case ViewportMode.NO_SCALE:
                    _viewport = _baseRectangle;

                    _viewport.x = _screenWidth * .5 - _viewport.width * .5;
                    _viewport.y = _screenHeight * .5 - _viewport.height * .5;

                    _starling.stage.stageWidth = _baseWidth;
                    _starling.stage.stageHeight = _baseHeight;

                    _viewport = _screenRectangle.intersection(_viewport);

                    break;
                case ViewportMode.LEGACY:
                    _viewport = _screenRectangle;

                    _starling.stage.stageWidth = _screenRectangle.width;
                    _starling.stage.stageHeight = _screenRectangle.height;

                    break;
                case ViewportMode.MANUAL:
                    if (!_viewport)
                    {
                        _viewport = _starling.viewPort.clone();
                    }
                    break;
            }

            _starling.viewPort.copyFrom(_viewport);

            textureScaleFactor = findTextureScaleFactor(_assetSizes);

            transformMatrix.identity();
            transformMatrix.scale(_starling.contentScaleFactor, _starling.contentScaleFactor);
            transformMatrix.translate(_viewport.x, _viewport.y);

            return _viewport;
        }

        /**
         * @inheritDoc
         */
        override protected function resetScreenSize() : void
        {
            super.resetScreenSize();

            if (!_starling)
            {
                return;
            }

            resetViewport();

            setupStats();
        }

        public function setupStats( hAlign : String = "left", vAlign : String = "top", scale : Number = 1 ) : void
        {
            if (_starling && _starling.showStats)
            {
                _starling.showStatsAt(hAlign, vAlign, scale / _starling.contentScaleFactor);
            }
        }

        /**
         * This function is called when context3D is ready and the starling root is created.
         * the idea is to use this function for asset loading through the starling AssetManager and create the first scene.
         */
        public function handleStarlingReady() : void
        {
        }

        override citrus_internal function addSceneOver( value : IScene ) : void
        {
            if (_starling && _starling.stage)
            {
                _starlingRoot.addChild(value as StarlingScene);
            }
        }

        override citrus_internal function addSceneUnder( value : IScene ) : void
        {
            if (_starling && _starling.stage)
            {
                _starlingRoot.addChildAt(value as StarlingScene, _sceneDisplayIndex);
            }
        }

        override citrus_internal function removeScene( value : IScene ) : void
        {
            if (_starling && _starling.stage)
            {
                _starlingRoot.removeChild(value as StarlingScene, true);
            }
        }

        //--------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //--------------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        override protected function handlePlayingChange( value : Boolean ) : void
        {
            super.handlePlayingChange(value);

            _juggler.paused = !value;
        }

        protected function handleStarlingStageResize( evt : starling.events.Event ) : void
        {
            resetScreenSize();
            onStageResize.dispatch(_screenWidth, _screenHeight);
        }

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

            stage.removeEventListener(flash.events.Event.RESIZE, handleStageResize);

            _starlingRoot = _starling.root as DisplayObjectContainer;

            resetScreenSize();
            handleStarlingReady();
            setupStats();
            _starling.start();
        }

        /**
         * @inheritDoc
         */
        override protected function handleEnterFrame( e : flash.events.Event ) : void
        {
            if (_juggler)
            {
                _juggler.advanceTime(_timeDelta);
            }

            super.handleEnterFrame(e);
        }

        /**
         * @inheritDoc
         * We stop Starling. Be careful, if you use AdMob you will need to override this function and set Starling stop to <code>true</code>!
         * If you encounter issues with AdMob, you may override <code>handleStageDeactivated</code> and <code>handleStageActivated</code> and use <code>NativeApplication.nativeApplication</code> instead.
         */
        override protected function handleStageDeactivated( e : flash.events.Event ) : void
        {

            if (_playing && _starling)
            {
                _starling.stop(_suspendRenderingOnDeactivate);
            }

            super.handleStageDeactivated(e);
        }

        /**
         * @inheritDoc
         * We start Starling.
         */
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
