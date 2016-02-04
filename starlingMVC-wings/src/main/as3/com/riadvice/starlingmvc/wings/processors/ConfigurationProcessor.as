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
package com.riadvice.starlingmvc.wings.processors
{
    import com.riadvice.starlingmvc.wings.core.WingsConfig;

    public class ConfigurationProcessor
    {
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * Processes the application portion of the xml configuration.
         */
        public function processConfiguration( xml : XMLList ) : WingsConfig
        {
            var config : WingsConfig = new WingsConfig();
            config.appHeight = parseFloat(xml.@height);
            config.appWidth = parseFloat(xml.@width);
            config.appId = xml.@appId.toString();
            config.version = xml.@version.toString();
            return config;
        }
    }
}