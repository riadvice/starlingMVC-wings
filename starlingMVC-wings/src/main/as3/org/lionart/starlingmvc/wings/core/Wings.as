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
    import com.creativebottle.starlingmvc.config.StarlingMVCConfig;

    import flash.display.Stage;
    import flash.utils.getDefinitionByName;

    import org.lionart.starlingmvc.wings.application.IApplication;
    import org.lionart.starlingmvc.wings.bean.IBean;
    import org.lionart.starlingmvc.wings.container.IWingsContainer;
    import org.lionart.starlingmvc.wings.net.WingsServiceProxy;
    import org.lionart.starlingmvc.wings.processors.AssetProcessor;
    import org.lionart.starlingmvc.wings.processors.ConfigurationProcessor;
    import org.lionart.starlingmvc.wings.processors.StarlingMVCProcessor;
    import org.lionart.starlingmvc.wings.ui.AssetLoader;

    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Image;

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
        private static var starlingMVCContainer : IWingsContainer;

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

            var configProcessor : ConfigurationProcessor = new ConfigurationProcessor();
            wingsConfig = configProcessor.processConfiguration(wingsXML.application);
            configProcessor = null;

            // TODO : update for Starling 1.3 using AssetManager
            var assetProcessor : AssetProcessor = new AssetProcessor();
            assetProcessor.processResources(wingsXML.resources);
            assetProcessor = null;

            WingsServiceProxy.registerRemoteClasses();
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
            var starlingMVCProcessor : StarlingMVCProcessor = new StarlingMVCProcessor();

            var nodeList : XMLList;
            var node : XML;

            // commandPackages
            nodeList = XMLList(wingsXML.commandPackages.commandPackage).text();
            for each (node in nodeList)
            {
                wingsConfig.commandPackages.push(node.toString());
            }

            var config : StarlingMVCConfig = starlingMVCProcessor.processConfig(wingsXML.eventPackages.eventPackage, wingsXML.viewPackages.viewPackage);

            // beans
            var beans : Array = [];

            // Main container bean
            starlingMVCContainer = container as IWingsContainer;
            IBean(container).beanId = "container";
            beans.push(new Bean(container, "container"));

            starlingMVCProcessor.processBeans(wingsXML.beans.bean, wingsXML.commands, beans);

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

        wings_internal static function getCommandClass( commandClassName : String ) : Class
        {
            for each (var pack : String in wingsConfig.commandPackages)
            {
                try
                {
                    return getDefinitionByName(pack + "." + commandClassName) as Class;
                }
                catch ( e : Error )
                {
                    trace("CommandClass not found in package. Checking next package.");
                }
            }

            return null;
        }

        //--------------------------------------------------------------------------
        //
        //  Views processing methods
        //
        //--------------------------------------------------------------------------

        wings_internal static function createViewElements( beanId : String ) : void
        {
            var bean : Bean = starlingMVCContainer.starlingMVC.beans.getBeanById(beanId);
            var viewNode : XMLList = wingsXML.views.view.(attribute("id") == beanId) as XMLList;
            var node : XML;
            var displayObject : DisplayObject;
            for each (node in viewNode.children.element)
            {
                switch (node.@type.toString())
                {
                    case "image":
                        displayObject = new Image(AssetLoader.getAtlas(node.@atlas).getTexture(node.@texture));
                        displayObject.name = node.@name;
                        break;
                    case "button":
                        displayObject = new Button(AssetLoader.getAtlas(node.@atlas).getTexture(node.@texture));
                        displayObject.name = node.@name;
                        break;
                    default:
                        break;
                }

                bean.instance.addChild(displayObject);
            }
        }

    }
}
