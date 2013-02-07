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
    import flash.net.getClassByAlias;

    import feathers.controls.Button;
    import feathers.controls.Label;
    import feathers.controls.Slider;
    import feathers.controls.TextInput;

    import org.as3commons.lang.StringUtils;
    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.core.wings_internal;
    import org.lionart.starlingmvc.wings.screen.WingsPanelScreen;
    import org.lionart.starlingmvc.wings.ui.AssetLoader;
    import org.lionart.starlingmvc.wings.utils.XMLUtils;
    import org.lionart.starlingmvc.wings.utils.applyProperty;

    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.text.TextField;

    public class ViewProcessor
    {

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * Processes the views portion of the xml configuration.
         */
        public function createElements( view : DisplayObjectContainer, xmlElements : XMLList ) : void
        {
            var displayObject : DisplayObject;
            var node : XML;

            if (view is WingsPanelScreen)
            {
                var scrPanel : WingsPanelScreen = view as WingsPanelScreen;
                scrPanel.headerProperties.title = xmlElements.header.@title;
                if (XMLList(xmlElements.child("layout")).length() != 0)
                {
                    var laouytClassName : String = "feathers.layout." + StringUtils.capitalize(xmlElements.layout.@type) + "Layout";
                    var layout : * = new (getClassByAlias(laouytClassName) as Class)();
                    var props : Object = XMLUtils.xmlToObject(XMLUtils.cleanFromAttributes(xmlElements.layout[0], ["type"]));
                    for (var property : String in props)
                    {
                        if (layout.hasOwnProperty(property))
                        {
                            applyProperty(layout, property, props[property]);
                        }
                    }
                    scrPanel.layout = layout;
                }
            }

            for each (node in xmlElements.children.element)
            {
                displayObject = this['create' + StringUtils.capitalize(node.@type.toString())](node);
                view.addChild(displayObject);
            }
        }

        //----------------------------------
        //  Starling controls
        //----------------------------------

        /**
         * Creates a Starling Image.
         */
        public function createImage( node : XML ) : DisplayObject
        {
            var displayObject : DisplayObject;
            displayObject = new Image(AssetLoader.getAtlas(node.@atlas).getTexture(node.@texture));
            displayObject.name = node.@name;
            return displayObject;
        }

        /**
         * Creates a Starling Button.
         */
        public function createButton( node : XML ) : DisplayObject
        {
            var displayObject : DisplayObject;
            displayObject = new starling.display.Button(AssetLoader.getAtlas(node.@atlas).getTexture(node.@texture));
            displayObject.name = node.@name;
            return displayObject;
        }

        /**
         * Creates a Starling TextField.
         */
        public function createTextField( node : XML ) : DisplayObject
        {
            var displayObject : DisplayObject;
            displayObject = new TextField(parseInt(node.@width), parseInt(node.@height), Wings.wings_internal::config.textClass[node.@text], node.@fontName, parseFloat(node.@fontSize), parseInt(node.@color.toString().replace(/0x|#/g, ""), 16), node.@bold == "true");
            displayObject.name = node.@name;
            return displayObject;
        }

        //----------------------------------
        //  Feathers controls
        //----------------------------------

        public function createFButton( node : XML ) : DisplayObject
        {
            var displayObject : DisplayObject;
            displayObject = new feathers.controls.Button();
            displayObject.name = node.@name;
            return displayObject;
        }

        public function createLabel( node : XML ) : DisplayObject
        {
            var displayObject : DisplayObject;
            displayObject = new Label();
            displayObject.name = node.@name;
            return displayObject;
        }

        public function createSlider( node : XML ) : DisplayObject
        {
            var displayObject : DisplayObject;
            displayObject = new Slider();
            displayObject.name = node.@name;
            return displayObject;
        }

        public function createTextInput( node : XML ) : DisplayObject
        {
            var displayObject : DisplayObject;
            displayObject = new TextInput();
            displayObject.name = node.@name;
            return displayObject;
        }

    }
}
