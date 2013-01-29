<?php

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

class WingsAutoloader
{
    private static $loader;

    public static function loadClassLoader( $class )
    {
        if ( 'WingsClassLoader' === $class )
        {
            require __DIR__ . '/WingsClassLoader.php';
        }
    }

    public static function getLoader()
    {
        if ( null !== self::$loader )
        {
            return self::$loader;
        }
        
        spl_autoload_register( array(
                'WingsAutoloader',
                'loadClassLoader' ) );
        self::$loader = $loader = new WingsClassLoader();
        spl_autoload_unregister( array(
                'WingsAutoloader',
                'loadClassLoader' ) );
        
        $vendorDir = dirname( __DIR__ );
        $baseDir = dirname( $vendorDir );
        
        $classMap = require __DIR__ . '/wings_autoload_classmap.php';
        if ( $classMap )
        {
            $loader->addClassMap( $classMap );
        }
        
        $loader->register();
        
        return $loader;
    }

}
