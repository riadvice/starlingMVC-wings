/*
   Copyright (C) 2013-2016 RIADVICE <ghazi.triki@riadvice.tn>

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General  License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU General  License for more details.

   You should have received a copy of the GNU General  License
   along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
package com.riadvice.starlingmvc.wings.net
{

    public interface IWingsDelegateResponder
    {

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  callbackFunction
        //----------------------------------

        function get callbackFunction() : Function;
        function set callbackFunction( value : Function ) : void;

        //----------------------------------
        //  callbackFunction
        //----------------------------------

        function get target() : Object;
        function set target( value : Object ) : void;

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        function addErrorListener( error : int, method : Function ) : void;
    }
}
