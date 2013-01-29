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
class ServiceErrors
{
    const SUCCESS = 0;
    const SERVICE_ERROR = 100;
    const UNEXPCETED_ERROR = 101;
    const NOT_CONNECTED = 200;
    const EXPIRED_TOKEN = 201;
    const EMPTY_TRANSFER = 300;
    const INVALID_TRANSFERT_OBJECT = 301;
    const NO_TRANSFERT_OBJECT_HEADER = 302;
    static $MESSAGES = array(
            100 => 'Erreur de service.',
            100 => 'Erreur inattendue.',
            200 => 'Connexion perdue.',
            201 => 'Token expiré.',
            300 => 'Object de transfer vide',
            301 => 'Object de transfert invalide',
            302 => 'Object de transfer sans entête' );

}

?>