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
    import com.facebook.graph.FacebookMobile;
    import com.facebook.graph.data.FacebookSession;

    import flash.display.Stage;
    import flash.geom.Rectangle;
    import flash.media.StageWebView;
    import flash.net.URLRequestMethod;

    import com.riadvice.starlingmvc.wings.core.Wings;
    import com.riadvice.starlingmvc.wings.facebook.FacebookEvent;
    import com.riadvice.starlingmvc.wings.media.WebView;
    import com.riadvice.starlingmvc.wings.model.WingsModel;

    public class FacebookModelMobile extends WingsModel
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _applicationId : String;
        private var _permissions : Array;
        private var _session : FacebookSession;
        private var _webView : StageWebView;

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  applicationId
        //----------------------------------

        public function set applicationId( value : String ) : void
        {
            _applicationId = value;
        }

        //----------------------------------
        //  manageSession
        //----------------------------------

        public function set manageSession( value : Boolean ) : void
        {
            FacebookMobile.manageSession = value;
        }

        //----------------------------------
        //  permissions
        //----------------------------------

        public function set permissions( value : String ) : void
        {
            _permissions = value.split(",");
        }

        //----------------------------------
        //  session
        //----------------------------------

        public function get session() : FacebookSession
        {
            return _session;
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        public function init() : void
        {
            FacebookMobile.init(_applicationId, onFbInitHandler);
        }

        public function authenticate() : void
        {
            var _stage : Stage = Wings.mainApp["stage"];
            _webView = WebView.createWebView(_stage, new Rectangle(10, 34, _stage.stageWidth - 20, _stage.stageHeight - 54));
            FacebookMobile.login(onAuthenticateHandler, _webView.stage, _permissions, _webView);
        }

        public function postOnWall( params : Object ) : void
        {
            params.access_token = _session.accessToken;
            FacebookMobile.api("/me/feed/", onPostStatus, params, URLRequestMethod.POST);
        }

        //--------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //--------------------------------------------------------------------------

        private function onFbInitHandler( response : Object, fail : Object ) : void
        {
            if (response)
            {
                _session = FacebookSession(response);
                dispatcher.dispatchEventWith(FacebookEvent.FACEBOOK_SESSION_INIT, false, response);
            }
            else if (fail)
            {
                dispatcher.dispatchEventWith(FacebookEvent.FACEBOOK_INIT_FAIL, false, fail);
            }
        }

        private function onAuthenticateHandler( response : Object, fail : Object ) : void
        {
            if (response)
            {
                _session = FacebookSession(response);
                dispatcher.dispatchEventWith(FacebookEvent.FACEBOOK_SESSION_INIT, false, response);
            }
            if (fail)
            {
                dispatcher.dispatchEventWith(FacebookEvent.FACEBOOK_AUTH_FAIL, false, response);
            }
        }


        private function onPostStatus( response : Object, fail : Object ) : void
        {
            if (response)
            {
                //var feed : Feed = Feed(response);
                //trace(feed);
            }
            else if (fail)
            {
                //trace(fail);
            }
        }

    }
}
