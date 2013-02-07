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
    import org.as3commons.lang.StringUtils;

    public class XMLUtils
    {
        private static const SPLIT_REGEX : RegExp = /\w*=\"(\w*\s*)*\"/gm;

        public static function xmlToObject( value : XML ) : Object
        {
            var result : Object = {};
            var str : String = String(value.toXMLString());
            var pairs : Array = [];
			var regexResult : Object = SPLIT_REGEX.exec(str);
			while (regexResult != null)
			{
				pairs.push(regexResult[0]);
				regexResult = SPLIT_REGEX.exec(str);
			}
            //str = str.substring(str.indexOf(" ") + 1, str.length - 2);
            for each (var pair : String in pairs)
            {
                result[StringUtils.substringBefore(pair, "=")] = StringUtils.substringBetween(pair, "\"", "\"");
            }
            return result;
        }

        public static function cleanFromAttributes( xml : XML, attributes : Array ) : XML
        {
            var xmlCopy : XML = xml.copy();
            for each (var value : String in attributes)
            {
                delete xmlCopy["@" + value];
            }
            return xmlCopy;
        }
    }
}
