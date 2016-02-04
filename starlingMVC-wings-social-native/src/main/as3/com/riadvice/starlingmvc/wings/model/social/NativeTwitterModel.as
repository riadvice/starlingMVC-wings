/*
   Copyright (C) 2013-2016 RIADVICE <ghazi.triki@riadvice.tn>

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
package com.riadvice.starlingmvc.wings.model.social
{
    import com.swfjunkie.tweetr.Tweetr;
    import com.swfjunkie.tweetr.events.TweetEvent;
    import com.swfjunkie.tweetr.oauth.OAuth;
    import com.swfjunkie.tweetr.oauth.events.OAuthEvent;

    import flash.display.Stage;
    import flash.geom.Rectangle;
    import flash.html.HTMLLoader;

    import com.riadvice.starlingmvc.wings.core.Wings;

    public class NativeTwitterModel
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _twt : Tweetr;

        private var _consumerKey : String;
        private var _consumerSecret : String;
        private var _pinlessAuth : Boolean;
        private var _callbackURL : String;
        private var _serviceHost : String;
        private var _oAuth : OAuth;

        private var _htmlLoader : HTMLLoader;

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  consumerKey
        //----------------------------------

        public function set consumerKey( value : String ) : void
        {
            _consumerKey = value;
        }

        //----------------------------------
        //  consumerSecret
        //----------------------------------

        public function set consumerSecret( value : String ) : void
        {
            _consumerSecret = value;
        }

        //----------------------------------
        //  consumerSecret
        //----------------------------------

        public function set pinlessAuth( value : String ) : void
        {
            _pinlessAuth = (value == "true");
        }

        //----------------------------------
        //  callbackURL
        //----------------------------------

        public function set callbackURL( value : String ) : void
        {
            _callbackURL = value;
        }

        //----------------------------------
        //  serviceHost
        //----------------------------------

        public function set serviceHost( value : String ) : void
        {
            _serviceHost = value;
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        public function authenticate() : void
        {
            if (_twt)
            {
                _twt = new Tweetr();
                _twt.serviceHost = _serviceHost;
                _twt.addEventListener(TweetEvent.COMPLETE, handleLoad);
                _twt.addEventListener(TweetEvent.FAILED, handleFail);
            }
            if (!_oAuth)
            {
                _oAuth = new OAuth();
                _oAuth.callbackURL = _callbackURL;
                _oAuth.pinlessAuth = _pinlessAuth;
                _oAuth.consumerKey = _consumerKey;
                _oAuth.consumerSecret = _consumerSecret;
                _oAuth.serviceHost = "https://api.twitter.com"//_serviceHost;
                _oAuth.addEventListener(OAuthEvent.COMPLETE, handleOAuthEvent);
                _oAuth.addEventListener(OAuthEvent.ERROR, handleOAuthEvent);
            }
            var stage : Stage = Wings.mainApp["stage"];
            var rect : Rectangle = new Rectangle(10, 10, stage.stageWidth - 20, stage.stageHeight - 20);
            _htmlLoader = HTMLLoader.createRootWindow(true, null, true, rect);
            _oAuth.htmlLoader = _htmlLoader;
            _oAuth.getAuthorizationRequest();
        }

        private function handleOAuthEvent( event : OAuthEvent ) : void
        {
            if (event.type == OAuthEvent.COMPLETE)
            {
                // removes the authentication window
                _htmlLoader.stage.nativeWindow.close();

                _twt.oAuth = _oAuth;

                // prints username, user id and the final tokens
                trace(_oAuth.toString());
            }
            else
            {
                trace("ERROR: " + event.text);
            }
        }

        private function handleLoad( event : TweetEvent ) : void
        {
            trace(event.info, "Epic Success");
            //tweetId = StatusData(event.responseArray[0]).id;
        }

        /**
         * @private
         * If something go wrong, show an alert window with the info
         */
        private function handleFail( event : TweetEvent ) : void
        {
            trace(event.info, "Epic Fail");
        }
    }
}
