/*
   Copyright (C) 2013-2016 RIADVICE <ghazi.triki@riadvice.tn>

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
package com.riadvice.starlingmvc.wings.processors
{
    import com.riadvice.starlingmvc.wings.container.IWingsContainer;
    import com.riadvice.starlingmvc.wings.core.Wings;
    import com.riadvice.starlingmvc.wings.core.wings_internal;
    import com.riadvice.starlingmvc.wings.layout.LayoutManager;
    import com.riadvice.starlingmvc.wings.layout.WingsLayoutArea;
    import com.riadvice.starlingmvc.wings.utils.XMLUtils;
    import com.riadvice.starlingmvc.wings.utils.parseNumber;

    import org.as3commons.lang.StringUtils;

    import starling.display.DisplayObjectContainer;

    use namespace wings_internal;

    public class LayoutProcessor
    {

        //--------------------------------------------------------------------------
        //
        //  Class constants
        //
        //--------------------------------------------------------------------------

        private const NON_STYLE_ATTRIBUTES : Array = ["name"];

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var area : WingsLayoutArea;

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * Processes the tweens portion of the xml configuration.
         */
        public function processLayout( xmlElements : XMLList, container : IWingsContainer, layoutManager : LayoutManager ) : void
        {
            var node : XML;
            for each (node in xmlElements.area)
            {
                //  TODO add LayoutArea with custom type
                area = new WingsLayoutArea();
                area.wings_internal::initDispatcher(container["dispatcher"]);
                area.name = node.@name.toString();

                // TODO : x, y and other positioning values are not applied yet
                var styles : Object = XMLUtils.xmlToObject(XMLUtils.cleanFromAttributes(node, NON_STYLE_ATTRIBUTES));
                for (var property : String in styles)
                {
                    this["apply" + StringUtils.capitalize(property)](node["@" + property]);
                }
                layoutManager.addArea(area.name, area);
                DisplayObjectContainer(container).addChild(area);
            }
        }

        /**
         * Applies width style.
         */
        private function applyWidth( value : String ) : void
        {
            if (StringUtils.endsWith(value, "p"))
            {
                area.x = (parseNumber(StringUtils.remove(value, "p")) * 0.01) * Wings.appWidth;
            }
            else if (!StringUtils.isAlpha(value))
            {
                area.x = parseNumber(value);
            }
        }

        /**
         * Applies height style.
         */
        private function applyHeight( value : String ) : void
        {
            if (StringUtils.endsWith(value, "p"))
            {
                area.x = (parseNumber(StringUtils.remove(value, "p")) * 0.01) * Wings.appHeight;
            }
            else if (!StringUtils.isAlpha(value))
            {
                area.x = parseNumber(value);
            }
        }
    }
}
