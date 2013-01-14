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
package org.lionart.starlingmvc.wings.ui
{
    import flash.display.Bitmap;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public final class AssetLoader
    {

        //--------------------------------------------------------------------------
        //
        //  Class constants
        //
        //--------------------------------------------------------------------------

        public static const BITMAP : String = "BMP";
        public static const ATF : String = "ATF";

        //--------------------------------------------------------------------------
        //
        //  Class properties
        //
        //--------------------------------------------------------------------------


        /**
         * Image assets class.
         */
        private static var _imageClass : Class;

        /**
         * Movie clip assets class.
         */
        private static var _movieClipClass : Class;

        /**
         * Sound assets class.
         */
        private static var _soundClass : Class;

        /**
         * Texture Cache
         */
        private static var _textures : Dictionary;

        /**
         * Texture Cache loaded from URLs
         */
        private static var urlTextures : Dictionary;

        /**
         * TextureAtlas Cache
         */
        private static var gameTextureAtlas : Dictionary;

        //--------------------------------------------------------------------------
        //
        //  Class methods
        //
        //--------------------------------------------------------------------------


        public static function setConfig( imageClass : Class = null, movieClipClass : Class = null, soundClass : Class = null ) : void
        {
            _imageClass = imageClass;
            _movieClipClass = movieClipClass;
            _soundClass = soundClass;
        }

        /**
         * Returns the Texture atlas instance.
         * @return the TextureAtlas instance (there is only oneinstance per app)
         */
        public static function getAtlas( atlas : String ) : TextureAtlas
        {
            gameTextureAtlas ||= new Dictionary();
            if (gameTextureAtlas[atlas] == undefined)
            {
                var texture : Texture = getTexture(atlas);
                var xml : XML = XML(new _imageClass[atlas + "_XML"]());
                gameTextureAtlas[atlas] = new TextureAtlas(texture, xml);
            }

            return gameTextureAtlas[atlas];
        }

        /**
         * Returns a texture from this class based on a string key.
         *
         * @param name A key that matches a static constant of Bitmap type.
         * @return a starling texture.
         */
        public static function getTexture( name : String, type : String = "ATF" ) : Texture
        {
            _textures ||= new Dictionary();
            if (_textures[name] == undefined)
            {
                if (type == BITMAP)
                {
                    var bmp : Bitmap = new _imageClass[name]();
                    _textures[name] = Texture.fromBitmap(bmp);
                }
                else if (type == ATF)
                {
                    var atf : ByteArray = new _imageClass[name]();
                    _textures[name] = Texture.fromAtfData(atf, 1, false);
                }
            }
            return _textures[name];
        }

        public static function registerURLBitmap( url : String, bitamp : Bitmap ) : void
        {
            urlTextures ||= new Dictionary(true);
            if (urlTextures[url] == undefined)
            {
                urlTextures[url] = Texture.fromBitmap(bitamp);
            }
        }

        public static function getURLBitmap( url : String ) : Texture
        {
            if (urlTextures && urlTextures[url] != undefined)
            {
                return urlTextures[url];
            }
            return null;
        }

    }
}
