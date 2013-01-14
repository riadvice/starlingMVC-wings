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

    import flash.display.Sprite;
    import flash.events.Event;

    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.core.wings_internal;

    import starling.core.Starling;
    import starling.events.Event;

    public class WingsApplication extends Sprite implements IApplication, IWingsApplication
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _starling : Starling;
        private var _xmlWings : XML;
        private var _mainScreen : Class;
        private var _autoScale : Boolean;

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function WingsApplication()
        {
            super();

            Wings.wings_internal::registerApp(this);

            if (stage != null)
            {
                init();
            }
            else
            {
                addEventListener(flash.events.Event.ADDED_TO_STAGE, initHandler);
            }
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  xmlWings
        //----------------------------------

        public function get xmlWings() : XML
        {
            return _xmlWings;
        }

        public function set xmlWings( value : XML ) : void
        {
            _xmlWings = value;
        }

        //----------------------------------
        //  starling
        //----------------------------------

        public function get starling() : Starling
        {
            return _starling;
        }

        public function set starling( value : Starling ) : void
        {
            _starling = value;
        }

        //----------------------------------
        //  mainScreen
        //----------------------------------

        /**
         * Main screen class that will be used by starling to intialise itself
         */
        public function get mainScreen() : Class
        {
            return _mainScreen;
        }

        //----------------------------------
        //  autoScale
        //----------------------------------

        /**
         * Autoscales the root sprite at startup for mobile application
         */
        public function get autoScale() : Boolean
        {
            return _autoScale;
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        protected function init() : void
        {
            _starling = new Starling(_mainScreen, stage);
            _starling.addEventListener(starling.events.Event.ROOT_CREATED, rootCreatedHandler);
            _starling.start();
        }

        //--------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //--------------------------------------------------------------------------

        protected function initHandler( e : flash.events.Event = null ) : void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
            init();
        }

        protected function rootCreatedHandler( event : starling.events.Event ) : void
        {
            _starling.removeEventListener(starling.events.Event.ROOT_CREATED, rootCreatedHandler);
        }

    }
}
