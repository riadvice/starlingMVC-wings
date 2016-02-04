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

abstract class WingsManager
{
    protected $dao;

    /**
     *
     * @var stdClass
     */
    static $DAO_CLASS;

    /**
     *
     * @var stdClass
     */
    static $VO_CLASS;

    public function __construct()
    {
        $this->dao = new static::$DAO_CLASS();
    }

    /**
     *
     * @param ValueObject $vo
     */
    public function add( $vo )
    {
        $beanSource = ObjectConverter::convertToBeanSource( $vo, ConversionMap::$MAP [static::$VO_CLASS] );
        return $this->dao->create( $beanSource );
    }

    /**
     *
     * @param string $session_id
     * @return ValueObject
     */
    public function get( $vo_id )
    {
        $obj = $this->dao->read( $vo_id );
        return ObjectConverter::convertToValueObject( $obj, static::$VO_CLASS, ConversionMap::$MAP [static::$VO_CLASS] );
    }

    /**
     *
     * @param ValueObject $vo
     */
    public function update( $vo )
    {
        $beanSource = ObjectConverter::convertToBeanSource( $vo, ConversionMap::$MAP [static::$VO_CLASS] );
        return $this->dao->update( $beanSource );
    }

    /**
     *
     * @param ValueObject $vo
     */
    public function delete( $vo )
    {
        return $this->dao->delete( $vo->id );
    }

}