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
package com.riadvice.starlingmvc.wings.processors
{
    import com.riadvice.starlingmvc.wings.utils.ClassUtils;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.utils.AssetManager;

    public class AssetProcessor
    {

        private var assetClasses : Array = null;

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * Processes the resources portion of the xml configuration.
         */
        public function processResources( xml : XMLList, assetManager : AssetManager ) : void
        {
            assetClasses = [];
            for each (var assetClass : XML in xml[0].assetClass)
            {
                var clazz : Class = ClassUtils.getDefinitionByNameOrNull(assetClass);
                assetClasses.push(clazz);
            }
            processAtlases(xml, assetManager);
            assetClasses = null;
        }

        /**
         * Registers atlases.
         */
        protected function processAtlases( xml : XMLList, assetManager : AssetManager ) : void
        {
            for each (var atlas : XML in xml[0].atlas)
            {
                for each (var clazz : Class in assetClasses)
                {
                    if (clazz.hasOwnProperty(atlas.@bitmap))
                    {
                        assetManager.addTextureAtlas(atlas.@name, new TextureAtlas(Texture.fromBitmap(new clazz[atlas.@bitmap]()), new XML(new clazz[atlas.@xml]())));
                        break;
                    }
                    else if (clazz.hasOwnProperty(atlas.@atf))
                    {
                        assetManager.addTextureAtlas(atlas.@name, new TextureAtlas(Texture.fromAtfData(new clazz[atlas.@bitmap]()), new XML(new clazz[atlas.@xml]())));
                        break;
                    }
                }
            }
        }
    }
}
