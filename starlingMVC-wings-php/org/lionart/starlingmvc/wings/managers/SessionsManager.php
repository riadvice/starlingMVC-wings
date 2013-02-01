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
class SessionsManager
{
    
    /**
     *
     * @var SessionDAO
     */
    private $sessionDao;

    public function __construct()
    {
        $this->sessionDao = new SessionDAO();
    }

    public function addSession( SessionVO $session )
    {
        $beanSource = ObjectConverter::convertToBeanSource( $session, ConversionMap::$MAP ['SessionVO'] );
        return $this->sessionDao->create( $beanSource );
    }

    /**
     *
     * @param
     *            $session_id
     * @return SessionVO
     */
    public function loadSession( $session_id )
    {
        $obj = $this->sessionDao->read( $session_id );
        return ObjectConverter::convertToValueObject( $obj, 'SessionVO', ConversionMap::$MAP ['SessionVO'] );
    }

    /**
     *
     * @param SessionVO $session            
     */
    public function updateSession( SessionVO $session )
    {
        $beanSource = ObjectConverter::convertToBeanSource( $session, ConversionMap::$MAP ['SessionVO'] );
        return $this->sessionDao->update( $beanSource );
    }

    /**
     *
     * @param SessionVO $session            
     */
    public function deleteSession( SessionVO $session )
    {
        return $this->sessionDao->delete( $session->id );
    }

}