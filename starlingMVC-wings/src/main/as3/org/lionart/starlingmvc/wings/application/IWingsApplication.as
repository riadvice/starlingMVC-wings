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
package org.lionart.starlingmvc.wings.application
{
    import starling.core.Starling;

    /**
     * The interface definition for a explicit starlingMVC-wings Application.
     */
    public interface IWingsApplication
    {
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  xmlWings
        //----------------------------------

        /**
         * The main application XML that will be used to build the entire application.
         */
        function get xmlWings() : XML;
        function set xmlWings( value : XML ) : void;

        //----------------------------------
        //  starling
        //----------------------------------

        /**
         * Starling instance.
         */
        function get starlingInstance() : Starling;
        function set starlingInstance( value : Starling ) : void;

        //----------------------------------
        //  mainScreen
        //----------------------------------

        /**
         * Main screen class that will be used by starling to intialise itself
         */
        function get mainScreen() : Class;
    }
}
