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

require '../vendor/autoload.php';

class WingsService
{
    protected $usersManager;
    protected $sessionsManager;

    function __construct()
    {
        @session_start();
        // Configuring environement
        date_default_timezone_set( 'Africa/Tunis' );

        // TODO : add logger
        $this->usersManager = new UsersManager();
        $this->sessionsManager = new SessionsManager();
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
    protected function connectUser( $user )
    {
        $session_id = $this->loadSession( $session_id );
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
    protected function loadSession( $session_id = null )
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
        $this->buildTOHeader( $transfer, $code ? $code : ServiceErrors::SERVICE_ERROR, $message );
    }

}