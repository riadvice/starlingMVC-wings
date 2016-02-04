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
package com.riadvice.starlingmvc.wings.remoting
{
    import flash.net.NetConnection;
    import flash.net.ObjectEncoding;
    import flash.net.Responder;

    import com.riadvice.starlingmvc.wings.net.IResponder;

    public class WingsRemoteAMFConnection extends NetConnection implements IRemotingConnection, IWingsRemotingConnection
    {

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function WingsRemoteAMFConnection( url : String )
        {
            // Fixme load encoding from XML configuration file
            objectEncoding = ObjectEncoding.DEFAULT;

            if (url != null)
            {
                connect(url);
            }
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        public function request( url : String, service : String, responder : IResponder, ... params ) : void
        {
            call(url, Responder(responder), params);
        }
    }
}
