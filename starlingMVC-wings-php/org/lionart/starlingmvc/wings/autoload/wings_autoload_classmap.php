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
        'ConversionMap' => $baseDir . '/wings/converters/ConversionMap.php',
        'ObjectConverter' => $baseDir . '/wings/converters/ObjectConverter.php',
        'WingsDAO' => $baseDir . '/wings/dao/WingsDAO.php',
        'SessionDAO' => $baseDir . '/wings/dao/SessionDAO.php',
        'UserDAO' => $baseDir . '/wings/dao/UserDAO.php',
        'ValueObject' => $baseDir . '/wings/data/ValueObject.php',
        'ObjectUtils' => $baseDir . '/wings/utils/ObjectUtils.php',
        'ServiceErrors.php' => $baseDir . '/wings/errors/ServiceErrors.php',
        'WingsManager' => $baseDir . '/wings/managers/WingsManager.php',
        'SessionsManager' => $baseDir . '/wings/managers/SessionsManager.php',
        'UsersManager' => $baseDir . '/wings/managers/UsersManager.php',
        'WingsMobileService' => $baseDir . '/wings/service/WingsMobileService.php',
        'WingsService' => $baseDir . '/wings/service/WingsService.php',
        'TransferObject' => $baseDir . '/wings/transfer/TransferObject.php',
        'TransferObjectHeader' => $baseDir . '/wings/transfer/TransferObjectHeader.php',
        'UserVO' => $baseDir . '/wings/values/common/UserVO.php',
        'PlayerVO' => $baseDir . '/wings/values/common/PlayerVO.php',
        'SessionVO' => $baseDir . '/wings/values/common/SessionVO.php',
        'CryptoUtils' => $baseDir . '/wings/utils/CryptoUtils.php',
        'DateUtils' => $baseDir . '/wings/utils/DateUtils.php',
        'ObjectUtils' => $baseDir . '/wings/utils/ObjectUtils.php',
        'ServerUtils' => $baseDir . '/wings/utils/ServerUtils.php' );

?>