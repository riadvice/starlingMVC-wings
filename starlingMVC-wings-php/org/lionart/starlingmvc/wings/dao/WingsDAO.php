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
abstract class WingsDAO
{
    /**
     *
     * @var string
     */
    static $TYPE;

    public function __construct()
    {
    }

    public function read( $id )
    {
        $obj = new stdClass();
        R::load( static::$TYPE, $id )->exportToObj( $obj );
        return ($obj->id != 0) ? $obj : null;
    }

    public function readAll( $sql = null, $values = array() )
    {
        $beans = R::findAll( static::$TYPE, $sql, $values );
        return R::exportAll( $beans );
    }

    public function create( $object )
    {
        $bean = R::dispense( static::$TYPE );
        ObjectUtils::copyProperties($object, $bean);
        $bean->id = 0;
        $bean->created_at = DateUtils::currentDate();
        $bean->updated_at = DateUtils::currentDate();
        return R::store( $bean );
    }

    public function update( $object )
    {
        $bean = R::load( static::$TYPE, $object->id );
        ObjectUtils::copyProperties($object, $bean);
        $bean->updated_at = DateUtils::currentDate();
        return R::store( $bean );
    }

    public function delete( $object )
    {
        $bean = R::load( static::$TYPE, $object->id );
        return R::trash( $bean );
    }

}
?>