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
    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.core.wings_internal;
    import org.lionart.starlingmvc.wings.ui.AssetLoader;

    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.utils.HAlign;
    import starling.utils.VAlign;
    import starling.utils.deg2rad;

    public class ViewProcessor
    {

        private const STYLE_PROPS_BOOLEAN : Array = ["alpha", "touchable", "useHandCursor", "visible"];
        private const STYLE_PROPS_NUMBER : Array = ["height", "pivotX", "pivotY", "scaleX", "scaleY", "skewX", "skewY", "width", "x", "y"];
        private const STYLE_PROPS_GEOMETRY : Array = ["rotation"];
        private const STYLE_PROPS_STRING : Array = ["blendMode"];
        private const STYLE_PROPS_WINGS : Array = ["hAlign", "pivotToCenter", "vAlign"];

        public function createElements( view : DisplayObjectContainer, xmlElements : XMLList ) : void
        {
            var displayObject : DisplayObject;
            var node : XML;
            for each (node in xmlElements.children.element)
            {
                switch (node.@type.toString())
                {
                    case "image":
                        displayObject = new Image(AssetLoader.getAtlas(node.@atlas).getTexture(node.@texture));
                        displayObject.name = node.@name;
                        break;
                    case "button":
                        displayObject = new Button(AssetLoader.getAtlas(node.@atlas).getTexture(node.@texture));
                        displayObject.name = node.@name;
                        break;
                    default:
                        break;
                }
                view.addChild(displayObject);
            }
        }

        public function applyStyles( view : DisplayObjectContainer, xmlElements : XMLList ) : void
        {
            var child : DisplayObject;
            var node : XML;
            var style : String
            for each (node in xmlElements.children.element)
            {
                child = view.getChildByName(node.@name);
                for each (style in STYLE_PROPS_NUMBER)
                {
                    if (node.attribute(style).length() > 0)
                    {
                        child[style] = parseFloat(node.attribute(style).toString());
                    }
                }
                for each (style in STYLE_PROPS_BOOLEAN)
                {
                    if (node.attribute(style).length() > 0)
                    {
                        child[style] = node.attribute(style).toString() == "true";
                    }
                }
                for each (style in STYLE_PROPS_STRING)
                {
                    if (node.attribute(style).length() > 0)
                    {
                        child[style] = node.attribute(style).toString();
                    }
                }
                for each (style in STYLE_PROPS_GEOMETRY)
                {
                    if (node.attribute(style).length() > 0)
                    {
                        child[style] = deg2rad(parseFloat(node.attribute(style).toString()));
                    }
                }

                for each (style in STYLE_PROPS_WINGS)
                {
                    if (node.attribute(style).length() > 0)
                    {
                        var value : String = node.attribute(style).toString();
                        switch (style)
                        {
                            case "hAlign":
                            {
                                if (value == HAlign.CENTER)
                                {
                                    child.x = int((Wings.wings_internal::config.appWidht - child.width) * 0.5);
                                }
                                else if (value == HAlign.LEFT)
                                {
                                    child.x = 0;
                                }
                                else if (value == HAlign.RIGHT)
                                {
                                    child.x = int(Wings.wings_internal::config.appWidht - child.width);
                                }
                                break;
                            }

                            case "vAlign":
                            {
                                if (value == VAlign.CENTER)
                                {
                                    child.y = int((Wings.wings_internal::config.appHeight - child.height) * 0.5);
                                }
                                else if (value == VAlign.TOP)
                                {
                                    child.y = 0;
                                }
                                else if (value == VAlign.BOTTOM)
                                {
                                    child.y = int(Wings.wings_internal::config.appHeight - child.height);
                                }
                                break;
                            }

                            default:
                            {
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
}
