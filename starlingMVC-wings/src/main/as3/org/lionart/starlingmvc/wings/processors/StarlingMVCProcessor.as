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
    import com.creativebottle.starlingmvc.beans.Bean;
    import com.creativebottle.starlingmvc.commands.Command;
    import com.creativebottle.starlingmvc.config.StarlingMVCConfig;

    import flash.utils.getDefinitionByName;

    import org.as3commons.lang.ClassUtils;
    import org.lionart.starlingmvc.wings.bean.IBean;
    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.core.wings_internal;

    public class StarlingMVCProcessor
    {
        public function processConfig( eventsXML : XMLList, viewsXML : XMLList ) : StarlingMVCConfig
        {
            var config : StarlingMVCConfig = new StarlingMVCConfig();
            var node : XML;
            // eventPackages
            for each (node in eventsXML)
            {
                config.eventPackages.push(node.toString());
            }

            // eventPackages
            for each (node in viewsXML)
            {
                config.viewPackages.push(node.toString());
            }
            return config;
        }

        public function processBeans( xmlBeans : XMLList, xmlCommands : XMLList, beans : Array ) : void
        {
            var node : XML;
            var beanInstance : *;
            var props : XMLList;
            var property : XML;
            for each (node in xmlBeans)
            {
                var args : Array;
                if (node.constructor)
                {
                    args = [];
                    for each (var arg : XML in node.constructor.arg)
                    {
                        if (arg.attribute("type") == "bean")
                        {
                            args.push(beans.filter(function( obj : *, index : int, array : Array ) : Boolean {return arg.@id.toString() == Bean(obj).id})[0].instance);
                        }
                        else
                        {
                            args.push(arg.@value.toString());
                        }
                    }
                }
                beanInstance = ClassUtils.newInstance(getDefinitionByName(node.attribute("class").toString()) as Class, args);
                props = node.properties.property;
                for each (property in props)
                {
                    beanInstance[property.@name.toString()] = property.@value.toString();
                }
                if (beanInstance is IBean)
                {
                    IBean(beanInstance).beanId = node.@id;
                }
                beans.push(new Bean(beanInstance, node.@id));
            }

            // commands
            var clazz : Class = getDefinitionByName(xmlCommands.@eventsClass) as Class;
            for each (node in xmlCommands.command)
            {
                beans.push(new Command(clazz[node.@event], Wings.wings_internal::getCommandClass(node.attribute("class")), node.@oneTime));
            }
        }
    }
}
