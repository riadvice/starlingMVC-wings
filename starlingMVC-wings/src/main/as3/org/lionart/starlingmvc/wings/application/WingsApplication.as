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

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;

    import avmplus.getQualifiedClassName;

    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.core.wings_internal;

    import starling.core.Starling;
    import starling.events.Event;

    /**
     * Base Wings application class. It contains a Starling instance.
     */
    public class WingsApplication extends Sprite implements IApplication, IWingsApplication
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _starling : Starling;
        private var _version : String;
        private var _xmlWings : XML;
        private var _mainScreen : Class;

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
        //  version
        //----------------------------------

        public function get version() : String
        {
            return _version;
        }

        public function set version( value : String ) : void
        {
            _version = value;
        }

        //----------------------------------
        //  mainScreen
        //----------------------------------

        public function get mainScreen() : Class
        {
            return _mainScreen;
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * Application XML is processed then a Starling insance is created.
         */
        protected function init() : void
        {
            wings_internal::removeObfuscationWatermark();
            _starling = Wings.wings_internal::initStarling(stage);
            _starling.addEventListener(starling.events.Event.ROOT_CREATED, rootCreatedHandler);
        }

        //--------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //--------------------------------------------------------------------------

        /**
         * When the application is added to stage when initialise it.
         */
        protected function initHandler( e : flash.events.Event = null ) : void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
            init();
        }

        /**
         * When the starling root is created we start our Starling instance.
         */
        protected function rootCreatedHandler( event : starling.events.Event ) : void
        {
            _starling.removeEventListener(starling.events.Event.ROOT_CREATED, rootCreatedHandler);
            _starling.start();
        }

        /**
         * Removes the obfuscation watermarke of the software.
         */
        wings_internal function removeObfuscationWatermark() : void
        {
            var child : DisplayObject;
            var toRemove : Array = [];
            for (var i : int = 0; i < numChildren; i++)
            {
                child = getChildAt(i);
                if (getQualifiedClassName(child) == "flash.text::TextField" || getQualifiedClassName(child) == "flash.display::Shape")
                {
                    // Watermark DisplayObjects are generated with widths below
                    if (child.width == 185.55 || child.width == 203.9)
                    {
                        toRemove.push(child);
                    }
                }
            }

            for each (child in toRemove)
            {
                removeChild(child);
                child = null;
            }
        }

    }
}
