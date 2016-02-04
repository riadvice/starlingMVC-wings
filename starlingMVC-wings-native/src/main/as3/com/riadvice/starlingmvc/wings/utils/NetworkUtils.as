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
package com.riadvice.starlingmvc.wings.utils
{
    import flash.net.NetworkInfo;
    import flash.net.NetworkInterface;

    import org.as3commons.lang.StringUtils;

    public final class NetworkUtils
    {
        /**
         * Returns true if the device has an active network connection.
         */
        public static function haveActiveConnection() : Boolean
        {
            var networks : Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();
            for each (var network : NetworkInterface in networks)
            {
                if (network.active == true && !StringUtils.isEmpty(network.hardwareAddress) && network.hardwareAddress != "127.0.0.1")
                {
                    return true;
                }
            }
            return false;
        }
    }
}
