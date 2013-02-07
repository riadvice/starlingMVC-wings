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
package org.lionart.starlingmvc.wings.layout
{
    import org.lionart.starlingmvc.wings.core.wings_internal;
    import org.lionart.starlingmvc.wings.events.WingsEvent;
    import org.lionart.starlingmvc.wings.view.ILoadView;
    import org.lionart.starlingmvc.wings.view.IUnloadView;
    import org.lionart.starlingmvc.wings.view.IWingsView;

    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class WingsLayoutArea extends Sprite implements ILayoutArea, IWingsLayoutArea
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        [Dispatcher]
        public var dispatcher : EventDispatcher;

        private var _currentView : IWingsView;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function WingsLayoutArea()
        {
            super();
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        public function add( view : IWingsView ) : void
        {
            if (_currentView && _currentView is IUnloadView)
            {
                IUnloadView(_currentView).unload();
            }
            if (view is ILoadView)
            {
                _currentView = view;
                this.addChild(view as DisplayObject);
                ILoadView(view).load();
            }
            else
            {
                this.addChild(view as DisplayObject);
            }
        }

        public function remove( view : IWingsView ) : void
        {
            if (view is IUnloadView)
            {
                view["addEventListener"](WingsEvent.VIEW_UNLOADED, onViewUnloadedHandler);
                IUnloadView(view).unload();
            }
            else
            {
                removeChild(view as DisplayObject);
            }
        }

        wings_internal function initDispatcher( value : EventDispatcher ) : void
        {
            dispatcher = value;
            dispatcher.addEventListener(WingsEvent.VIEW_LOADED, onViewLoadedHandler);
            dispatcher.addEventListener(WingsEvent.VIEW_UNLOADED, onViewUnloadedHandler);
        }

        //--------------------------------------------------------------------------
        //
        //  Events listeners
        //
        //--------------------------------------------------------------------------

        private function onViewLoadedHandler( event : Event ) : void
        {

        }

        private function onViewUnloadedHandler( event : Event ) : void
        {
            event.currentTarget["removeEventListener"](WingsEvent.VIEW_UNLOADED, onViewUnloadedHandler);
            removeChild(event.currentTarget as DisplayObject);
        }
    }
}
