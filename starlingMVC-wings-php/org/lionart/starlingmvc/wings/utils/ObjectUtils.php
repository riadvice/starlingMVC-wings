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
        $vo = new $class ();
        if (is_array ( $source ))
        {
            $source = ObjectUtils::arrayToObject ( $source );
        }
        foreach ( $mapping as $key => $value )
        {
            $vo->$value = $source->$key;
        }
        return $vo;
    }

    public static function arrayToObject( $source )
    {
        $obj = new stdClass ();
        foreach ( array_keys ( $source ) as $key )
        {
            $obj->$key = $source [$key];
        }
        return $obj;
    }

    public static function convertToArrayVO( $source, $class, $mapping )
    {
        $result = array ();
        foreach ( $source as $vo )
        {
            array_push ( $result, ObjectUtils::convertToVO ( $vo, $class, $mapping ) );
        }
        return $result;
    }

    public static function initArrayIfEmpty( &$array )
    {
        $array = ! empty ( $array ) ? $array : array (
                '-1' );
    }

    public static function implodeForQuery( $array )
    {
        ObjectUtils::initArrayIfEmpty ( $array );
        if (sizeof ( $array ) > 0)
        {
            return implode ( ',', $array );
        }
        else
        {
            return '-1';
        }
    }

    /**
     * Converts an AMF Date to PHP DateTime
     *
     * @param unknown_type $amfDate            
     * @return DateTime
     */
    public static function afmDateToDateTime( $amfDate )
    {
        $match_time = new DateTime ();
        $match_time->setTimestamp ( $amfDate->timeStamp / 1000 );
        return $match_time;
    }

    public static function currentDate( $timestamp = null )
    {
        $time = new DateTime ( $timestamp );
        return date ( 'Y-m-d H:i:s', $time->getTimestamp () );
    }

}

?>