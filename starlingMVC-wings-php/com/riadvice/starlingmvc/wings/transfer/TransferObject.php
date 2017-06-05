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
class TransferObject
{
    var $_explicitType = "org.lionart.starlingmvc.wings.transfer.TransferObject";
    /**
     *
     * @var TransferObjectHeader
     */
    public $transferObjectHeader;

    function __construct()
    {
        $this->buildDefaultHeader();
    }

    /**
     *
     * @param int $code            
     * @param string $message            
     * @return TransferObjectHeader
     */
    function buildHeader( $code, $message )
    {
        return $this->transferObjectHeader = new TransferObjectHeader( $code, $message );
    }

    /**
     *
     * @return TransferObjectHeader
     */
    private function buildDefaultHeader()
    {
        return $this->transferObjectHeader = new TransferObjectHeader( 0, "" );
    }

    /**
     *
     * @return TransferObjectHeader
     */
    function getTransferObjectHeader()
    {
        return $this->transferObjectHeader;
    }

    /**
     *
     * @param TransferObjectHeader $header            
     */
    function setTransferObjectHeader( $header )
    {
        $this->transferObjectHeader = $header;
    }

}
?>