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
class SessionsManager extends WingsManager
{
    static $DAO_CLASS = 'SessionDAO';
    static $VO_CLASS = 'SessionVO';

    public function updateAtNow( $session_id )
    {
        $session = $this->get( $session_id );
        $session->updatedAt = new DateTime();
        $this->update( $session );
    }

}