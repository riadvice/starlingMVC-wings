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
    import starling.text.TextField;

    public class ViewProcessor
    {

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
                    case "textField":
                        displayObject = new TextField(parseInt(node.@width), parseInt(node.@height), Wings.wings_internal::config.textClass[node.@text], node.@fontName, parseFloat(node.@fontSize), parseInt(node.@color.toString().replace(/0x|#/g, ""), 16), node.@bold == "true");
                        displayObject.name = node.@name;
                        break;
                    default:
                        break;
                }
                view.addChild(displayObject);
            }
        }

    }
}
