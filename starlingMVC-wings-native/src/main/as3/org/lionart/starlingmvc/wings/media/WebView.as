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
package org.lionart.starlingmvc.wings.media
{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TouchEvent;
    import flash.geom.Rectangle;
    import flash.media.StageWebView;

    public class WebView
    {

        //--------------------------------------------------------------------------
        //
        //  Class constants
        //
        //--------------------------------------------------------------------------

        [Embed(source = "/../resources/images/close.png")]
        private static const CLOSE : Class;

        //--------------------------------------------------------------------------
        //
        //  Class variables
        //
        //--------------------------------------------------------------------------

        private static var _stageWebView : StageWebView;

        private static var _closeButton : Sprite;

        //--------------------------------------------------------------------------
        //
        //  Class methods
        //
        //--------------------------------------------------------------------------

        public static function createWebView( stage : Stage, viewport : Rectangle, closeable : Boolean = true ) : StageWebView
        {
            if ( !_stageWebView )
            {
                _stageWebView = new StageWebView();
                _stageWebView.stage = stage;
                _stageWebView.viewPort = viewport;
                if (!_closeButton)
                {
                    var closeBitmap : Bitmap = new CLOSE();
                    closeBitmap.width = 48;
                    closeBitmap.height = 32;
                    _closeButton = new Sprite();
                    _closeButton.addChild(closeBitmap);
                    _closeButton.x = stage.stageWidth - _closeButton.width;
                    _closeButton.addEventListener(TouchEvent.TOUCH_TAP, closeButtonTouched);
                    _closeButton.addEventListener(MouseEvent.CLICK, closeButtonTouched);
                    stage.addChild(_closeButton);
                }
                _closeButton.visible = closeable;
            }
            return _stageWebView;
        }

        public static function closeWebView() : void
        {
            _closeButton.visible = false;
            _stageWebView.stage = null;
            _stageWebView.dispose();
            _stageWebView = null;
        }

        private static function closeButtonTouched( event : Event ) : void
        {
            closeWebView();
        }

    }
}
