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
    import flash.utils.getDefinitionByName;

    public class ClassUtils
    {
        public static function getDefinitionByNameOrNull( name : XMLList ) : Class
        {
            try
            {
                return getDefinitionByName(name.text().toString()) as Class;
            }
            catch ( e : Error )
            {
                trace("Class " + name.text().toString() + " definition not found.");
            }

            return null;
        }

        public static function findClassInPackages( className : String, packages : Array ) : Class
        {
            for each (var pack : String in packages)
            {
                try
                {
                    return getDefinitionByName(pack + "." + className) as Class;
                }
                catch ( e : Error )
                {
                    trace("Class " + className + " not found in package " + pack + " . Checking next package.");
                }
            }
            return null;
        }
    }
}
