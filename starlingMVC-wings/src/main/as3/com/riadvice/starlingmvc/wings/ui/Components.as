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
package com.riadvice.starlingmvc.wings.ui
{
    import flash.utils.getDefinitionByName;

    public class Components
    {
        public static const STARLING_IMAGE : String = "st:image";
        public static const STARLING_BUTTON : String = "st:button";
        public static const STARLING_TEXT_FIELD : String = "st:text";

        private static const COMPONENTS_MAP : Object = {
                STARLING_IMAGE: "starling.display.Image",
                STARLING_BUTTON: "starling.display.Button",
                STARLING_TEXT_FIELD: "starling.text.TextField"
            };

        public static function getClassByTag( name : String ) : Class
        {
            return getDefinitionByName(COMPONENTS_MAP[name]) as Class;
        }
    }
}
