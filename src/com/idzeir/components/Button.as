/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 13, 2015 5:12:47 PM			
 * ===================================
 */

package com.idzeir.components
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.idzeir.utils.AssetsManager;

	/**
	 * 普通按钮
	 */	
	public class Button extends Panel
	{
		//按钮状态
		private const OVER:String = "over";
		private const NORMAL:String = "normal";
		private const SELECTED:String = "selected";
		
		/**
		 * 按钮当前状态 
		 */		
		private var _stats:String = NORMAL;
		
		private var _selected:Boolean = false;
		
		private var _skin:DisplayObject;
		
		public function Button()
		{
			super();
		}
		
		/**
		 * 设置外部库swf皮肤
		 * @param url 库地址
		 * @param definition 库内定义
		 */		
		public function setUrlSkin(url:String,definition:String = null):void
		{
			AssetsManager.getInstance().getEmbed(url,definition,function(child:DisplayObject):void
			{
				_bglayer.removeChildren();
				_skin = _bglayer.addChild(child);
				stats = _stats;
			},trace);
		}
		
		/**
		 * 设置显示对象皮肤
		 * @param child
		 */		
		public function setSkin(child:DisplayObject):void
		{
			_bglayer.removeChildren();
			_skin = _bglayer.addChild(child);
			stats = _stats;
		}
		
		/**
		 * 是否选中状态 
		 */
		public function get selected():Boolean
		{
			return _selected;
		}
		
		/**
		 * @private
		 */
		public function set selected(value:Boolean):void
		{
			_selected = value;
			//非滑入状态切换显示
			if(!_stats == OVER)
			{
				stats = _selected?SELECTED:NORMAL;
			}
		}
		
		override public function setSize(w:Number, h:Number, isFlow:Boolean=false):void
		{
			super.setSize(w,h,true);
		}
		
		override protected function setupGUI():void
		{
			stats = NORMAL;
		}
		
		override protected function initChildren():void
		{
			super.initChildren();
			this.closelayer = null;
			this.mouseChildren = false;
			this.mouseEnabled = true;
			this.buttonMode = true;
		}
		
		private function set stats(value:String):void
		{
			_stats = value;
			var mcSkin:MovieClip = _skin as MovieClip;
			if(mcSkin&&mcSkin.currentLabels.indexOf(value)!=-1)
			{
				mcSkin.gotoAndStop(value);
			}
			if(_width!=0||_height!=0)
			{
				setSize(_width,_height);
			}
		}
		
		override protected function addViewListeners():void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER,function():void
			{
				stats = OVER;
			});
			this.addEventListener(MouseEvent.MOUSE_OUT,function():void
			{
				stats = _selected?SELECTED:NORMAL;
			});
		}
	}
}