# StarlingMVC-wings Framework #
------------

StarlingMVC-wings is an IOC framework layered on [Starling Framework](http://gamua.com/starling/) and [Starling-MVC](htp://starlingMVC.org/) with most common utils for game and application developement for desktop and mobile. It adds the this features to StarlingMVC :
* XML Configuration for Starling instance creation.
* XML Configuration to configure Starling-MVC beans.
* Maps Starling Event.TRIGGERED with a custom event.
* Create Views content and position them.
* Plays load and unload tweens for views.
* Plays tweens for view children.
* Automatically loads textures for Starling Image and Button.

StarlingMVC-wings Framework is provided under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0).

## Requirements ##
------------
* [AIR SDK 3.7 with ActionScript Compiler 2.0](http://www.adobe.com/devnet/air/air-sdk-download.html)
* [Starling 1.3](http://gamua.com/starling/)
* [Starling-MVC 1.1](http://starlingMVC.org/)
* [feathers 1.0.1](http://feathersui.com/)

## Contributors ##
------------
* [Ghazi Triki](mailto:ghazi.nocturne@gmail.com)

Setup
------------
Getting your Starling project configured to work with StarlingMVC-wings requires only a few lines of code. From your base application display root class, you need to add one line containing your XML file.

```as3
package
{
    public class MyApp extends WingsApplication
    {
        [Embed(source = "/../resources/xml/wings.xml", mimeType = "application/octet-stream")]
        public static const XML_WINGS : Class;

        override protected function init() : void
        {
            Wings.fly(XML(new XML_WINGS()));
            super();
        }
    }
}
```
The line above will tell to Wings to load all the configuration and it will process the configuration to create for you the Starling and StarlingMVC instances with all your configuration.

Note : Context should be loaded in init method, this ensures that application is added already added to stage.

## Application Context ##
------------

### application tag ###
------------

```xml

	<?xml version="1.0" encoding="UTF-8"?>
	<wings>
	<application width="800"
				 height="600"
				 container="com.company.MainContainerClass"
				 appId="99D07B07-81BC-42C2-8EAB-D071C75F5523"
				 version="1.0.2"
				 handleLostContext="true"
                 multitouchEnabled="false"
                 pixelPerfect="false" 
                 theme="feathers.themes.MetalWorksMobileTheme"/>
	</wings>

```

The application tag is the only mandatory tag and contains the following properties :

- **width** : the width of the SWF.
- **height** the height of the SWF.
- **container** : the main container display class should implement IWingsContainer. A default implementation exists as WingsContainer class.
- *appId* : the application UID.
- *version* : the application version.
- *handleLostContext* : set the value of Starling.handleLostContext
- *multitouchEnabled* : set the value of Starling.multitouchEnabled
- *pixelPerfect* : set the value of Starling.pixelPerfect
- *theme* : if the application uses Feathers components, a theme class should be defined.

### eventPackages tag ###
------------

```xml

    <eventPackages>
        <eventPackage>com.company.events</eventPackage>
    </eventPackages>

```

eventPackages contains a list of packages that contain Event Catalog classes. Event Catalog class does not inherit com.starling.Event class but it contains static constants that declares and defines dispatched event names.

An event catalog class can be :

```as3

	public final class SocialSupporterEvents
    {
        public static const CONFIG_APP : String = "configApp";
        public static const INIT_SESSION : String = "initSession";
		public static const NAVIGATE_TO_LANDING : String = "goToLanding";
		public static const CLOSE_APPLICATION : String = "closeApplication";
	}

```

### viewPackages tag ###
------------

```xml

    <viewPackages>
        <viewPackage>com.company.views</viewPackage>
    </viewPackages>

```

### commandPackages tag ###
------------

```xml

    <commandPackages>
        <commandPackage>com.company.commands</commandPackage>
    </commandPackages>

```

### beans tag ###
------------

```xml

	<beans>
        <!-- Models -->
        <bean class="com.company.models.ModelEasy" id="modelEasy">
            <properties>
                <property name="hit" value="5"/>
            </properties>
        </bean>
        <bean class="com.company.models.UserModel" id="model"/>
        <!-- Service classes -->
        <bean class="com.company.GameServiceProxy" id="service">
            <properties>
                <property name="gateway" value="http://company.com/webservice/"/>
                <property name="endPoint" value="GameService"/>
                <property name="glue" value="."/>
            </properties>
        </bean>
        <bean class="com.atelier216.est.socialsupporter.net.SocialSupporterDelegateResponder" id="responder"/>
        <!-- Views -->
        <bean class="com.company.LandingView" id="landingView"/>
		<bean class="com.company.views.GameView" id="gameView"/>
    </beans>

```

### commands tag ###
------------

```xml

 	<commands>
		<command class="ConfigAppCommand" event="CONFIG_APP"/>
		<command class="InitSessionCommand" event="INIT_SESSION"/>
        <command class="NavigateToLandingCommand" event="NAVIGATE_TO_LANDING"/>
        <command class="ExitCommand" event="CLOSE_APPLICATION"/>
    </commands>

```

### triggers tag ###
------------


```xml

	<triggers>
        <trigger button="buttonQuit" event="CLOSE_APPLICATION" data="confirm"/>
        <!-- Language sounds -->
        <trigger button="btnEnglish" event="CHANGE_LANGUAGE"
                 data="EN"/>
	</triggers>


```

### navigation tag ###
------------

### resources tag ###
------------

## View Context ##
------------