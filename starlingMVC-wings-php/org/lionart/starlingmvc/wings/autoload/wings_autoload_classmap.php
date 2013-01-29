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

$wingsDir = dirname( __DIR__ );
$baseDir = dirname( $wingsDir );

return array(
        'WingsDAO' => $baseDir . '/wings/dao/WingsDAO.php',
        'ValueObject' => $baseDir . '/wings/data/ValueObject.php',
        'ServiceErrors.php' => $baseDir . '/wings/errors/ServiceErrors.php',
        'SessionsManager' => $baseDir . '/wings/managers/SessionsManager.php',
        'UsersManager' => $baseDir . '/wings/managers/UsersManager.php',
        'WingsMobileService' => $baseDir . '/wings/service/WingsMobileService.php',
        'WingsService' => $baseDir . '/wings/service/WingsService.php',
        'TransferObject' => $baseDir . '/wings/transfer/TransferObject.php',
        'TransferObjectHeader' => $baseDir . '/wings/transfer/TransferObjectHeader.php',
        'PlayerVO' => $baseDir . '/wings/values/common/PlayerVO.php',
        'SessionVO' => $baseDir . '/wings/transfer/SessionVO.php',
        'UserVO' => $baseDir . '/wings/transfer/UserVO.php' );

?>