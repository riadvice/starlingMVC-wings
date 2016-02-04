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

class ObjectUtils
{

    public static function arrayToObject( $source )
    {
        $obj = new stdClass();
        foreach( array_keys( $source ) as $key )
        {
            $obj->$key = $source [$key];
        }
        return $obj;
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