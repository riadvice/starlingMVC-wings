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
package org.lionart.starlingmvc.wings.net
{

    import flash.utils.Dictionary;
    
    import org.lionart.starlingmvc.wings.errors.ServiceErrors;
    import org.lionart.starlingmvc.wings.net.WingsResponder;
    import org.lionart.starlingmvc.wings.transfer.TransferObject;

    public class WingsDelegateResponder extends WingsResponder implements IWingsDelegateResponder
    {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _target : Object;
        private var _callbackFunction : Function;
        private var _errorListeners : Dictionary;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function WingsDelegateResponder( value : Object = null )
        {
            _errorListeners = new Dictionary(true);
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  callbackFunction
        //----------------------------------

        public function get callbackFunction() : Function
        {
            return _callbackFunction;
        }

        public function set callbackFunction( value : Function ) : void
        {
            _callbackFunction = value;
        }

        //----------------------------------
        //  callbackFunction
        //----------------------------------

        public function get target() : Object
        {
            return _target;
        }

        public function set target( value : Object ) : void
        {
            _target = value;
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        override public function result( data : Object ) : void
        {
            if (data == null)
            {
                handleServerError(ServiceErrors.EMPTY_TRANSFER);
            }
            else if (!(data is TransferObject))
            {
                handleServerError(ServiceErrors.INVALID_TRANSFERT_OBJECT);
            }
            else
            {
                if (data != null && data.transferObjectHeader == null)
                {
                    handleServerError(ServiceErrors.NO_TRANSFERT_OBJECT_HEADER);
                }
                else if (data != null && data.transferObjectHeader != null && data.transferObjectHeader.code == 0)
                {
                    propagateResult(data as TransferObject);
                }
                else
                {
                    triggerErrorListeners(data as TransferObject);
                }
            }

        }

        protected function propagateResult( transfer : TransferObject ) : void
        {
            if (this.target != null && this.callbackFunction != null)
            {
                this.callbackFunction.apply(this.target, [transfer]);
            }
            return;
        }

        /**
         * Add a listener method for an error
         */
        public function addErrorListener( error : int, method : Function ) : void
        {
            _errorListeners[error] = method;
        }

        /**
         * Handles errors occured on server
         */
        protected function handleServerError( error : int ) : void
        {

        }

        protected function triggerErrorListeners( transfer : TransferObject ) : Boolean
        {
            if (_errorListeners[transfer.transferObjectHeader.code] != undefined)
            {
                var method : Function = _errorListeners[transfer.transferObjectHeader.code];
                method.apply(this, [transfer]);
                return true;
            }
            return false;
        }
    }
}
