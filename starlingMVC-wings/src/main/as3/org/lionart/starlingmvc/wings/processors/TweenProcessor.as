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
    import org.lionart.starlingmvc.wings.style.Align;
    import org.lionart.starlingmvc.wings.utils.JugglerUtils;
    import org.lionart.starlingmvc.wings.utils.XMLUtils;

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
                if (node.@target != "self")
                {
                    target = view.getChildByName(node.@target);
                }
                else
                {
                    target = view;
                }
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
                JugglerUtils.createTween(target, parseFloat(time), tweenParams);
            }
        }

        private function applyRight( object : Object, value : String, target : DisplayObject ) : void
        {
            if (!StringUtils.isAlpha(value))
            {
                object.x = Wings.wings_internal::config.appWidth - target.width - parseFloat(value);
            }
            else if (value == "out")
            {
                object.x = Wings.wings_internal::config.appWidth;
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

        private function applyHAlign( object : Object, value : String, target : DisplayObject ) : void
        {
            if (value == Align.CENTER)
            {
                object.x = int((Wings.wings_internal::config.appWidth - target.width) * 0.5);
            }
            else if (value == Align.LEFT)
            {
                object.x = 0;
            }
            else if (value == Align.RIGHT)
            {
                object.x = int(Wings.wings_internal::config.appWidth - target.width);
            }
        }

        /**
         * Applies hAlign style.
         */
        private function applyVAlign( object : Object, value : String, target : DisplayObject ) : void
        {
            if (value == Align.CENTER)
            {
                object.y = int((Wings.wings_internal::config.appHeight - target.height) * 0.5);
            }
            else if (value == Align.TOP)
            {
                object.y = 0;
            }
            else if (value == Align.BOTTOM)
            {
                object.y = int(Wings.wings_internal::config.appHeight - target.height);
            }
        }

        private function applyReverse( object : Object, value : String, target : DisplayObject ) : void
        {
            object.reverse = value == "true";
        }

        private function applyRepeatCount( object : Object, value : String, target : DisplayObject ) : void
        {
            object.repeatCount = parseInt(value);
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
