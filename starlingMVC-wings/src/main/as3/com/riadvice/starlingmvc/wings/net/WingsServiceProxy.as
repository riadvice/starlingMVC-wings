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
package com.riadvice.starlingmvc.wings.net
{
    import flash.events.AsyncErrorEvent;
    import flash.events.NetStatusEvent;
    import flash.net.Responder;
    import flash.net.registerClassAlias;

    import org.as3commons.lang.StringUtils;
    import com.riadvice.starlingmvc.wings.bean.IBean;
    import com.riadvice.starlingmvc.wings.data.ValueObject;
    import com.riadvice.starlingmvc.wings.remoting.WingsRemoteAMFConnection;
    import com.riadvice.starlingmvc.wings.transfer.TransferObject;
    import com.riadvice.starlingmvc.wings.transfer.TransferObjectHeader;

    import starling.events.EventDispatcher;

    public class WingsServiceProxy implements IServiceProxy, IWingsServiceProxy, IBean
    {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        [Dispatcher]
        public var dispatcher : EventDispatcher;

        protected var _connection : WingsRemoteAMFConnection;
        protected var _gateway : String;
        protected var _endPoint : String;
        protected var _glue : String;
        protected var _delegateResponder : IWingsDelegateResponder;

        private var _beanId : String;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function WingsServiceProxy()
        {
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  glue
        //----------------------------------

        public function get glue() : String
        {
            return _glue;
        }

        public function set glue( value : String ) : void
        {
            _glue = value;
        }

        //----------------------------------
        //  gateway
        //----------------------------------

        public function get gateway() : String
        {
            return _gateway;
        }

        public function set gateway( value : String ) : void
        {
            _gateway = value;
            _connection = new WingsRemoteAMFConnection(_gateway);
            _connection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusEventHandler);
            _connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncErrorEventHandler);
        }

        //----------------------------------
        //  endpoint
        //----------------------------------

        public function get endPoint() : String
        {
            return _endPoint;
        }

        public function set endPoint( value : String ) : void
        {
            _endPoint = value;
        }

        //----------------------------------
        //  beanId
        //----------------------------------

        public function get beanId() : String
        {
            return _beanId;
        }

        public function set beanId( value : String ) : void
        {
            if (StringUtils.isEmpty(_beanId))
            {
                _beanId = value;
            }
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        public function invoke( method : String, responder : IWingsResponder, ... args ) : void
        {
            var serviceName : String = _endPoint + _glue + method;
            switch (args.length)
            {
                case 0:
                    _connection.call.apply(_connection, [serviceName, responder as Responder]);
                    break;
                case 1:
                    _connection.call.apply(_connection, [serviceName, responder as Responder, args[0]]);
                    break;
                case 2:
                    _connection.call.apply(_connection, [serviceName, responder as Responder, args[0], args[1]]);
                    break;
                case 3:
                    _connection.call.apply(_connection, [serviceName, responder as Responder, args[0], args[1], args[2]]);
                    break;
                case 4:
                    _connection.call.apply(_connection, [serviceName, responder as Responder, args[0], args[1], args[2], args[3]]);
                    break;
                case 5:
                    _connection.call.apply(_connection, [serviceName, responder as Responder, args[0], args[1], args[2], args[3], args[4]]);
                    break;
                default:
                    break;
            }
        }

        //--------------------------------------------------------------------------
        //
        //  Event Handlers
        //
        //--------------------------------------------------------------------------

        protected function onNetStatusEventHandler( event : NetStatusEvent ) : void
        {
            // Override me
        }

        protected function onAsyncErrorEventHandler( event : AsyncErrorEvent ) : void
        {
            // Override me
        }

        //--------------------------------------------------------------------------
        //
        //  Class Methods
        //
        //--------------------------------------------------------------------------
        public static function registerRemoteClasses() : void
        {
            registerClassAlias("com.riadvice.starlingmvc.wings.data.ValueObject", ValueObject);
            registerClassAlias("com.riadvice.starlingmvc.wings.transfer.TransferObject", TransferObject);
            registerClassAlias("com.riadvice.starlingmvc.wings.transfer.TransferObjectHeader", TransferObjectHeader);
        }
    }
}
