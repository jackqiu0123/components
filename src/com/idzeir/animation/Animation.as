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
	import com.idzeir.components.AssetsManager;
	import com.idzeir.utils.SequenceUtil;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * 序列图动画类
	 */	
	public class Animation extends Bitmap
	{
		private var _currentLabels:Vector.<String> = new Vector.<String>();
		
		private static var _map:Dictionary = new Dictionary(true);
		
		private var _key:String = null;
		
		private var _frames:Vector.<Frame>;
		
		private var _auto:Boolean = false;
		
		public function Animation()
		{
			super(null, "auto", true);
			
			this.addEventListener(Event.ADDED_TO_STAGE,function():void
			{
				//stage.frameRate;
			});
			
			this.addEventListener(Event.REMOVED_FROM_STAGE,function():void
			{
				//暂停播放
			});
			
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
		
		private function update():void
		{
			
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
			
		}
		/**
		 * 停止动画
		 */		
		public function stop():void
		{
			
		}
		/**
		 * 调到指定帧播放
		 * @param frameOrLabel
		 */		
		public function gotoAndPlay(frameOrLabel:*):void
		{
			
		}
		/**
		 * 调到指定帧暂停
		 * @param frameOrLabel
		 */		
		public function gotoAndStop(frameOrLabel:*):void
		{
			
		}
	}
}