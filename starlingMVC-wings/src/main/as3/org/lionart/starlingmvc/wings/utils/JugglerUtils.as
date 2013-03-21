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
    import starling.animation.Tween;
    import starling.core.Starling;

    public class JugglerUtils
    {
        public static function createTween( target : Object, time : Number, props : Object, repeatCount : int = 1, reverse : Boolean = false, autoStart : Boolean = true, transition : Object = "linear" ) : Tween
        {
            var property : String;
            var tween : Tween = new Tween(target, time, transition);
            tween.repeatCount = repeatCount;
            tween.reverse = reverse;
            for (property in props)
            {
                if (tween.hasOwnProperty(property))
                {
                    tween[property] = props[property];
                }
                else
                {
                    tween.animate(property, parseNumber(props[property]));
                }
            }
            if (autoStart)
            {
                Starling.juggler.add(tween);
            }
            return tween;
        }
    }
}
