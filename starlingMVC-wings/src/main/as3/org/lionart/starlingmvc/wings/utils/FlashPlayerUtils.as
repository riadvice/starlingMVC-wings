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
package org.lionart.starlingmvc.wings.utils
{
    import flash.system.Capabilities;
    import flash.utils.describeType;

    public final class FlashPlayerUtils
    {
        /**
         * Returns flash player capabilites.
         */
        public static function getFPInfo() : Object
        {
            var caps : Object = {};
            var desc : XML = describeType(Capabilities);
            for each (var accessor : XML in desc.accessor)
            {
                caps[accessor.@name] = Capabilities[accessor.@name];
            }

            if (caps.hasOwnProperty("prototype"))
            {
                delete caps.prototype;
            }

            return caps;
        }
    }
}
