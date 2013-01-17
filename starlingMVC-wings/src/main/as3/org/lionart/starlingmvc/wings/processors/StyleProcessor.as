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
    import org.lionart.starlingmvc.wings.utils.XMLUtils;

    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.utils.deg2rad;

    public class StyleProcessor
    {

        //--------------------------------------------------------------------------
        //
        //  Class constants
        //
        //--------------------------------------------------------------------------

        private const NON_STYLE_ATTRIBUTES : Array = ["atlas", "name", "texture", "type"];

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var currentContainer : DisplayObjectContainer;
        private var currentElement : DisplayObject;

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        public function applyStyles( view : DisplayObjectContainer, xmlElements : XMLList ) : void
        {
            currentContainer = view;

            var node : XML;
            var style : String
            for each (node in xmlElements.children.element)
            {
                currentElement = view.getChildByName(node.@name);
                var styles : Object = XMLUtils.xmlToObject(XMLUtils.cleanFromAttributes(node, NON_STYLE_ATTRIBUTES));
                for (var property : String in styles)
                {
                    this["apply" + StringUtils.capitalize(property)](node["@" + property]);
                }
            }
        }

        //----------------------------------
        //  starling numeric objects styles
        //----------------------------------

        /**
         * Applies alpha attribute.
         */
        private function applyAlpha( value : String ) : void
        {
            currentElement.alpha = parseFloat(value);
        }

        /**
         * Applies height property.
         */
        private function applyHeight( value : String ) : void
        {
            currentElement.height = parseFloat(value);
        }

        /**
         * Applies pivotX property.
         */
        private function applyPivotX( value : String ) : void
        {
            if (StringUtils.isNumeric(value))
            {
                currentElement.pivotX = parseFloat(value);
            }
            else
            {
                switch (value)
                {
                    case Align.CENTER:
                        currentElement.pivotX = currentElement.width * 0.5;
                        break;

                    case Align.LEFT:
                        currentElement.pivotX = 0;
                        break;

                    case Align.RIGHT:
                        currentElement.pivotX = currentElement.width;
                        break;
                }
            }

        }

        /**
         * Applies pivotY property.
         */
        private function applyPivotY( value : String ) : void
        {
            if (StringUtils.isNumeric(value))
            {
                currentElement.pivotY = parseFloat(value);
            }
            else
            {
                switch (value)
                {
                    case Align.CENTER:
                        currentElement.pivotY = currentElement.height * 0.5;
                        break;

                    case Align.TOP:
                        currentElement.pivotY = 0;
                        break;

                    case Align.BOTTOM:
                        currentElement.pivotY = currentElement.height;
                        break;
                }
            }
        }

        /**
         * Applies scaleX property.
         */
        private function applyScaleX( value : String ) : void
        {
            currentElement.scaleX = parseFloat(value);
        }

        /**
         * Applies scaleY property.
         */
        private function applyScaleY( value : String ) : void
        {
            currentElement.scaleY = parseFloat(value);
        }

        /**
         * Applies skewX property.
         */
        private function applySkewX( value : String ) : void
        {
            currentElement.scaleX = parseFloat(value);
        }

        /**
         * Applies skewY property.
         */
        private function applySkewY( value : String ) : void
        {
            currentElement.skewY = parseFloat(value);
        }

        /**
         * Applies height property.
         */
        private function applyWidth( value : String ) : void
        {
            currentElement.height = parseFloat(value);
        }

        /**
         * Applies x position.
         */
        private function applyX( value : String ) : void
        {
            currentElement.x = parseFloat(value);
        }

        /**
         * Applies y position.
         */
        private function applyY( value : String ) : void
        {
            currentElement.y = parseFloat(value);
        }

        //----------------------------------
        //  starling boolean objects styles
        //----------------------------------

        /**
         * Applies touchable property.
         */
        private function applyTouchable( value : String ) : void
        {
            currentElement.touchable = value == "true";
        }

        /**
         * Applies useHandCursor property.
         */
        private function applyUseHandCursor( value : String ) : void
        {
            currentElement.useHandCursor = value == "true";
        }

        /**
         * Applies visible property.
         */
        private function applyVisible( value : String ) : void
        {
            currentElement.visible = value == "true";
        }


        //----------------------------------
        //  raduis object styles
        //----------------------------------

        /**
         * Applies rotation property.
         */
        private function applyRotation( value : String ) : void
        {
            currentElement.rotation = deg2rad(parseFloat(value));
        }

        //----------------------------------
        //  custom wings styles
        //----------------------------------

        /**
         * Applies hAlign style.
         */
        private function applyHAlign( value : String ) : void
        {
            if (value == Align.CENTER)
            {
                currentElement.x = int((Wings.wings_internal::config.appWidht - currentElement.width) * 0.5);
            }
            else if (value == Align.LEFT)
            {
                currentElement.x = 0;
            }
            else if (value == Align.RIGHT)
            {
                currentElement.x = int(Wings.wings_internal::config.appWidht - currentElement.width);
            }
        }

        /**
         * Applies hAlign style.
         */
        private function applyVAlign( value : String ) : void
        {
            if (value == Align.CENTER)
            {
                currentElement.y = int((Wings.wings_internal::config.appHeight - currentElement.height) * 0.5);
            }
            else if (value == Align.TOP)
            {
                currentElement.y = 0;
            }
            else if (value == Align.BOTTOM)
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

        /**
         * Applies scale style.
         */
        private function applyScale( value : String ) : void
        {
            currentElement.scaleX = parseFloat(value);
            currentElement.scaleY = parseFloat(value);
        }
    }
}
