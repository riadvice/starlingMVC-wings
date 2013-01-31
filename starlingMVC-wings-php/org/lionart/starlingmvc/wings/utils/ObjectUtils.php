<?php

class ObjectUtils
{

    /**
     * Transforms an object to a typed object
     *
     * @param stdObject $source            
     * @param class $class            
     * @param array $mapping            
     * @return ValueObject
     */
    public static function convertToVO( $source, $class, $mapping )
    {
        $vo = new $class();
        if ( is_array( $source ) )
        {
            $source = ObjectUtils::arrayToObject( $source );
        }
        foreach( $mapping as $key => $value )
        {
            $vo->$value = $source->$key;
        }
        return $vo;
    }

    public static function arrayToObject( $source )
    {
        $obj = new stdClass();
        foreach( array_keys( $source ) as $key )
        {
            $obj->$key = $source [$key];
        }
        return $obj;
    }

    public static function convertToArrayVO( $source, $class, $mapping )
    {
        $result = array();
        foreach( $source as $vo )
        {
            array_push( $result, ObjectUtils::convertToVO( $vo, $class, $mapping ) );
        }
        return $result;
    }

    public static function initArrayIfEmpty( &$array )
    {
        $array = ! empty( $array ) ? $array : array(
                '-1' );
    }

    public static function implodeForQuery( $array )
    {
        ObjectUtils::initArrayIfEmpty( $array );
        if ( sizeof( $array ) > 0 )
        {
            return implode( ',', $array );
        }
        else
        {
            return '-1';
        }
    }

    public static function copyProperties( $source, $destination )
    {
        if ( is_object( $source ) )
            foreach( get_object_vars( $source ) as $key => $value )
            {
                if ( $key != "_explicitType" )
                {
                    $destination->$key = $value;
                }
            }
        else if ( is_array( $source ) )
        {
            foreach( array_keys( $source ) as $key => $value )
            {
                if ( $value != "_explicitType" )
                {
                    $destination->$value = $source [$value];
                }
            }
        }
    }

}

?>