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
package com.riadvice.starlingmvc.wings.bean
{

    /**
     * Every bean class should implements this interface.
     * It will handle the unique bean id assigned in the
     * application XML descriptor.
     */
    public interface IBean
    {
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  beanId
        //----------------------------------

        /**
         * Unique bean id that will be assigned at runtime bean creation.
         * It is useful because when creating beans using Bean or ProtBean class
         * it will help us find the bean by its unique id.
         *
         * It should be implemented to be set only once by Wings.
         */
        function get beanId() : String;
        function set beanId( value : String ) : void;
    }
}
