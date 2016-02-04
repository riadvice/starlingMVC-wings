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
package com.riadvice.starlingmvc.wings.transfer
{

    /**
     * See transfert object.
     */
    [RemoteClass(alias = "com.riadvice.starlingmvc.wings.transfer.TransferObjectHeader")]
    public class TransferObjectHeader
    {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _code : uint;
        private var _message : String;
        private var _stackTrace : String;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------		

        /**
         * Creates a new TransferObjectHeader object.
         */
        public function TransferObjectHeader()
        {
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  code
        //----------------------------------

        /**
         * The TransferObjectHeader code.
         */
        public function get code() : int
        {
            return _code;
        }

        public function set code( v : int ) : void
        {
            _code = v;
        }

        //----------------------------------
        //  message
        //----------------------------------

        /**
         * The TransferObjectHeader message.
         */
        public function get message() : String
        {
            return _message;
        }

        public function set message( v : String ) : void
        {
            _message = v;
        }

        //----------------------------------
        //  stackTrace
        //----------------------------------

        public function get stackTrace() : String
        {
            return _stackTrace;
        }

        public function set stackTrace( value : String ) : void
        {
            _stackTrace = value;
        }

    }

}
