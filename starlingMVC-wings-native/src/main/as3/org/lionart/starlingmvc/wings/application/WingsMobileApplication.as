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
    import flash.desktop.NativeApplication;
    import flash.events.Event;

    import org.lionart.starlingmvc.wings.core.wings_internal;

    public class WingsMobileApplication extends WingsApplication implements IWingsMobileApplication
    {
        public function WingsMobileApplication( immediateInit : Boolean = true )
        {
            // TODO : add pauseOnDeactivate boolean for the application
            NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, wings_internal::activateHandler);
            NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, wings_internal::deactivateHandler);
            NativeApplication.nativeApplication.addEventListener(Event.NETWORK_CHANGE, wings_internal::networkChangeHandler);
            super(immediateInit);
        }

        override protected function init() : void
        {
            super.init();
        }

        wings_internal function activateHandler( event : Event ) : void
        {
            if (starlingInstance)
            {
                starlingInstance.start();
            }
        }

        /**
         * When the game becomes inactive, we pause Starling; otherwise, the enter frame event
         * would report a very long 'passedTime' when the app is reactivated.
         **/
        wings_internal function deactivateHandler( event : Event ) : void
        {
            if (starlingInstance)
            {
                starlingInstance.stop();
            }
        }

        wings_internal function networkChangeHandler( event : Event ) : void
        {

        }

    }
}
