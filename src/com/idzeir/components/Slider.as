/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 10, 2015 11:26:23 AM			
 * ===================================
 */

package com.idzeir.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	[Event(name="change", type="flash.events.Event")]

	/**
	 * 滑动条组件 
	 */	
	public class Slider extends Panel
	{
		//向上箭头
		protected var _up:Sprite;
		//向下箭头
		protected var _down:Sprite;
		//滑块
		protected var _block:Sprite;
		protected var _blockbglayer:Sprite;
		
		public static const HOR:String = "h";
		public static const VER:String = "v";
		
		private var _box:Box;
		/**
		 * 滚动条方向 
		 */		
		private var _direct:String = VER;
		/**
		 * 值改变计时器id 
		 */		
		private var _vaildId:int = 0;
		/**
		 * 当前值(0-100) 
		 */		
		protected var _value:Number = 0;
		
		/**
		 * 滑动条
		 * @param dir 显示方向，默认为"v"垂直，可用"h"水平替代
		 */		
		public function Slider(dir:String = VER)
		{
			_direct = dir;
			switch(dir)
			{
				case HOR:
					_box = new HBox();
					HBox(_box).algin = HBox.MIDDLE;
					break;
				case VER:
					_box = new VBox();
					VBox(_box).algin = VBox.CENTER;
					break;
			}
			_box.gap = 0;
			super();
		}
		/**
		 * 滑块显示比例,外部主动按照内容高和slider的差距刷新此值
		 */		
		public function set percent(value:Number):void
		{
			value = Math.min(1,Math.max(value,0.01));
			switch(_direct)
			{
				case HOR:
					_block.width = _blockbglayer.width*value;
					break;
				case VER:
					_block.height = _blockbglayer.height*value;
					break;
			}
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		override protected function setupGUI():void
		{
			_up.graphics.beginFill(0xFF0000);
			_up.graphics.drawRect(0,0,10,10);
			_up.graphics.endFill();
			
			_block.graphics.beginFill(0x00FF00);
			_block.graphics.drawRect(0,0,10,10);
			_block.graphics.endFill();
			
			_blockbglayer.graphics.beginFill(0x343434);
			_blockbglayer.graphics.drawRect(0,0,10,10);
			_blockbglayer.graphics.endFill();
			
			_down.graphics.beginFill(0xFF0000);
			_down.graphics.drawRect(0,0,10,10);
			_down.graphics.endFill();
		}
		
		override protected function redraw():void
		{
			_blockbglayer.graphics.clear();
			_blockbglayer.graphics.beginFill(0x343434);
			switch(_direct)
			{
				case HOR:
					_up.height = _down.height = _block.height = _height;
					_blockbglayer.graphics.drawRect(0,0,_width - _up.width - _down.width,_height);
					break;
				case VER:
					_up.width = _down.width = _block.width = _width;
					_blockbglayer.graphics.drawRect(0,0,_width,_height - _up.height - _down.height);
					break;
			}
			_blockbglayer.graphics.endFill();
			_box.update();
			super.redraw();
		}
		
		override protected function initChildren():void
		{
			_up = new Sprite();
			_block = new Sprite();
			_blockbglayer = new Sprite();
			_down = new Sprite();
			
			_up.buttonMode = _down.buttonMode = _block.buttonMode = true;
			_up.mouseChildren = _down.mouseChildren = _block.mouseChildren = false;
			_blockbglayer.mouseEnabled = false;
			
			super.initChildren();
			
			closelayer = null;
			
			_blockbglayer.addChild(_block);
			_box.addChild(_up);
			_box.addChild(_blockbglayer);
			_box.addChild(_down);
			
			this.addElement(_box);
		}
		
		override protected function addViewListeners():void
		{
			this.mouseEnabled = true;
			this.mouseChildren = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			var tar:Sprite = event.target as Sprite;
			
			if(!tar)return;
			
			switch(tar)
			{
				case _up:
				case _down:
					_vaildId = setInterval(vaild,100);
					stage.addEventListener(MouseEvent.MOUSE_UP,function():void
					{
						stage.removeEventListener(MouseEvent.MOUSE_UP,arguments.callee);
						//停止滑动
						clearInterval(_vaildId);
					});
					break;
				case _block:
					_vaildId = setInterval(vaild,100);
					_block.startDrag(false,new Rectangle(0,0,_direct==VER?0:_blockbglayer.width - _block.width,_direct==VER?_blockbglayer.height - _block.height:0));
					stage.addEventListener(MouseEvent.MOUSE_UP,function():void
					{
						stage.removeEventListener(MouseEvent.MOUSE_UP,arguments.callee);
						//停止滑动
						_block.stopDrag();
						clearInterval(_vaildId);
					});
					break;
			}
		}
		
		protected function vaild():void
		{
			var newValue:Number = 0;
			switch(_direct)
			{
				case HOR:
					newValue = _block.x/(_blockbglayer.width - _block.width);
					break;
				case VER:
					newValue = _block.y/(_blockbglayer.height - _block.height);
					break;
			}
			newValue = Math.min(1,Math.max(0,newValue))*100
			if(_value!=newValue)
			{
				_value = newValue;
				if(this.hasEventListener(Event.CHANGE))
				{
					this.dispatchEvent(new Event(Event.CHANGE));
				}
			}
		}
	}
}