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
package org.lionart.starlingmvc.wings.net
{
    import flash.net.Responder;

    import org.as3commons.lang.StringUtils;
    import org.lionart.starlingmvc.wings.bean.IBean;

    public class WingsResponder extends Responder implements IResponder, IWingsResponder, IBean
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _beanId : String;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function WingsResponder( result : Function = null, status : Function = null )
        {
            super(this.result, this.fault);
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  beanId
        //----------------------------------

        public function get beanId() : String
        {
            return _beanId;
        }

        public function set beanId( value : String ) : void
        {
            if (StringUtils.isEmpty(_beanId))
            {
                _beanId = value;
            }
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        public function result( data : Object ) : void
        {
            // To override
        }

        public function fault( info : Object ) : void
        {
            // To override
        }
    }
}
