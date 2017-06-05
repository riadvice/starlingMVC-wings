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
package com.riadvice.starlingmvc.wings.container
{
    import com.creativebottle.starlingmvc.StarlingMVC;

    import feathers.themes.StyleNameFunctionTheme;

    import starling.events.Event;

    /**
     * The interface definition for a explicit starlingMVC-wings Container.
     */
    public interface IWingsContainer
    {
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  starlingMVC
        //----------------------------------

        /**
         * StarlingMVC instance.
         */
        function get starlingMVC() : StarlingMVC;
        function set starlingMVC( value : StarlingMVC ) : void;

        //----------------------------------
        //  theme
        //----------------------------------

        /**
         * Feathers theme instance.
         */
        function get theme() : StyleNameFunctionTheme;
        function set theme( value : StyleNameFunctionTheme ) : void;

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        function addEventListener( type : String, listener : Function ) : void
        function dispatchEventWith( type : String, bubbles : Boolean = false, data : Object = null ) : void

        //----------------------------------
        //  eventHandlers
        //----------------------------------

        function preTriggerExecution() : void
        function onTriggerEventHandler( event : Event ) : void
    }
}
