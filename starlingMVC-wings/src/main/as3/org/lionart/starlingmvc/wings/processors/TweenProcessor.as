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
package org.lionart.starlingmvc.wings.processors
{
    import org.lionart.starlingmvc.wings.utils.XMLUtils;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;

    public class TweenProcessor
    {
        public function playTweens( view : DisplayObjectContainer, tweens : XMLList ) : void
        {
            var node : XML;
            var target : DisplayObject;
            var time : String;
            for each (node in tweens)
            {
                target = view.getChildByName(node.@target);
                time = node.@time;
                node = XMLUtils.cleanFromAttributes(node, ["target", "time"]);
                var props : Object = XMLUtils.xmlToObject(node);
                for (var prop : String in props)
                {
                    if (target.hasOwnProperty(prop) && typeof(target[prop] == "number"))
                    {
                        props[prop] = parseFloat(props[prop]);
                    }
                }
                Starling.juggler.tween(target, parseFloat(time), props);
            }
        }
    }
}
