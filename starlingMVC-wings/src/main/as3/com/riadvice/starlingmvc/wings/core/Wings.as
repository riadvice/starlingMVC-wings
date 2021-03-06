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
package com.riadvice.starlingmvc.wings.core
{
    import com.creativebottle.starlingmvc.StarlingMVC;
    import com.creativebottle.starlingmvc.beans.Bean;
    import com.creativebottle.starlingmvc.beans.Beans;
    import com.creativebottle.starlingmvc.config.StarlingMVCConfig;

    import flash.display.Stage;
    import flash.net.registerClassAlias;
    import flash.utils.getDefinitionByName;

    import org.as3commons.lang.StringUtils;
    import com.riadvice.starlingmvc.wings.application.IApplication;
    import com.riadvice.starlingmvc.wings.bean.IBean;
    import com.riadvice.starlingmvc.wings.container.IWingsContainer;
    import com.riadvice.starlingmvc.wings.container.IWingsFeathersContainer;
    import com.riadvice.starlingmvc.wings.layout.LayoutManager;
    import com.riadvice.starlingmvc.wings.net.WingsServiceProxy;
    import com.riadvice.starlingmvc.wings.processors.*;
    import com.riadvice.starlingmvc.wings.sound.SoundManager;
    import com.riadvice.starlingmvc.wings.utils.ClassUtils;

    import starling.core.Starling;
    import starling.display.DisplayObjectContainer;
    import starling.events.Event;
    import starling.utils.AssetManager;

    use namespace wings_internal;

    /** The Wings class represents the core of the Wings framework.
     *
     *  <p>The Wings framework wraps Starling and StarlingMVC frameworks and makes
     *  their configuration easier for developers.</p>
     *
     *  <p>To create a Wings-powered application, you only have to call the static
     *  fly methods of the Wings class:</p>
     *
     *  <pre>Wings.fly(new XML_WINGS() as XML);</pre>
     *
     */
    public class Wings
    {
        //--------------------------------------------------------------------------
        //
        //  Class variables
        //
        //--------------------------------------------------------------------------

        public static var mainApp : IApplication;
        private static var _assetManager : AssetManager;

        private static var wingsXML : XML;
        private static var wingsConfig : WingsConfig;
        private static var starlingMVCContainer : IWingsContainer;
        private static var viewProcessor : ViewProcessor = new ViewProcessor();
        private static var tweenProcessor : TweenProcessor = new TweenProcessor();
        private static var styleProcessor : StyleProcessor = new StyleProcessor();
        private static var screensProcessor : ScreenNavigatorProcessor = new ScreenNavigatorProcessor();

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
            wingsConfig.eventClass = ClassUtils.getDefinitionByNameOrNull(wingsXML.eventClass);
            configProcessor = null;

            WingsServiceProxy.registerRemoteClasses();
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
         * Initialises Assets classes like Texures and Sounds.
         */
        wings_internal static function initAssets() : void
        {
            _assetManager = new AssetManager();

            if (wingsXML.hasOwnProperty('resources'))
            {
                var assetProcessor : AssetProcessor = new AssetProcessor();
                assetProcessor.processResources(wingsXML.resources, _assetManager);
                assetProcessor = null;
            }
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
            beans.push(new Bean(layoutManager, "layoutManager"));

            starlingMVCProcessor.processBeans(wingsXML.beans.bean, wingsXML.commands, beans);

            var starlingMVC : StarlingMVC = new StarlingMVC(container, config, beans);

            // Inject dispatcher to SoundManager
            SoundManager.getInstance()["dispatcher"] = container["dispatcher"];

            wings_internal::initLayout(layoutManager);

            return starlingMVC;
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
                starlingMVCContainer.dispatchEventWith(wingsConfig.eventClass[trigger.@event], false, trigger.@data.toString());
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

        wings_internal static function initTheme() : void
        {
            if (!StringUtils.isEmpty(wingsXML.application.@theme.toString()))
            {
                starlingMVCContainer.theme = new (getDefinitionByName(wingsXML.application.@theme) as Class)(starlingMVCContainer["stage"], wingsXML.application.@scaleThemeToDPI.toString() == "true");
            }
        }

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
            tweenProcessor.playTweens(starlingMVCContainer.starlingMVC.beans.getBeanById(beanId).instance as DisplayObjectContainer, xmlData.transitions.transition.(attribute("id") == transitionName).children(), type);
        }

        wings_internal static function initTransitionManager() : void
        {
            screensProcessor.processTransitionManager(wingsXML.navigation, IWingsFeathersContainer(starlingMVCContainer));
        }

        wings_internal static function initScreens() : void
        {
            screensProcessor.processScreens(wingsXML.navigation.view, IWingsFeathersContainer(starlingMVCContainer));
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  appWidth
        //----------------------------------
        public static function get assetManager() : AssetManager
        {
            return _assetManager;
        }

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
        //  appId
        //----------------------------------
        public static function get appId() : String
        {
            return config.appId;
        }

        //----------------------------------
        //  version
        //----------------------------------
        public static function get version() : String
        {
            return config.version;
        }

        //----------------------------------
        //  isMobileApp
        //----------------------------------
        public static function get isMobileApp() : Boolean
        {
            return ClassUtils.implementsInteface(mainApp, "com.riadvice.starlingmvc.wings.application::IWingsMobileApplication");
        }

        //----------------------------------
        //  beans
        //----------------------------------
        wings_internal static function beans() : Beans
        {
            return starlingMVCContainer.starlingMVC.beans;
        }

    }
}
