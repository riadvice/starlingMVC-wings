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

    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.utils.HAlign;
    import starling.utils.VAlign;
    import starling.utils.deg2rad;

    public class StyleProcessor
    {

        private const STYLE_PROPS_BOOLEAN : Array = ["alpha", "touchable", "useHandCursor", "visible"];
        private const STYLE_PROPS_NUMBER : Array = ["height", "pivotX", "pivotY", "scaleX", "scaleY", "skewX", "skewY", "width", "x", "y"];
        private const STYLE_PROPS_GEOMETRY : Array = ["rotation"];
        private const STYLE_PROPS_STRING : Array = ["blendMode"];
        private const STYLE_PROPS_WINGS : Array = ["bottom", "hAlign", "left", "pivotToCenter", "right", "top", "vAlign"];

        private var currentContainer : DisplayObjectContainer;
        private var currentElement : DisplayObject;

        public function applyStyles( view : DisplayObjectContainer, xmlElements : XMLList ) : void
        {
            currentContainer = view;

            var node : XML;
            var style : String
            for each (node in xmlElements.children.element)
            {
                currentElement = view.getChildByName(node.@name);
                for each (style in STYLE_PROPS_NUMBER)
                {
                    if (node.attribute(style).length() > 0)
                    {
                        currentElement[style] = parseFloat(node.attribute(style).toString());
                    }
                }
                for each (style in STYLE_PROPS_BOOLEAN)
                {
                    if (node.attribute(style).length() > 0)
                    {
                        currentElement[style] = node.attribute(style).toString() == "true";
                    }
                }
                for each (style in STYLE_PROPS_STRING)
                {
                    if (node.attribute(style).length() > 0)
                    {
                        currentElement[style] = node.attribute(style).toString();
                    }
                }
                for each (style in STYLE_PROPS_GEOMETRY)
                {
                    if (node.attribute(style).length() > 0)
                    {
                        currentElement[style] = deg2rad(parseFloat(node.attribute(style).toString()));
                    }
                }

                for each (style in STYLE_PROPS_WINGS)
                {
                    if (node.attribute(style).length() > 0)
                    {
                        var value : String = node.attribute(style).toString();
                        this["apply" + StringUtils.capitalize(style)](value);
                    }
                }
            }
        }

        /**
         * Applies hAlign style.
         */
        private function applyHAlign( value : String ) : void
        {
            if (value == HAlign.CENTER)
            {
                currentElement.x = int((Wings.wings_internal::config.appWidht - currentElement.width) * 0.5);
            }
            else if (value == HAlign.LEFT)
            {
                currentElement.x = 0;
            }
            else if (value == HAlign.RIGHT)
            {
                currentElement.x = int(Wings.wings_internal::config.appWidht - currentElement.width);
            }
        }

        /**
         * Applies hAlign style.
         */
        private function applyVAlign( value : String ) : void
        {
            if (value == VAlign.CENTER)
            {
                currentElement.y = int((Wings.wings_internal::config.appHeight - currentElement.height) * 0.5);
            }
            else if (value == VAlign.TOP)
            {
                currentElement.y = 0;
            }
            else if (value == VAlign.BOTTOM)
            {
                currentElement.y = int(Wings.wings_internal::config.appHeight - currentElement.height);
            }
        }

        /**
         * Applies top style.
         */
        private function applyTop( value : String ) : void
        {
            if (StringUtils.isNumeric(value))
            {
                currentElement.y = parseFloat(value);
            }
            else if (value == "out")
            {
                currentElement.y = -currentElement.height;
            }
        }

        /**
         * Applies bottom style.
         */
        private function applyBottom( value : String ) : void
        {
            if (StringUtils.isNumeric(value))
            {
                currentElement.y = Wings.wings_internal::config.appHeight - currentElement.height - parseFloat(value);
            }
            else if (value == "out")
            {
                currentElement.y = Wings.wings_internal::config.appHeight;
            }
        }

        /**
         * Applies left style.
         */
        private function applyLeft( value : String ) : void
        {
            if (StringUtils.isNumeric(value))
            {
                currentElement.x = parseFloat(value);
            }
            else if (value == "out")
            {
                currentElement.x = -currentElement.width;
            }
        }

        /**
         * Applies right style.
         */
        private function applyRight( value : String ) : void
        {
            if (StringUtils.isNumeric(value))
            {
                currentElement.x = Wings.wings_internal::config.appWidht - currentElement.width - parseFloat(value);
            }
            else if (value == "out")
            {
                currentElement.x = Wings.wings_internal::config.appWidht;
            }

        }
    }
}
