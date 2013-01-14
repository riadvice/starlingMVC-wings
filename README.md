StarlingMVC-wings Framework
===========

StarlingMVC-wings is an IOC framework layered on [Starling Framework](http://gamua.com/starling/) and [Starling-MVC](htp://starlingMVC.org/) with most common utils for game and application developement for desktop and mobile. It adds the this features to StarlingMVC :
* XML Configuration for Starling instance creation.
* XML Configuration to configure Starling-MVC beans.
* Maps Starling Event.TRIGGERED with a custom event.
* Create Views content and position them.
* Plays load and unload tweens for views.
* Plays tweens for view children.
* Automatically loads textures for Starling Image and Button.

StarlingMVC-wings Framework is provided under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0).

Requirements
------------
* [AIR SDK 3.5 with ActionScript Compiler 2.0](http://labs.adobe.com/technologies/asc2/)
* [Starling 1.3](http://gamua.com/starling/)
* [Starling-MVC](htp://starlingMVC.org/)

Contributors
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

        public function MyApp()
        {
            Wings.fly(XML(new XML_WINGS()));
            super();
        }
    }
}
```

The line above will tell to Wings to load all the configuration and it will process the configuration to create for you the Starling and StarlingMVC instances with all your configuration.