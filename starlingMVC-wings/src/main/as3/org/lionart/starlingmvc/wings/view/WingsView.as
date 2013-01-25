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
package org.lionart.starlingmvc.wings.view
{
    import org.as3commons.lang.StringUtils;
    import org.lionart.starlingmvc.wings.tween.TweenType;
    import org.lionart.starlingmvc.wings.bean.IBean;
    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.core.wings_internal;
    import org.lionart.starlingmvc.wings.events.WingsEvent;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.EventDispatcher;

    use namespace wings_internal;

    public class WingsView extends Sprite implements IView, IWingsView, ILoadView, IUnloadView, IBean
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

        public function WingsView()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
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
        wings_internal function viewLoaded() : void
        {
            dispatcher.dispatchEventWith(WingsEvent.VIEW_LOADED, false, this);
        }

        wings_internal function viewUnloaded() : void
        {
            dispatcher.dispatchEventWith(WingsEvent.VIEW_UNLOADED, false, this);
        }

        //--------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //--------------------------------------------------------------------------

        protected function onAddedToStageHandler( event : Event ) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
            Wings.wings_internal::createViewElements(beanId);
        }
    }
}
