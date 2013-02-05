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
package org.lionart.starlingmvc.wings.container
{
    import feathers.controls.ScreenNavigator;
    import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.core.wings_internal;

    import starling.events.Event;

    public class WingsFeathersContainer extends WingsContainer implements IWingsFeathersContainer
    {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _navigator : ScreenNavigator;
        private var _transitionManager : Object;

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  navigator
        //----------------------------------

        public function get navigator() : ScreenNavigator
        {
            return _navigator;
        }

        public function set navigator( value : ScreenNavigator ) : void
        {
            _navigator = value;
        }

        //----------------------------------
        //  transitionManager
        //----------------------------------

        public function get transitionManager() : Object
        {
            return _transitionManager;
        }

        public function set transitionManager( value : Object ) : void
        {
            _transitionManager = value;
        }

        //--------------------------------------------------------------------------
        //
        //  Event Handlers
        //
        //--------------------------------------------------------------------------

        override protected function addedToStageHandler( event : Event ) : void
        {
            super.addedToStageHandler(event);
            navigator = new ScreenNavigator();
            Wings.wings_internal::initScreens();
			Wings.wings_internal::initTransitionManager();
            addChild(navigator);
        }

    }
}
