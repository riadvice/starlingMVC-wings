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
    import feathers.controls.ScreenNavigatorItem;

    import org.lionart.starlingmvc.wings.container.IWingsContainer;
    import org.lionart.starlingmvc.wings.container.IWingsFeathersContainer;

    public class ScreenNavigatorProcessor
    {
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * Processes the views portion of the xml configuration for WingsFeathersContainer.
         */
        public function processScreens( xml : XMLList, container : IWingsFeathersContainer ) : void
        {
            var node : XML;
            for each (node in xml)
            {
                container.navigator.addScreen(node.@id.toString(), new ScreenNavigatorItem(IWingsContainer(container).starlingMVC.beans.getBeanById(node.@id).instance));
            }
        }
    }
}
