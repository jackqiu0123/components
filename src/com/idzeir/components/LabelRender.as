/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jul 7, 2015 5:54:44 PM			
 * ===================================
 */

package com.idzeir.components
{
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * list容器默认渲染项
	 */	
	public class LabelRender extends Sprite implements IRender
	{
		
		private var _tf:TextFormat;
		
		protected var _label:TextField;
		
		private var _owner:DisplayObjectContainer;
		
		public function LabelRender()
		{
			super();
			this.mouseChildren = false;
			_label = new TextField();
			_label.autoSize = "left";
			_label.multiline = false;
			_label.wordWrap = false;
			_tf = new TextFormat(Style.font);
			_label.defaultTextFormat = _tf;
			_label.selectable = false;
			
			this.addChild(_label);
			
			this.addEventListener(MouseEvent.ROLL_OVER,over);
			this.addEventListener(MouseEvent.ROLL_OUT,out);
		}
		
		/**
		 * 参数数字符串
		 */		
		public function startup(value:Object=null):void
		{
			_label.htmlText = value.toString();
		}
		
		public function get warp():DisplayObject
		{
			return this;
		}
		
		public function over(e:Event):void
		{
			_label.textColor = 0xFF0000;
			this.graphics.beginFill(0x000000,.1);
			this.graphics.drawRect(-x,0,_owner.width,_label.height);
			this.graphics.endFill();
		}
		
		public function out(e:Event):void
		{
			_label.textColor = Number(this._tf.color);
			this.graphics.clear();
		}
		
		public function get definition():Class
		{
			return LabelRender;
		}
		
		public function set owner(value:DisplayObjectContainer):void
		{
			_owner = value;
		}
	}
}