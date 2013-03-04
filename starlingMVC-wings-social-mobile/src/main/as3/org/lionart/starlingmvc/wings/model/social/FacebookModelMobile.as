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
package org.lionart.starlingmvc.wings.model.social
{
    import com.facebook.graph.FacebookMobile;
    import com.facebook.graph.data.FacebookSession;

    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.LocationChangeEvent;
    import flash.geom.Rectangle;
    import flash.media.StageWebView;

    import org.lionart.starlingmvc.wings.core.Wings;
    import org.lionart.starlingmvc.wings.events.FacebookEvent;
    import org.lionart.starlingmvc.wings.model.WingsModel;

    public class FacebookModelMobile extends WingsModel
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

        private var _applicationId : String;
        private var _permissions : Array; /*["email", "user_birthday", "user_hometown", "user_about_me", "publish_actions"]*/
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

        public function set permissions( value : Array ) : void
        {
            _permissions = value;
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
            if (!_webView)
            {
                _webView = new StageWebView();
                _webView.addEventListener(LocationChangeEvent.LOCATION_CHANGE, onWebViewLocationChangeHandler);
                _webView.stage = Wings.mainApp["stage"];
                _webView.viewPort = new Rectangle(10, 10, 0, 0);
            }
            FacebookMobile.login(onAuthenticateHandler, _webView.stage, _permissions, _webView);
        }

        public function feedWall() : void
        {
            var params : Object = {access_token: _session.accessToken, message: "Ija il3ab"};
            //FacebookMobile.api("/me/feed/", onPostStatus, params, "POST");
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
                dispatcher.dispatchEventWith(FacebookEvent.FACEBOOK_INIT_SUCCESS, false, response);
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
                dispatcher.dispatchEventWith(FacebookEvent.FACEBOOK_AUTH_SUCCESS, false, response);
            }
            if (fail)
            {
                dispatcher.dispatchEventWith(FacebookEvent.FACEBOOK_AUTH_FAIL, false, response);
            }
        }

        private function onWebViewLocationChangeHandler( event : flash.events.Event ) : void
        {
            try
            {
                // FIXME
                if (event.target && event.target.viewPort != null)
                {
                    var stage : Stage = Wings.mainApp["stage"];
                    event.target.viewPort = new Rectangle(10, 10, stage.stageWidth - 20, stage.stageHeight - 20);
                }
            }
            catch ( e : Error )
            {
                // Swallow error
            }
        }

    }
}
