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
package com.riadvice.starlingmvc.wings.sound
{
    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import flash.utils.getQualifiedClassName;

    import starling.events.EventDispatcher;

    /**
     * @author Matt Przybylski [http://www.reintroducing.com]
     * @version 1.2
     */
    public class SoundItem extends EventDispatcher
    {
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------

//		private var _fadeTween:TweenLite;
        private var _volume : Number;

        public var name : String;
        public var sound : Sound;
        public var channel : SoundChannel;
        public var position : int;
        public var paused : Boolean;
        public var savedVolume : Number;
        public var startTime : Number;
        public var loops : int;
        public var pausedByAll : Boolean;
        public var muted : Boolean;

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  volume
        //----------------------------------

        /**
         *
         */
        public function get volume() : Number
        {
            return channel.soundTransform.volume;
        }

        /**
         *
         */
        public function set volume( val : Number ) : void
        {
            setVolume(val);
        }

        //----------------------------------
        //  fadeTween
        //----------------------------------
        /*public function get fadeTween():TweenLite
           {
           return _fadeTween;
           }

           /**
         *
         */
        /*public function set fadeTween(val:TweenLite):void
           {
           if (val == null) TweenLite.killTweensOf(this);

           _fadeTween = val;
           }*/

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        public function SoundItem() : void
        {
            super();

            //TweenPlugin.activate([VolumePlugin]);

            init();
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  internal
        //----------------------------------
        /**
         *
         */
        private function init() : void
        {
            channel = new SoundChannel();
        }

        /**
         *
         */
        private function fadeComplete( stopOnComplete : Boolean ) : void
        {
            if (stopOnComplete)
            {
                stop();
            }

            dispatchEvent(new SoundManagerEvent(SoundManagerEvent.SOUND_ITEM_FADE_COMPLETE, this));
        }

        //----------------------------------
        //  public
        //----------------------------------

        /**
         * Plays the sound item.
         *
         * @param startTime The time, in seconds, to start the sound at (default: 0)
         * @param loops The number of times to loop the sound (default: 0)
         * @param volume The volume to play the sound at (default: 1)
         * @param resumeTween If the sound volume is faded and while fading happens the sound is stopped, this will resume that fade tween (default: true)
         *
         * @return void
         */
        public function play( startTime : Number = 0, loops : int = 0, volume : Number = 1, resumeTween : Boolean = true ) : void
        {
            if (!paused)
            {
                return;
            }

            volume = volume;
            savedVolume = volume;
            startTime = startTime;
            loops = loops;
            paused = (startTime == 0) ? true : false;

            if (!paused)
            {
                position = startTime;
            }

            channel = sound.play(position, loops, new SoundTransform(volume));
            channel.addEventListener(Event.SOUND_COMPLETE, handleSoundComplete);
            paused = false;
			dispatchEvent(new SoundManagerEvent(SoundManagerEvent.SOUND_ITEM_PLAY_START, this));

            //if (resumeTween && (fadeTween != null)) fadeTween.resume();
        }

        /**
         * Pauses the sound item.
         *
         * @param pauseTween If a fade tween is happening at the moment the sound is paused, the tween will be paused as well (default: true)
         *
         * @return void
         */
        public function pause( pauseTween : Boolean = true ) : void
        {
            paused = true;
            position = channel.position;
            channel.stop();
            channel.removeEventListener(Event.SOUND_COMPLETE, handleSoundComplete);

            //if (pauseTween && (fadeTween != null)) fadeTween.pause();
        }

        /**
         * Stops the sound item.
         *
         * @return void
         */
        public function stop() : void
        {
            paused = true;
            channel.stop();
            channel.removeEventListener(Event.SOUND_COMPLETE, handleSoundComplete);
            position = channel.position;
            //fadeTween = null;
        }

        /**
         * Fades the sound item.
         *
         * @param volume The volume to fade to (default: 0)
         * @param fadeLength The time, in seconds, to fade the sound (default: 1)
         * @param stopOnComplete Stops the sound once the fade is completed (default: false)
         *
         * @return void
         */
        public function fade( volume : Number = 0, fadeLength : Number = 1, stopOnComplete : Boolean = false ) : void
        {
            // fadeTween = TweenLite.to(channel, fadeLength, {volume: volume, onComplete: fadeComplete, onCompleteParams: [stopOnComplete]});
        }

        /**
         * Sets the volume of the sound item.
         *
         * @param volume The volume, from 0 to 1, to set
         *
         * @return void
         */
        public function setVolume( volume : Number ) : void
        {
            var curTransform : SoundTransform = channel.soundTransform;
            curTransform.volume = volume;
            channel.soundTransform = curTransform;

            _volume = volume;
        }

        /**
         * Clears the sound item for garbage collection.
         *
         * @return void
         */
        public function destroy() : void
        {
            channel.removeEventListener(Event.SOUND_COMPLETE, handleSoundComplete);
            channel = null;
            //fadeTween = null;
        }


        public function toString() : String
        {
            return getQualifiedClassName(this);
        }

        //--------------------------------------------------------------------------
        //
        //  Events handlers
        //
        //--------------------------------------------------------------------------

        /**
         *
         */
        private function handleSoundComplete( evt : Event ) : void
        {
            stop();

            dispatchEvent(new SoundManagerEvent(SoundManagerEvent.SOUND_ITEM_PLAY_COMPLETE, this));
        }

    }
}
