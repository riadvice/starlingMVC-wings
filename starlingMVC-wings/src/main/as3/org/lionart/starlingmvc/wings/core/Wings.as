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
package org.lionart.starlingmvc.wings.core
{
    import com.creativebottle.starlingmvc.StarlingMVC;
    import com.creativebottle.starlingmvc.beans.Bean;
    import com.creativebottle.starlingmvc.commands.Command;
    import com.creativebottle.starlingmvc.config.StarlingMVCConfig;

    import flash.display.Stage;
    import flash.utils.getDefinitionByName;

    import org.lionart.starlingmvc.wings.application.IApplication;

    import starling.core.Starling;
    import starling.display.DisplayObjectContainer;

    use namespace wings_internal;

    public class Wings
    {
        //--------------------------------------------------------------------------
        //
        //  Class variables
        //
        //--------------------------------------------------------------------------

        private static var mainApp : IApplication;
        private static var wingsXML : XML;
        private static var wingsConfig : WingsConfig;

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * Fly method takes and an XML configuration for the application
         * and it will configure starling, starlingMVC beans, commands, remote
         * configuration, app size...
         */
        public static function fly( xmlConfig : XML ) : void
        {
            wingsXML = xmlConfig;
        }

        wings_internal static function registerApp( app : IApplication ) : void
        {
            mainApp = app;
        }

        wings_internal static function initStarling( stage : Stage ) : Starling
        {
            var starlingInstance : Starling = new Starling(getContainerClass(), stage);
            return starlingInstance;
        }

        wings_internal static function initStarlingMVC( container : DisplayObjectContainer ) : StarlingMVC
        {
            var nodeList : XMLList;
            var node : XML;

            wingsConfig = new WingsConfig;

            // commandPackages
            nodeList = XMLList(wingsXML.commandPackages.commandPackage).text();
            for each (node in nodeList)
            {
                wingsConfig.commandPackages.push(node.toString());
            }

            var config : StarlingMVCConfig = new StarlingMVCConfig();

            // eventPackages
            nodeList = XMLList(wingsXML.eventPackages.eventPackage).text();
            for each (node in nodeList)
            {
                config.eventPackages.push(node.toString());
            }

            // eventPackages
            nodeList = XMLList(wingsXML.viewPackages.viewPackage).text();
            for each (node in nodeList)
            {
                config.viewPackages.push(node.toString());
            }

            // beans
            var beans : Array = [];
            var beanInstance : *;
            var props : XMLList;
            var property : XML;

            // Main container bean
            beans.push(container, "container");

            nodeList = XMLList(wingsXML.beans.bean);
            for each (node in nodeList)
            {
                beanInstance = new (getDefinitionByName(node.@type.toString()) as Class)();
                props = node.properties.property;
                for each (property in props)
                {
                    beanInstance[property.@name.toString()] = property.@value.toString();
                }
                beans.push(new Bean(beanInstance, node.@id));
            }

            // commands
            var clazz : Class = getDefinitionByName(wingsXML.commands.@eventsClass) as Class;
            nodeList = XMLList(wingsXML.commands.command);
            for each (node in nodeList)
            {
                beans.push(new Command(clazz[node.@event], getCommandClass(node.@type), node.@oneTime));
            }

            return new StarlingMVC(container, config, beans);
        }

        //--------------------------------------------------------------------------
        //
        //  XML processing methods
        //
        //--------------------------------------------------------------------------

        private static function getContainerClass() : Class
        {
            return getDefinitionByName(wingsXML.application[0].@container) as Class;
        }

        private static function getCommandClass( commandClassName : String ) : Class
        {
            var commandClass : Class;

            for each (var pack : String in wingsConfig.commandPackages)
            {
                try
                {
                    commandClass = Class(getDefinitionByName(pack + "." + commandClassName));
                    return commandClass;
                }
                catch ( e : Error )
                {
                    trace("CommandClass not found in package. Checking next package.");
                }
            }

            return null;
        }

    }
}
