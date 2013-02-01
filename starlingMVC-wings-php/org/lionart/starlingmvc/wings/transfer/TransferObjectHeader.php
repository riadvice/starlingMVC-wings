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

class TransferObjectHeader
{
    /**
     *
     * @var string
     */
    var $_explicitType = "org.lionart.starlingmvc.wings.transfer.TransferObjectHeader";
    /**
     *
     * @var int
     */
    public $code;
    /**
     *
     * @var string
     */
    public $message;

    function __construct( $code, $message )
    {
        $this->code = $code;
        if ( ! empty( $message ) )
        {
            $this->message = $message;
        }
    }

    /**
     *
     * @return int
     */
    function getCode()
    {
        return $this->code;
    }

    /**
     *
     * @return string
     */
    function getMessage()
    {
        return $this->message;
    }

    /**
     *
     * @param int $code            
     */
    function setCode( $code )
    {
        $this->code = $code;
    }

    /**
     *
     * @param string $message            
     */
    function setMessage( $message )
    {
        $this->message = message;
    }

}
?>