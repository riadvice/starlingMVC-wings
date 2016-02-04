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
package com.riadvice.starlingmvc.wings.values.common
{
    import com.riadvice.starlingmvc.wings.data.ValueObject;

    public class SessionVO extends ValueObject
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _sessionId : String;
        private var _version : String;
        private var _fbID : String;
        private var _appID : String;
        private var _device : String;
        private var _user : Object;
        private var _data : *;

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  sessionId
        //----------------------------------

        public function get sessionId() : String
        {
            return _sessionId;
        }

        public function set sessionId( value : String ) : void
        {
            _sessionId = value;
        }

        //----------------------------------
        //  version
        //----------------------------------

        public function get version() : String
        {
            return _version;
        }

        public function set version( value : String ) : void
        {
            _version = value;
        }

        //----------------------------------
        //  fbID
        //----------------------------------

        public function get fbID() : String
        {
            return _fbID;
        }

        public function set fbID( value : String ) : void
        {
            _fbID = value;
        }

        //----------------------------------
        //  appID
        //----------------------------------

        public function get appID() : String
        {
            return _appID;
        }

        public function set appID( value : String ) : void
        {
            _appID = value;
        }

        //----------------------------------
        //  device
        //----------------------------------

        public function get device() : String
        {
            return _device;
        }

        public function set device( value : String ) : void
        {
            _device = value;
        }

        //----------------------------------
        //  user
        //----------------------------------

        public function get user() : Object
        {
            return _user;
        }

        public function set user( value : Object ) : void
        {
            _user = value;
        }

        //----------------------------------
        //  data
        //----------------------------------

        public function get data() : *
        {
            return _data;
        }

        public function set data( value : * ) : void
        {
            _data = value;
        }


    }
}
