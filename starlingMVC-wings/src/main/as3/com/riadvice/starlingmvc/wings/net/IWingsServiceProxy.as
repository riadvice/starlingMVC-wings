/*
   Copyright (C) 2013-2017 RIADVICE <ghazi.triki@riadvice.tn>

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
package com.riadvice.starlingmvc.wings.net
{

    public interface IWingsServiceProxy
    {
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  gateway
        //----------------------------------
        function get gateway() : String;
        function set gateway( value : String ) : void;

        //----------------------------------
        //  endPoint
        //----------------------------------
        function get endPoint() : String;
        function set endPoint( value : String ) : void;

        //----------------------------------
        //  glue
        //----------------------------------
        function get glue() : String;
        function set glue( value : String ) : void;

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        function invoke( mathod : String, responder : IWingsResponder, ... args ) : void;
    }
}
