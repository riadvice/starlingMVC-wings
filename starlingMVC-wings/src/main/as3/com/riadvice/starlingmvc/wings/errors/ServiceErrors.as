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
package com.riadvice.starlingmvc.wings.errors
{

    /**
     * Common errors returned from service layer.
     */
    public class ServiceErrors
    {
        public static const SUCCESS : int = 0;
        public static const SERVICE_ERROR : int = 100;
        public static const UNEXPCETED_ERROR : int = 101;
        public static const NOT_CONNECTED : int = 200;
        public static const EXPIRED_TOKEN : int = 201;
        public static const EMPTY_TRANSFER : int = 300;
        public static const INVALID_TRANSFERT_OBJECT : int = 301;
        public static const NO_TRANSFERT_OBJECT_HEADER : int = 302;
        public static const NOT_SUPPORTED_VERSION : int = 400;
        public static const INCORRECT_VERSION : int = 401;
    }
}
