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
    import pl.mateuszmackowiak.nativeANE.properties.SystemProperties;

    public class DeviceUtils
    {
        public static function getAllDeviceInfo() : String
        {
            var props : Object = SystemProperties.getInstance().getSystemProperites();
            if (props)
            {
                return ["AP=" + props[SystemProperties.APP_UID],
                    "AR=" + props[SystemProperties.ARCHITECTURE],
                    "IMEI=" + props[SystemProperties.IMEI],
                    "IMSI=" + props[SystemProperties.IMSI],
                    "N=" + props[SystemProperties.isNetworkActivitySupported],
                    "L=" + props[SystemProperties.LANGUAGE],
                    "LO=" + props[SystemProperties.LOCALIZED_MODEL],
                    "MA=" + props[SystemProperties.MAC_ADDRESS],
                    "MO=" + props[SystemProperties.MODEL],
                    "NM=" + props[SystemProperties.NAME],
                    "OS=" + props[SystemProperties.OS],
                    "PD=" + props[SystemProperties.PACKAGE_DIRECTORY],
                    "PN=" + props[SystemProperties.PACKAGE_NAME],
                    "PH=" + props[SystemProperties.PHONE_NUMBER],
                    "S=" + props[SystemProperties.SERIAL],
                    "UID=" + props[SystemProperties.UID],
                    "V=" + props[SystemProperties.VERSION]
                    ].join("&");
            }
            return "";
        }
    }
}
