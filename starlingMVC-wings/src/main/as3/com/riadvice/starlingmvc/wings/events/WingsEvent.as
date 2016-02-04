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
package com.riadvice.starlingmvc.wings.events
{
    import starling.events.Event;

    public class WingsEvent extends Event
    {
        /**
         * Event type for an view loaded. Dispatched after its load transition is complete.
         */
        public static const VIEW_LOADED : String = "viewLoaded";
        /**
         * Event type for an view unloaded. Dispatched after its unload transition is complete.
         */
        public static const VIEW_UNLOADED : String = "viewUnloaded";

        public function WingsEvent( type : String, bubbles : Boolean = false, data : Object = null )
        {
            super(type, bubbles, data);
        }
    }
}
