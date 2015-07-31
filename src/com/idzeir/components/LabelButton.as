/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jun 15, 2015 4:46:04 PM			
 * ===================================
 */

package com.idzeir.components
{
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * label按钮
	 */	
	public class LabelButton extends Sprite
	{
		private const UP:String = "up";
		private const OVER:String = "over";
		private const DOWN:String = "down";
		private const MARGIN:int = 1;
		
		private var _label:TextField;
		
		private var _style:LabelButtonStyle;
		private var _status:String = UP;
		
		private var _bglayer:Shape;
		
		private var _tf:TextFormat;
		
		public function LabelButton(label:String,click:Function = null)
		{
			super();
			_bglayer = new Shape();
			this.addChild(_bglayer);
			
			_label = new TextField();
			
			_label.autoSize = "left";
			_label.selectable = false;
			_tf = new TextFormat(Style.font,12,null,true);
			
			this.label =  label;
			_label.x = _label.y = MARGIN;
			this.addChild(_label);
			
			this.mouseChildren = false;
			this.buttonMode = true;
			
			if(click)
			{
				this.addEventListener(MouseEvent.CLICK,click);
			}
			
			this.addEventListener(MouseEvent.ROLL_OVER,function():void
			{
				if(!_style)return;
				textColor = _style.overTextColor;
				backgroundColor = _style.overBackgroundColor;
				
			});
			this.addEventListener(MouseEvent.ROLL_OUT,function():void
			{
				if(!_style)return;
				if(this._status == DOWN)
				{
					textColor = _style.selectedTextColor;
					backgroundColor = _style.selectedBackgroundColor;
				}else{
					textColor = _style.normalTextColor;
					backgroundColor = _style.normalBackgroundColor;
				}
			});
			status = UP;
		}
		
		/**
		 * 设置是否启用背景（默认启用）
		 */		
		public function set background(bool:Boolean):void
		{
			_bglayer.visible = false;
		}
		
		/**
		 * 设置按钮文字颜色
		 */		
		private function set textColor(value:int):void
		{
			_label.textColor = value;
		}
		
		/**
		 * 设置按钮背景颜色
		 */		
		private function set backgroundColor(value:int):void
		{
			_bglayer.graphics.clear();
			_bglayer.graphics.beginFill(value);
			_bglayer.graphics.drawRoundRect(0,0,_label.width+2*MARGIN,_label.height+2*MARGIN,5,5);
			_bglayer.graphics.endFill();
		}
		
		/**
		 * 设置按钮文字
		 */		
		public function set label(value:String):void
		{
			_label.defaultTextFormat = _tf;
			_label.htmlText = value;
			status = _status;
		}
		
		public function get label():String
		{
			return _label.text;
		}
		
		/**
		 * 按钮状态 
		 */
		private function set status(value:String):void
		{
			_status = value;
			_style&&(style = _style);
		}
		
		/**
		 * 设置按钮显示样式
		 */		
		public function set style(value:LabelButtonStyle):void
		{
			_style = value;
			if(this._status == DOWN)
			{
				textColor = _style.selectedTextColor;
				backgroundColor = _style.selectedBackgroundColor;
			}else{
				textColor = _style.normalTextColor;
				backgroundColor = _style.normalBackgroundColor;
			}
		}
		/**
		 * 获取按钮样式（可以共享样式）
		 */		
		public function get style():LabelButtonStyle
		{
			return _style;
		}
	}
}