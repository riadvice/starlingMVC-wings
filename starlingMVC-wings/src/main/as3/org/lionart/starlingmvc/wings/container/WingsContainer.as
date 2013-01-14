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
package org.lionart.starlingmvc.wings.container
{
    import com.creativebottle.starlingmvc.StarlingMVC;

    import org.lionart.starlingmvc.wings.core.wings_internal;

    import starling.display.Sprite;

    use namespace wings_internal;

    public class WingsContainer extends Sprite implements IContainer, IWingsContainer
    {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _starlingMVC : StarlingMVC;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function WingsContainer()
        {
            super();
            wings_internal::initStarlingMVC();
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  starlingMVC
        //----------------------------------

        public function get starlingMVC() : StarlingMVC
        {
            return _starlingMVC;
        }

        public function set starlingMVC( value : StarlingMVC ) : void
        {
            _starlingMVC = value;
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        wings_internal function initStarlingMVC() : void
        {
            // TODO load configuration and init beans
        }
    }
}
