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
    import flash.net.registerClassAlias;
    import flash.utils.getDefinitionByName;

    import org.as3commons.lang.StringUtils;
    import org.lionart.starlingmvc.wings.application.IApplication;
    import org.lionart.starlingmvc.wings.bean.IBean;
    import org.lionart.starlingmvc.wings.container.IWingsContainer;
    import org.lionart.starlingmvc.wings.layout.LayoutManager;
    import org.lionart.starlingmvc.wings.net.WingsServiceProxy;
    import org.lionart.starlingmvc.wings.processors.AssetProcessor;
    import org.lionart.starlingmvc.wings.processors.ConfigurationProcessor;
    import org.lionart.starlingmvc.wings.processors.LayoutProcessor;
    import org.lionart.starlingmvc.wings.processors.StarlingMVCProcessor;
    import org.lionart.starlingmvc.wings.processors.StarlingProcessor;
    import org.lionart.starlingmvc.wings.processors.StyleProcessor;
    import org.lionart.starlingmvc.wings.processors.TweenProcessor;
    import org.lionart.starlingmvc.wings.processors.ViewProcessor;
    import org.lionart.starlingmvc.wings.utils.ClassUtils;

    import starling.core.Starling;
    import starling.display.DisplayObjectContainer;
    import starling.events.Event;

    use namespace wings_internal;

    public class Wings
    {
        //--------------------------------------------------------------------------
        //
        //  Class variables
        //
        //--------------------------------------------------------------------------

        public static var mainApp : IApplication;

        private static var wingsXML : XML;
        private static var wingsConfig : WingsConfig;
        private static var starlingMVCContainer : IWingsContainer;
        private static var viewProcessor : ViewProcessor = new ViewProcessor();
        private static var tweenProcessor : TweenProcessor = new TweenProcessor();
        private static var styleProcessor : StyleProcessor = new StyleProcessor();

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
            wingsConfig.eventClass = ClassUtils.getDefinitionByNameOrNull(wingsXML.resources.eventClass);
            wingsConfig.textClass = ClassUtils.getDefinitionByNameOrNull(wingsXML.resources.textClass);
            configProcessor = null;

            // TODO : update for Starling 1.3 using AssetManager
            var assetProcessor : AssetProcessor = new AssetProcessor();
            assetProcessor.processResources(wingsXML.resources);
            assetProcessor = null;

            WingsServiceProxy.registerRemoteClasses();
            wings_internal::registerRemoteClasses();
        }


        /**
         * Registers the main application.
         */
        wings_internal static function registerApp( app : IApplication ) : void
        {
            mainApp = app;
        }

        /**
         * Initialises Starling.
         */
        wings_internal static function initStarling( stage : Stage ) : Starling
        {
            var starlingProcessor : StarlingProcessor = new StarlingProcessor();
            var starlingInstance : Starling = starlingProcessor.processStarling(wingsXML.application[0], stage);
            starlingProcessor = null;
            return starlingInstance;
        }

        wings_internal static function mapCommandEvents() : void
        {
            starlingMVCContainer.addEventListener(Event.TRIGGERED, onTriggerEventHandler);
        }

        /**
         * Initialises StarlingMVC.
         */
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

            // Layout manager bean
            var layoutManager : LayoutManager = new LayoutManager();
            beans.push(new Bean(container, "layoutManager"));

            wings_internal::initLayout(layoutManager);

            starlingMVCProcessor.processBeans(wingsXML.beans.bean, wingsXML.commands, beans);


            return new StarlingMVC(container, config, beans);
        }

        wings_internal static function initLayout( layoutManager : LayoutManager ) : void
        {
            var layoutProcessor : LayoutProcessor = new LayoutProcessor();
            layoutProcessor.processLayout(wingsXML.layout, starlingMVCContainer, layoutManager);
            layoutProcessor = null;
        }

        /**
         * Wings application configuration.
         */
        wings_internal static function get config() : WingsConfig
        {
            return wingsConfig;
        }

        //--------------------------------------------------------------------------
        //
        //  XML processing methods
        //
        //--------------------------------------------------------------------------


        //--------------------------------------------------------------------------
        //
        //  Global event handlers
        //
        //--------------------------------------------------------------------------

        private static function onTriggerEventHandler( event : Event ) : void
        {
            starlingMVCContainer.preTriggerExecution();
            var trigger : XMLList = wingsXML.triggers.trigger.(@button == event.target.name);
            if (!StringUtils.isEmpty(trigger.@event.toString()))
            {
                starlingMVCContainer.dispatchEventWith(wingsConfig.eventClass[trigger.@event]);
            }
            else
            {
                starlingMVCContainer.onTriggerEventHandler(event);
            }
        }

        wings_internal static function registerRemoteClasses() : void
        {
            var remoteClass : Class;
            var node : XML;
            for each (node in wingsXML.remoteClasses.remoteClass)
            {
                remoteClass = getDefinitionByName(node.text().toString()) as Class;
                registerClassAlias(node.text().toString(), remoteClass);
            }
        }

        //--------------------------------------------------------------------------
        //
        //  Views processing methods
        //
        //--------------------------------------------------------------------------

        wings_internal static function createViewElements( beanId : String ) : void
        {
            var xmlData : XML = starlingMVCContainer.starlingMVC.beans.getBeanById(beanId).instance.xmlWings || wingsXML;
            viewProcessor.createElements(starlingMVCContainer.starlingMVC.beans.getBeanById(beanId).instance as DisplayObjectContainer, xmlData.views.view.(attribute("id") == beanId) as XMLList);
        }

        wings_internal static function applyElementsStyle( beanId : String ) : void
        {
            var xmlData : XML = starlingMVCContainer.starlingMVC.beans.getBeanById(beanId).instance.xmlWings || wingsXML;
            styleProcessor.applyStyles(starlingMVCContainer.starlingMVC.beans.getBeanById(beanId).instance as DisplayObjectContainer, xmlData.views.view.(attribute("id") == beanId) as XMLList);
        }

        wings_internal static function playTransition( beanId : String, type : String ) : void
        {
            var xmlData : XML = starlingMVCContainer.starlingMVC.beans.getBeanById(beanId).instance.xmlWings || wingsXML;
            var transitionName : String = xmlData.views.view.(attribute("id") == beanId)["@" + type + "Transition"].toString();
            tweenProcessor.playTweens(starlingMVCContainer.starlingMVC.beans.getBeanById(beanId).instance as DisplayObjectContainer, xmlData.transitions.transition.(attribute("id") == transitionName).children());
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  appWidth
        //----------------------------------
        public static function get appWidth() : Number
        {
            return config.appWidth;
        }

        //----------------------------------
        //  appHeight
        //----------------------------------
        public static function get appHeight() : Number
        {
            return config.appHeight;
        }

        //----------------------------------
        //  isMobileApp
        //----------------------------------
        public static function get isMobileApp() : Boolean
        {
            return ClassUtils.implementsInteface(mainApp, "org.lionart.starlingmvc.wings.application::IWingsMobileApplication");
        }

    }
}
