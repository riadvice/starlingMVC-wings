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

    import org.as3commons.lang.StringUtils;
    import org.lionart.starlingmvc.wings.bean.IBean;
    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.core.wings_internal;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.EventDispatcher;

    use namespace wings_internal;

    public class WingsContainer extends Sprite implements IContainer, IWingsContainer, IBean
    {

        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        [Dispatcher]
        public var dispatcher : EventDispatcher;

        private var _starlingMVC : StarlingMVC;
        private var _beanId : String;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function WingsContainer()
        {
            super();
            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            _starlingMVC = Wings.wings_internal::initStarlingMVC(this);
            Wings.wings_internal::mapCommandEvents();
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

        public function preTriggerExecution() : void
        {

        }

        //--------------------------------------------------------------------------
        //
        //  Event Handlers
        //
        //--------------------------------------------------------------------------

        protected function addedToStageHandler( event : Event ) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }

        public function onTriggerEventHandler( event : Event ) : void
        {

        }

    }
}
