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
    import org.as3commons.lang.StringUtils;
    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.core.wings_internal;
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
                var tweenParams : Object = {};
                for (var prop : String in props)
                {
                    if (!StringUtils.isAlpha(props[prop]) && target.hasOwnProperty(prop))
                    {
                        if (target.hasOwnProperty(prop) && typeof(target[prop] == "number"))
                        {
                            tweenParams[prop] = parseFloat(props[prop]);
                        }
                    }
                    else
                    {
                        this["apply" + StringUtils.capitalize(prop)](tweenParams, props[prop], target);
                    }
                }
                Starling.juggler.tween(target, parseFloat(time), tweenParams);
            }
        }

        private function applyRight( object : Object, value : String, target : DisplayObject ) : void
        {
            if (!StringUtils.isAlpha(value))
            {
                object.x = Wings.wings_internal::config.appWidht - target.width - parseFloat(value);
            }
            else if (value == "out")
            {
                object.x = Wings.wings_internal::config.appWidht;
            }
        }

        private function applyLeft( object : Object, value : String, target : DisplayObject ) : void
        {
            if (!StringUtils.isAlpha(value))
            {
                object.x = parseFloat(value);
            }
            else if (value == "out")
            {
                object.x = -target.width;
            }
        }

        /**
         * Applies top style.
         */
        private function applyTop( object : Object, value : String, target : DisplayObject ) : void
        {
            if (!StringUtils.isAlpha(value))
            {
                object.y = parseFloat(value);
            }
            else if (value == "out")
            {
                object.y = -target.height;
            }
        }

        /**
         * Applies bottom style.
         */
        private function applyBottom( object : Object, value : String, target : DisplayObject ) : void
        {
            if (!StringUtils.isAlpha(value))
            {
                object.y = Wings.wings_internal::config.appHeight - target.height - parseFloat(value);
            }
            else if (value == "out")
            {
                object.y = Wings.wings_internal::config.appHeight;
            }
        }

        private function applyTransition( object : Object, value : String, target : DisplayObject ) : void
        {
            object.transition = value;
        }

        private function applyDelay( object : Object, value : String, target : DisplayObject ) : void
        {
            object.delay = parseFloat(value);
        }
    }
}
