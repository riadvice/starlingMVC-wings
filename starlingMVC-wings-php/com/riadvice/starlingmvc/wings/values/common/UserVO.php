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

/**
 * Common user Value Object for services call
 *
 * @author Ghazi Triki
 */
class UserVO extends ValueObject
{
    /**
     *
     * @var string
     */
    var $_explicitType = "org.lionart.starlingmvc.wings.values.common.UserVO";

    /**
     *
     * @var string
     */
    var $fbid;

    /**
     *
     * @var string
     */
    var $twtid;

    /**
     *
     * @var string
     */
    var $firstName;

    /**
     *
     * @var string
     */
    var $lastName;

    /**
     *
     * @var string
     */
    var $email;

    /**
     *
     * @var string
     */
    var $password;

}
?>