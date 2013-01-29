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

require '../vendor/autoload.php';

class WingsService
{
    var $users_manager;
    var $sessions_manager;

    function __construct()
    {
        // Configuring environement
        date_default_timezone_set( 'Africa/Tunis' );
        
        // TODO : add logger
        $this->users_manager = new UsersManager();
        $this->sessions_manager = new SessionsManager();
    }
    
    // -----------------------------------------------------------
    // Session methods
    // -----------------------------------------------------------
    protected function saveUserInSession( $user )
    {
        $_SESSION ['user'] = $user;
    }

    /**
     * Returns the current user or null if not connected or session expired
     *
     * @return playerDAOX <NULL, playerDAOX>
     */
    protected function getCurrentUser()
    {
        if ( isset( $_SESSION ['user'] ) )
        {
            return $_SESSION ['user'];
        }
        else
        {
            // TODO : add common erros catalog
            throw new Exception( ServiceErrors::$MESSAGES [ServiceErrors::NOT_CONNECTED], ServiceErrors::NOT_CONNECTED );
        }
    }

    /**
     * Returns the current user ID
     */
    protected function currentUserID()
    {
        return $this->getCurrentUser()->user_id;
    }

    /**
     * Connect a user from mobile application and creates a session
     *
     * @param string $fb_id            
     */
    protected function connectMobileUser( $user )
    {
        $session_id = $this->loadMobileSession( $session_id );
        $_SESSION ['mobile'] = TRUE;
        $_SESSION ['user'] = $user;
        return $session_id;
    }

    /**
     * Loads a user mobile session or creates it if not exists and returns its
     * id.
     *
     * @param string $session_id            
     */
    protected function loadMobileSession( $session_id = null )
    {
        if ( is_null( $session_id ) )
        {
            session_id();
        }
        else
        {
            session_id( $session_id );
        }
        session_start();
        return session_id();
    }

    /**
     *
     * @param TransferObject $transfer            
     * @param int $code            
     * @param message $message            
     * @return TransferObject
     */
    protected function buildTOHeader( TransferObject &$transfer, $code, $message )
    {
        $transfer->setTransferObjectHeader( new TransferObjectHeader( $code, $message ) );
        return $transfer;
    }

    /**
     *
     * @param TransferObject $transfer            
     * @param string $message            
     * @param int $code            
     */
    protected function buildUnknownErrorHeader( TransferObject &$transfer, $message, $code = null )
    {
        // TODO : check if error code is knwon or note
        $this->buildTOHeader( $transfer, $code ? $code : self::SERVICE_ERROR, $message );
    }

}