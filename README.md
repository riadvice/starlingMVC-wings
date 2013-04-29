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

The application tag is mandatory and contains the following properties :

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

### viewPackages tag ###
------------

### commandPackages tag ###
------------

### application tag ###
------------

### beans tag ###
------------

### commands tag ###
------------

### triggers tag ###
------------

### navigation tag ###
------------

### resources tag ###
------------

## View Context ##
------------