/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 11, 2015 2:10:01 PM			
 * ===================================
 */

package com.idzeir.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;

	[Event(name="change", type="flash.events.Event")]
	
	/**
	 * 复选框组件
	 */	
	public class CheckBox extends Panel
	{
		protected var _selected:Boolean = false;
		
		protected var _skin:Sprite;
		
		protected var _tag:TextField;
		
		protected var _tf:TextFormat;
		
		public function CheckBox()
		{
			super();
		}
		
		/**
		 * 选中状态 
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
			redraw();
		}

		override protected function initChildren():void
		{
			_tag = new TextField();
			_tf = new TextFormat("微软雅黑,宋体",18,0xFF0000,true);
			_skin = new Sprite();
			
			super.initChildren();
			
			this.closelayer = null;
			this.mouseChildren = false;
			this.mouseEnabled = true;
			this.buttonMode = true;
			
			this.addElement(_skin);
		}
		
		override public function setSize(w:Number, h:Number, isFlow:Boolean=false):void
		{
			super.setSize(w,h,true);
		}
		
		override protected function setupGUI():void
		{
			_skin.graphics.lineStyle(2,0x000000);
			_skin.graphics.beginFill(0xFFFFFF,_selected?.9:.8);
			_skin.graphics.drawRect(0,0,20,20);
			_skin.graphics.endFill();
			_tag.autoSize = "left";
			_tag.defaultTextFormat = _tf;
			_tag.text = "√";
			_tag.filters = [/*new DropShadowFilter(1,45,0xFF0000,1,1,1),*/new DropShadowFilter(1,225,0xFF0000,1,1,1)];
			
			_tag.x = _skin.width - _tag.width>>1;
			_tag.y = (_skin.height - _tag.height>>1) - 3;
			_skin.addChild(_tag);
		}
		
		override protected function redraw():void
		{
			_skin.graphics.clear();
			_skin.graphics.lineStyle(2,0x000000);
			_skin.graphics.beginFill(0xFFFFFF,_selected?.9:.8);
			_skin.graphics.drawRect(0,0,_width,_height);
			_skin.graphics.endFill();
			
			const scale:Number = Math.min(_width/20,_height/20);
			var size:uint = uint(18*scale);
			_tf.size = size;
			_tag.defaultTextFormat = _tf;
			_tag.text = "√";
			_tag.x = _skin.width - _tag.width>>1;
			_tag.y = (_skin.height - _tag.height>>1) - scale*3;
			
			_tag.visible = _selected;
			
			super.redraw();
		}
		
		override protected function addViewListeners():void
		{
			this.addEventListener(MouseEvent.CLICK,function():void
			{
				selected = !_selected;
				if(hasEventListener(Event.CHANGE))
				{
					dispatchEvent(new Event(Event.CHANGE));
				}
			});
		}
	}
}