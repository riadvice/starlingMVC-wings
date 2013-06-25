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
package org.lionart.starlingmvc.wings.layout
{
    import flash.utils.Dictionary;

    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.core.wings_internal;
    import org.lionart.starlingmvc.wings.view.IWingsView;

    public class LayoutManager
    {

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        private var _areas : Dictionary;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function LayoutManager() : void
        {
            _areas = new Dictionary(true);
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        public function getArea( name : String ) : IWingsLayoutArea
        {
            return _areas[name];
        }

        public function addArea( name : String, area : ILayoutArea ) : void
        {
            _areas[name] = area;
        }

        public function insertInArea( name : String, view : IWingsView ) : void
        {
            getArea(name).add(view);
        }

        public function insertInAreaByName( areaName : String, viewName : String ) : void
        {
            insertInArea(areaName, Wings.wings_internal::beans().getBeanById(viewName).instance as IWingsView);
        }
    }
}
