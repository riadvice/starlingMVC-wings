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

class DeviceUtils
{
    /**
     * avHardwareDisable     <b>AVD</b><br>
     * hasAccessibility     <b>ACC</b><br>
     * hasAudio     <b>A</b><br>
     * hasAudioEncoder     <b>AE</b><br>
     * hasEmbeddedVideo     <b>EV</b><br>
     * hasIME     <b>IME</b><br>
     * hasMP3     <b>MP3</b><br>
     * hasPrinting     <b>PR</b><br>
     * hasScreenBroadcast     <b>SB</b><br>
     * hasScreenPlayback     <b>SP</b><br>
     * hasStreamingAudio     <b>SA</b><br>
     * hasStreamingVideo     <b>SV</b><br>
     * hasTLS     <b>TLS</b><br>
     * hasVideoEncoder     <b>VE</b><br>
     * isDebugger     <b>DEB</b><br>
     * language     <b>L</b><br>
     * localFileReadDisable     <b>LFD</b><br>
     * manufacturer     <b>M</b><br>
     * maxLevelIDC     <b>ML</b><br>
     * os     <b>OS</b><br>
     * pixelAspectRatio     <b>AR</b><br>
     * playerType     <b>PT</b><br>
     * screenColor     <b>COL</b><br>
     * screenDPI     <b>DP</b><br>
     * screenResolutionX     <b>R</b><br>
     * screenResolutionY     <b>R</b><br>
     * version     <b>V</b><br>
     * supports Dolby Digital audio <b>    DD</b><br>
     * supports Dolby Digital Plus audio     <b>DDP</b><br>
     * supports DTS audio     <b>DTS</b><br>
     * supports DTS Express audio     <b>DTE</b><br>
     * supports DTS-HD High Resolution Audio     <b>DTH</b><br>
     * supports DTS-HD Master Audio     <b>DTM</b><br>
     * windowless mode is disabled     <b>WD</b><br>
     * cpuArchitecture     <b>ARCH</b><br>
     * languages     <b>LS</b><br>
     * supports32BitProcesses     <b>PR32</b><br>
     * supports64BitProcesses     <b>PR64</b><br>
     * @var array
     */
    static $FP_SERVER_STRING = array(
            "AVD",
            "ACC",
            "A",
            "AE",
            "EV",
            "IME",
            "MP3",
            "PR",
            "SB",
            "SP",
            "SA",
            "SV",
            "TLS",
            "VE",
            "DEB",
            "L",
            "LFD",
            "M",
            "ML",
            "OS",
            "AR",
            "PT",
            "COL",
            "DP",
            "R",
            "V",
            "DD",
            "DDP",
            "DTS",
            "DTE",
            "DTH",
            "DTM",
            "ARCH",
            "PR32",
            "PR64",
            "WD",
            "LS");

    /**
     * Parses flash player server string.
     */
    public static function parseFPServerString()
    {
    }

    /**
     * Parses system properties server string.
     */
    public static function parseSPServerString()
    {
    }

    public static function parseServerStrings( $fpString, $spString = null )
    {
        if ( ! is_null( $fpString ) )
        {
            DeviceUtils::parseFPServerString();
        }
        if ( ! is_null( $spString ) )
        {
            DeviceUtils::parseSPServerString();
        }
    }

}

?>