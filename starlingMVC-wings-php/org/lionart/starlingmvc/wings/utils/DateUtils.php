<?php

class Dateutils
{

    public static function now()
    {
        return date( 'Y-m-d H:i:s' );
    }

    /**
     * Converts an AMF Date to PHP DateTime
     *
     * @param unknown_type $amfDate            
     * @return DateTime
     */
    public static function afmDateToDateTime( $amfDate )
    {
        $match_time = new DateTime();
        $match_time->setTimestamp( $amfDate->timeStamp / 1000 );
        return $match_time;
    }

    public static function currentDate( $timestamp = null )
    {
        $time = new DateTime( $timestamp );
        return date( 'Y-m-d H:i:s', $time->getTimestamp() );
    }

}
?>