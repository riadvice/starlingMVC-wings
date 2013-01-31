<?php

class CryptoUtils
{
    const HASH = "-VW%G/=!n?ecL";

    public static function encrypt( $value )
    {
        return base64_encode( self::HASH . $value );
    }

    public static function decrypt( $value )
    {
        return str_replace( self::HASH, '', base64_decode( $value ) );
    }

}
?>