/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jun 19, 2015 2:36:05 PM			
 * ===================================
 */

package com.idzeir.acfun.components
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Radio组件
	 */	
	public class Radio extends HBox
	{
		private var _label:TextField;
		
		private var circle:Sprite;
		
		private var dot:Sprite;
		
		private const CIRCLE_R:int = 6;
		
		private var _selected:Boolean = false;
		
		public function Radio()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			init();
		}
		
		protected function init():void
		{
			this.algin = HBox.MIDDLE;
			this.gap = 3;
			
			_label ||= new TextField();
			_label.autoSize = "left";
			_label.mouseEnabled = false;
			_label.defaultTextFormat = new TextFormat(Style.font,12,0xffffff,true);
			
			circle ||= new Sprite();
			circle.graphics.lineStyle(2,0xffffff,1);
			circle.graphics.beginFill(0xffffff,0);
			circle.graphics.drawCircle(CIRCLE_R,CIRCLE_R,CIRCLE_R);
			circle.graphics.endFill();
			
			dot ||= new Sprite();
			dot.graphics.beginFill(0xff0000);
			const DOT_R:int = CIRCLE_R - 3;
			dot.graphics.drawCircle(DOT_R+3,DOT_R+3,DOT_R);
			dot.graphics.endFill();
			
			selected = false;
			circle.addChild(dot);
			this.addChild(circle);
			this.addChild(_label);
			
			this.mouseChildren = false;
			
			this.addEventListener(MouseEvent.CLICK,function():void
			{
				selected = !selected;
			});
			
		}
		
		public function set label(value:String):void
		{
			_label.text = value;
			update();
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(bool:Boolean):void
		{
			_selected = bool;
			dot.alpha = bool?1:0;
		}
		
		protected function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
	}
}