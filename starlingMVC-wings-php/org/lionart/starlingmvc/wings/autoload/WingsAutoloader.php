<?php

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
