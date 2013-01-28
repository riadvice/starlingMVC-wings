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
package org.lionart.starlingmvc.wings.values.common
{

    public class UserVO
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _id : String;
        private var _fbid : String;
        private var _name : String;

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  id
        //----------------------------------

        public function get id() : String
        {
            return _id;
        }

        public function set id( value : String ) : void
        {
            _id = value;
        }

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
    }
}
