/*
   Copyright (C) 2013-2016 RIADVICE <ghazi.triki@riadvice.tn>

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
package com.riadvice.starlingmvc.wings.utils
{
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;

    public final class FileUtils
    {
		/**
		 * The method readBytes accepts the ByteArray to fill as its parameter.
		 */
        public static function readBinaryFile( file : File ) : ByteArray
        {
            var stream : FileStream = new FileStream();
            stream.open(file, FileMode.READ);
            var fileBytes : ByteArray = new ByteArray();
            stream.readBytes(fileBytes);
            return fileBytes;
        }

        public static function writeBinaryFile( name : String, array : ByteArray ) : String
        {
            try
            {
                var f : File = File.documentsDirectory.resolvePath(name);
                var fs : FileStream = new FileStream();
                fs.open(f, FileMode.WRITE);
                fs.writeBytes(array);
                fs.close();
                return f.nativePath + " written.";
            }
            catch ( err : Error )
            {
                return err.name;
            }
            return "Error writing file.";
        }

        public static function readTextFile( file : File ) : String
        {
            var stream : FileStream = new FileStream();
            stream.open(file, FileMode.READ);
            var s : String = stream.readUTFBytes(stream.bytesAvailable);
            return s;
        }

        public static function writeTextFile( name : String, text : String ) : String
        {
            try
            {
                var f : File = File.documentsDirectory.resolvePath(name);
                var fs : FileStream = new FileStream();
                fs.open(f, FileMode.WRITE);
                fs.writeUTFBytes(text);
                fs.close();
                return f.nativePath + " written.";
            }
            catch ( err : Error )
            {
                return err.name;
            }
            return "Error writing file.";
        }

        public static function writeTextFileFile( file : File, text : String ) : String
        {
            try
            {
                var fs : FileStream = new FileStream();
                fs.open(file, FileMode.WRITE);
                fs.writeUTFBytes(text);
                fs.close();
                return file.nativePath + " written.";
            }
            catch ( err : Error )
            {
                return err.name;
            }
            return "Error writing file.";
        }
    }
}
