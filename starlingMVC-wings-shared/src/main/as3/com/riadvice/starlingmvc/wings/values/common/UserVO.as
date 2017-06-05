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
package com.riadvice.starlingmvc.wings.values.common
{
    import com.riadvice.starlingmvc.wings.data.ValueObject;

    public class UserVO extends ValueObject
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _fbid : String;
        private var _twtid : String;
        private var _name : String;
        private var _firstName : String;
        private var _lastName : String;
        private var _email : String;
        private var _password : String;

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  fbid
        //----------------------------------

        public function get fbid() : String
        {
            return _fbid;
        }

        public function set fbid( value : String ) : void
        {
            _fbid = value;
        }

        //----------------------------------
        //  twtid
        //----------------------------------

        public function get twtid() : String
        {
            return _twtid;
        }

        public function set twtid( value : String ) : void
        {
            _twtid = value;
        }


        //----------------------------------
        //  name
        //----------------------------------

        public function get name() : String
        {
            return _name;
        }

        public function set name( value : String ) : void
        {
            _name = value;
        }

        //----------------------------------
        //  firstName
        //----------------------------------

        public function get firstName() : String
        {
            return _firstName;
        }

        public function set firstName( value : String ) : void
        {
            _firstName = value;
        }

        //----------------------------------
        //  lastName
        //----------------------------------

        public function get lastName() : String
        {
            return _lastName;
        }

        public function set lastName( value : String ) : void
        {
            _lastName = value;
        }

        //----------------------------------
        //  password
        //----------------------------------

        public function get password() : String
        {
            return _password;
        }

        public function set password( value : String ) : void
        {
            _password = value;
        }

    }
}
