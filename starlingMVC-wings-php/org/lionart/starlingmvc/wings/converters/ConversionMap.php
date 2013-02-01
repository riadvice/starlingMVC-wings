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

class ConversionMap
{
    static $MAP = array(
            'SessionVO' => array(
                    'id' => 'id',
                    'session_id' => 'sessionID',
                    'version' => 'version',
                    'fb_id' => 'fbID',
                    'app_id' => 'appID',
                    'device' => 'device',
                    'data' => 'data' ),
            'UserVO' => array(
                    'id' => 'id',
                    'fb_id' => 'fbid',
                    'twt_id' => 'twtid',
                    'first_name' => 'firstName',
                    'last_name' => 'lastName',
                    'email' => 'email',
                    'password' => 'password' ),
            'PlayerVO' => array(
                    'id' => 'id',
                    'fb_id' => 'fbid',
                    'twt_id' => 'twtid',
                    'first_name' => 'firstName',
                    'last_name' => 'lastName',
                    'email' => 'email',
                    'password' => 'password' ) );

}

?>