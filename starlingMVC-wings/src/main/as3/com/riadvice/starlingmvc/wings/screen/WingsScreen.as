/*
   Copyright (C) 2013-2017 RIADVICE <ghazi.triki@riadvice.tn>

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
package com.riadvice.starlingmvc.wings.screen
{
    import feathers.controls.Screen;
    import feathers.events.FeathersEventType;

    import org.as3commons.lang.StringUtils;
    import com.riadvice.starlingmvc.wings.bean.IBean;
    import com.riadvice.starlingmvc.wings.core.Wings;
    import com.riadvice.starlingmvc.wings.core.wings_internal;
    import com.riadvice.starlingmvc.wings.events.WingsEvent;
    import com.riadvice.starlingmvc.wings.tween.TweenType;
    import com.riadvice.starlingmvc.wings.view.ILoadView;
    import com.riadvice.starlingmvc.wings.view.IUnloadView;

    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class WingsScreen extends Screen implements IWingsScreen, ILoadView, IUnloadView, IBean
    {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        [Dispatcher]
        public var dispatcher : EventDispatcher;

        private var _beanId : String;
        private var _xmlWings : XML;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function WingsScreen()
        {
            addEventListener(FeathersEventType.INITIALIZE, onInitializeHandler);
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
        //  beanId
        //----------------------------------

        public function get beanId() : String
        {
            return _beanId;
        }

        public function set beanId( value : String ) : void
        {
            if (StringUtils.isEmpty(_beanId))
            {
                _beanId = value;
            }
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        public function load() : void
        {
            placeElements();
            Wings.wings_internal::playTransition(beanId, TweenType.LOAD);
        }

        /**
         * @inheritDoc
         */
        public function unload() : void
        {
            Wings.wings_internal::playTransition(beanId, TweenType.UNLOAD);
        }

        /**
         * @inheritDoc
         */
        public function placeElements() : void
        {
            Wings.wings_internal::applyElementsStyle(beanId);
        }

        //--------------------------------------------------------------------------
        //
        //  Internal methods
        //
        //--------------------------------------------------------------------------
        public function viewLoaded() : void
        {
            dispatchEventWith(WingsEvent.VIEW_LOADED, false, this);
        }

        public function viewUnloaded() : void
        {
            dispatchEventWith(WingsEvent.VIEW_UNLOADED, false, this);
        }

        //--------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //--------------------------------------------------------------------------

        protected function onInitializeHandler( event : Event ) : void
        {
            removeEventListener(FeathersEventType.INITIALIZE, onInitializeHandler);
            Wings.wings_internal::createViewElements(beanId);
            load();
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        }

        protected function onAddedToStageHandler( event : Event ) : void
        {
            placeElements();
            load();
        }

        protected function onRemovedFromStage( event : Event ) : void
        {
            unload();
        }

    }
}
