/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 14, 2015 4:30:48 PM			
 * ===================================
 */

package com.idzeir.animation
{
	import com.idzeir.utils.AssetsManager;
	import com.idzeir.utils.SequenceUtil;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	/**
	 * 序列图动画类,当添加到舞台之后开始播放，移出舞台停止播放
	 */	
	public class Animation extends Sprite
	{
		private var _currentLabels:Vector.<String> = new Vector.<String>();
		
		private static var _map:Dictionary = new Dictionary(true);
		/**
		 * 回调代码集合 
		 */		
		private var _scriptMap:Dictionary = new Dictionary(true);
		
		private var _key:String = null;
		
		private var _bitmap:Bitmap;
		private var _frames:Vector.<Frame>;
		
		private var _auto:Boolean = false;
		private var _loop:Boolean = true;
		private var _isPlaying:Boolean = false;
		private var _currentFrame:int = 0;
		/**
		 * 每一帧执行的时间 
		 */		
		private var _frameRate:int = int(1000/24);
		
		private var _id:int = 0;
		
		public function Animation()
		{
			
			_bitmap = new Bitmap(null,"auto",true);
			this.addChild(_bitmap);
			
			this.addEventListener(Event.ADDED_TO_STAGE,function():void
			{
				//stage.frameRate;
				_frameRate = 1000/stage.frameRate;
				play();
			});
			
			this.addEventListener(Event.REMOVED_FROM_STAGE,function():void
			{
				//暂停播放
				stop();
			});
			
		}
		
		/**
		 * 当前播放帧 
		 */
		public function get currentFrame():int
		{
			return _currentFrame;
		}

		/**
		 * @private
		 */
		public function set currentFrame(value:int):void
		{
			_currentFrame = value;
		}

		/**
		 * 是否在播放 
		 */
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}

		/**
		 * @private
		 */
		public function set isPlaying(value:Boolean):void
		{
			_isPlaying = value;
		}

		/**
		 * 是否循环播放 
		 */
		public function get loop():Boolean
		{
			return _loop;
		}

		/**
		 * @private
		 */
		public function set loop(value:Boolean):void
		{
			_loop = value;
		}

		/**
		 * 要转换成序列图的动画资源  
		 * @param urlOrMc 外部swf地址或者显示对象MovieClip
		 * @param definition 当调用外部swf时可以指定获取的动画类，不指定为获取swf对象
		 * @param auto 转换完成是否自动播放
		 */		
		public function setAssets(urlOrMc:*, definition:String = null, auto:Boolean = true):void
		{
			_key = escape(urlOrMc.toString())+"::"+definition;
			_auto = auto;
			if(!has())
			{
				if(urlOrMc is String)
				{
					AssetsManager.getInstance().getEmbed(urlOrMc,definition,function(child:DisplayObject):void
					{
						_map[_key] =  frames = SequenceUtil.toMap(child);
					},trace);
				}else if(urlOrMc is MovieClip){
					_map[_key] = frames = SequenceUtil.toMap(urlOrMc);
				}else{
					throw new Error("参数urlOrMc类型错误，应为string或者movieclip");
				}
			}else{
				frames = _map[_key];
			}
		}
		
		public function set frames(value:Vector.<Frame>):void
		{
			_frames  = value;
			_auto&&play();
		}
		
		public function get frames():Vector.<Frame>
		{
			return _frames;
		}
		/**
		 * 动画帧数
		 */		
		public function get totalFrame():uint
		{
			return _frames?_frames.length:0;
		}
		
		private function update():void
		{
			gotoFrame(_currentFrame);
			++_currentFrame;
			if(_currentFrame>=totalFrame)
			{
				if(_loop)
				{
					_currentFrame = 0;
				}else{
					stop();
				}
			}
		}
		
		private function gotoFrame(value:int):void
		{
			if(value<0||value>=totalFrame)
			{
				trace("错误帧序号");
				return;
			}
			var frame:Frame = _frames[value];
			_bitmap.bitmapData = frame;
			_bitmap.x = frame.offX;
			_bitmap.y = frame.offY;
			
			var backFun:Function = _scriptMap[value];
			if(backFun)
			{
				try{
					backFun.apply();
				}catch(e:Error){
					trace("回调失败：",e.message," 回调帧：",value);
				}
			}
		}
		
		private function has():Boolean
		{
			if(_map.hasOwnProperty(_key))
			{
				return true;
			}
			return false;
		}
		
		/**
		 * 播放动画
		 */		
		public function play():void
		{
			_isPlaying = true;
			clearInterval(_id);
			//多帧的时候才执行播放
			if(totalFrame>1){
				_id = setInterval(update,_frameRate);
			}
		}
		
		/**
		 * 停止动画
		 */		
		public function stop():void
		{
			_isPlaying = false;
			clearInterval(_id);
		}
		/**
		 * 调到指定帧播放
		 * @param frameOrLabel
		 */		
		public function gotoAndPlay(frameOrLabel:*):void
		{
			if(frameOrLabel is String)
			{
				for(var i:uint = 0;i<totalFrame;i++)
				{
					if(_frames[i].name == frameOrLabel)
					{
						gotoFrame(i);
						break;
					}
				}
			}else{
				gotoFrame(frameOrLabel);
			}
			play();
		}
		/**
		 * 调到指定帧暂停
		 * @param frameOrLabel
		 */		
		public function gotoAndStop(frameOrLabel:*):void
		{
			if(frameOrLabel is String)
			{
				for(var i:uint = 0;i<totalFrame;i++)
				{
					if(_frames[i].name == frameOrLabel)
					{
						gotoFrame(i);
						break;
					}
				}
			}else{
				gotoFrame(frameOrLabel);
			}
			stop();
		}
		
		/**
		 * 在指定帧增加回调 <p>链式调用例子：先跳到第一帧，播放到第10帧执行代码<p>addScriptAt(10,function():void{trace("helloWorld")}).gotoAndPlay(1);
		 * @param frameOrLabel 帧名称或者帧位置
		 * @param handler 会覆盖旧动作
		 * @return 返回动画本身，提供链式调用
		 */		
		public function addScriptAt(frameOrLabel:*,handler:Function):Animation
		{
			if(frameOrLabel is String)
			{
				for(var i:uint = 0;i<totalFrame;i++)
				{
					if(_frames[i].name == frameOrLabel)
					{
						_scriptMap[i] = handler;
						break;
					}
				}
			}else{
				_scriptMap[frameOrLabel] = handler;
			}
			return this;
		}
		
		/**
		 * 删除指定帧的回调
		 * @param frameOrLabel
		 */		
		public function removeScriptAt(frameOrLabel:*):void
		{
			if(frameOrLabel is String)
			{
				for(var i:uint = 0;i<totalFrame;i++)
				{
					if(_frames[i].name == frameOrLabel)
					{
						_scriptMap[i] = null;
						delete _scriptMap[i];
						break;
					}
				}
			}else{
				_scriptMap[frameOrLabel] = null;
				delete _scriptMap[frameOrLabel];
			}
		}
		/**
		 * 删除全部回调
		 */		
		public function removeAllScript():void
		{
			for(var i:uint = 0;i<totalFrame;i++)
			{
				_scriptMap[i] = null;
				delete _scriptMap[i];
			}
		}
	}
}