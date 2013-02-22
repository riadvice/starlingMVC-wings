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
package org.lionart.starlingmvc.wings.processors
{
    import flash.display.Stage;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    import flash.utils.getDefinitionByName;

    import org.lionart.starlingmvc.wings.core.Wings;

    import starling.core.Starling;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;

    public class StarlingProcessor
    {
        public function processStarling( appXML : XML, stage : Stage ) : Starling
        {
            var viewPort : Rectangle;
            Starling.handleLostContext = appXML.@handleLostContext == "true";
            Starling.multitouchEnabled = appXML.@multitouchEnabled == "true";
            if (Wings.isMobileApp)
            {
                // not necessary on iOS. Saves a lot of memory!
                if (Capabilities.manufacturer.indexOf("iOS") > -1)
                {
                    Starling.handleLostContext = false;
                }

                // create a suitable viewport for the screen size
                // 
                // we develop the game in a *fixed* coordinate system; the game might 
                // then run on a device with a different resolution; for that case, we zoom the 
                // viewPort to the optimal size for any display and load the optimal textures.

                viewPort = RectangleUtil.fit(
                    new Rectangle(0, 0, Wings.appWidth, Wings.appHeight),
                    new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
                    ScaleMode.SHOW_ALL, appXML.@pixelPerfect == "true");
            }


            // TODO : add splash screen

            var _starling : Starling = new Starling(getDefinitionByName(appXML.@container) as Class, stage, viewPort);

            if (Wings.isMobileApp)
            {
                _starling.stage.stageWidth = Wings.appWidth;
                _starling.stage.stageHeight = Wings.appHeight;
                // TODO must be simulated if running in desktop
                _starling.simulateMultitouch = false;
            }

            _starling.enableErrorChecking = Capabilities.isDebugger;

            return _starling;
        }



    }
}
