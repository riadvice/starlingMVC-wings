<?php

/*
 * Copyright (C) 2013 Ghazi Triki <ghazi.nocturne@gmail.com> This program is
 * free software: you can redistribute it and/or modify it under the terms of
 * the GNU General Public License as published by the Free Software Foundation,
 * either version 3 of the License, or (at your option) any later version. This
 * program is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */

require_once 'ValueObject.php';

/**
 * SessionVO is mostly used in mobile services to keep server sessionId and
 * social networks authorisations.
 *
 * @author Ghazi Triki <ghazi.nocturne@gmail.com>
 */
class SessionVO extends \ValueObject
{
    /**
     *
     * @var string
     */
    var $_explicitType = "org.lionart.starlingmvc.wings.values.common.SessionVO";
    
    /**
     *
     * @var string
     */
    var $sessionID;
    
    /**
     *
     * @var string
     */
    var $version;
    
    /**
     *
     * @var string
     */
    var $fbID;
    
    /**
     *
     * @var string
     */
    var $appID;
    
    /**
     *
     * @var string
     */
    var $device;
    
    /**
     * User got from flash application connection
     *
     * @var stdClass
     */
    var $user;
    
    /**
     * Arbitray additional data determined by the developer and application
     * needs.
     *
     * @var stdClass
     */
    var $data;

}

?>