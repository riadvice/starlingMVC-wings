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
package com.riadvice.starlingmvc.wings.facebook
{
    import starling.events.Event;

    public class FacebookEvent extends Event
    {
        //--------------------------------------------------------------------------
        //
        //  Class constants
        //
        //--------------------------------------------------------------------------

        /**
         * Event dispatched when facebook init is successfull.
         */
        public static const FACEBOOK_SESSION_INIT : String = "facebookSessionInit";
        /**
         * Event dispatched when facebook init fails.
         */
        public static const FACEBOOK_INIT_FAIL : String = "facebookInitFail";
        /**
         * Event dispatched when facebook authenitcation fails.
         */
        public static const FACEBOOK_AUTH_FAIL : String = "facebookAuthFail";

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function FacebookEvent( type : String, bubbles : Boolean = false, data : Object = null )
        {
            super(type, bubbles, data);
        }
    }
}
