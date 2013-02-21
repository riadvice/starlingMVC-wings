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
package org.lionart.starlingmvc.wings.transfer
{

    [RemoteClass(alias = "org.lionart.starlingmvc.wings.transfer.TransferObject")]
    public class TransferObject implements ITransferObject
    {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _instanceId : int = -1;
        private var _header : TransferObjectHeader;

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * give an header to the transfert object
         * @param code internal error our succes code
         * @param message human readable error or success message
         */
        public function buildHeader( code : uint = 0, message : String = null ) : TransferObjectHeader
        {
            _header = new TransferObjectHeader();
            _header.code = code;
            _header.message = message;
            return _header;
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  instanceId
        //----------------------------------

        public function get instanceId() : int
        {
            return _instanceId;
        }

        public function set instanceId( value : int ) : void
        {
            _instanceId = value;
        }

        //----------------------------------
        //  transferObjectHeader
        //----------------------------------

        /**
         * The header of the transfer object.
         */
        public function get transferObjectHeader() : TransferObjectHeader
        {
            return _header;
        }

        public function set transferObjectHeader( h : TransferObjectHeader ) : void
        {
            _header = h;
        }

    }
}
