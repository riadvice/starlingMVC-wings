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
class WingsDAO
{
    const TYPE = '';

    public function __construct()
    {
        R::setup( 'mysql:host=localhost;dbname=wings', 'root', 'admin' );
        R::freeze( true );
        R::debug( false );
    }

    public function read( $id )
    {
        $obj = new stdClass();
        R::load( self::TYPE, $id )->exportToObj( $obj );
        return $obj;
    }

    public function create( $object )
    {
        $bean = R::dispense ( self::TYPE );
        $liker->created_at = ObjectUtils::currentDate ();
    }

    public function update( $object )
    {
    }

    public function delete( $object )
    {
    }

    protected function exportAsObject( $source )
    {
        $result = array();
        foreach( array_keys( $source ) as $key => $value )
        {
            array_push( $result, ObjectUtils::arrayToObject( $source [$value] ) );
        }
        return $result;
    }

}
?>