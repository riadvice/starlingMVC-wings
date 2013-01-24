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
    import org.lionart.starlingmvc.wings.container.IWingsContainer;
    import org.lionart.starlingmvc.wings.layout.LayoutManager;
    import org.lionart.starlingmvc.wings.layout.WingsLayoutArea;

    public class LayoutProcessor
    {
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
                var area : WingsLayoutArea = new WingsLayoutArea();
                // FIXME : styles should be processed by StyleProcessor class.
                // TODO : assign properties dynamically
                area.width = node.@width;
                area.height = node.@height;
                area.x = node.@x;
                area.y = node.@y;
                area.name = node.@name;
                layoutManager.addArea(area.name, area);
                container(area);
            }
        }
    }
}
