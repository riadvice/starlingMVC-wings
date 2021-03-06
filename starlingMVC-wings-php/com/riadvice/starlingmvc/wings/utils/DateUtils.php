<?php

/*
   Copyright (C) 2013-2017 RIADVICE <ghazi.triki@riadvice.tn>

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

class DateUtils
{

    /**
     * Converts an AMF Date to PHP DateTime
     *
     * @param Amfphp_Core_Amf_Types_Date $amfDate
     * @return DateTime
     */
    public static function afmDateToDateTime( $amfDate )
    {
        $date = new DateTime();
        $date->setTimestamp( $amfDate->timeStamp / 1000 );
        return $date;
    }

    /**
     * Converts an PHP DateTime string to AMF Date
     *
     * @param string $stringDate
     * @return Amfphp_Core_Amf_Types_Date
     */
    public static function dateTimeToafmDate( $stringDate )
    {
        return new Amfphp_Core_Amf_Types_Date( DateTime::createFromFormat( 'Y-m-d H:i:s', $stringDate )->getTimestamp() * 1000 );
    }

    public static function currentDate( $timestamp = null )
    {
        $time = new DateTime( $timestamp );
        return date( 'Y-m-d H:i:s', $time->getTimestamp() );
    }

    public static function now()
    {
        return date( 'Y-m-d H:i:s' );
    }

}
?>