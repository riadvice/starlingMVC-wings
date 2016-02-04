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

class ObjectConverter
{

    /**
     * Transforms an object to a typed object
     *
     * @param stdObject $source
     * @param class $class
     * @param array $mapping
     * @return ValueObject
     */
    public static function convertToValueObject( $source, $class, $mapping )
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

    public static function convertToArrayOfValueObject( $source, $class, $mapping )
    {
        $result = array();
        foreach( $source as $obj )
        {
            array_push( $result, ObjectConverter::convertToValueObject( $obj, $class, $mapping ) );
        }
        return $result;
    }

    public static function convertToBeanSource( $source, $mapping )
    {
        $beanSource = new stdClass();
        foreach( $mapping as $key => $value )
        {
            $beanSource->$key = $source->$value;
        }
        return $beanSource;
    }

    public static function convertToArrayOfBeanSource( $source, $mapping )
    {
        $result = array();
        foreach( $source as $vo )
        {
            array_push( $result, ObjectConverter::convertToBeanSource( $vo, $mapping ) );
        }
        return $result;
    }

}