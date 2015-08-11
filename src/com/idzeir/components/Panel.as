/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jul 31, 2015 3:33:26 PM			
 * ===================================
 */

package com.idzeir.components
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * 面板容器
	 */	
	public class Panel extends Sprite
	{
		/**
		 * 设置宽 
		 */		
		protected var _width:Number = 0;
		/**
		 * 设置高 
		 */		
		protected var _height:Number = 0;
		/**
		 * 越界剪裁 
		 */		
		protected var _overFlow:Boolean = false;
		/**
		 * 关闭按钮右边距离 
		 */		
		protected var _closeMargin:Number = 3;
		
		protected var _bglayer:Sprite;
		protected var _elemBox:Sprite;
		protected var _closelayer:Sprite;
		protected var _mask:Shape;
		
		public function Panel()
		{
			super();
			this.mouseEnabled = false;
			initChildren();
		}
		override public function set width(value:Number):void
		{
			_width = value;
			redraw();
		}
		override public function set height(value:Number):void
		{
			_height = value;
			redraw();
		}
		/**
		 * 设置宽高
		 * @param w 宽
		 * @param h 高
		 * @param isFlow 是否越界剪裁
		 */		
		public function setSize(w:Number,h:Number,isFlow:Boolean = false):void
		{
			_width = w;
			_height = h;
			_overFlow = isFlow;
			redraw();
		}
		/**
		 * 越界剪裁设置
		 */		
		public function set overFlow(bool:Boolean):void
		{
			_overFlow = bool;
			redraw();
		}
		/**
		 * 添加容器显示对象
		 * @param child
		 * @return 
		 */		
		public function addElement(child:DisplayObject):DisplayObject
		{
			_elemBox.addChild(child);
			return child;
		}
		/**
		 * 设置容器背景显示对象，为null时候取消显示
		 */		
		public function set bglayer(value:DisplayObject):void
		{
			_bglayer.removeChildren();
			if(value)
			{
				_bglayer.addChild(value);
				redraw();
			}
		}
		/**
		 * 设置关闭按钮，为null时候取消显示
		 */		
		public function set closelayer(value:DisplayObject):void
		{
			_closelayer.removeChildren();
			if(value)
			{
				_closelayer.addChild(value);
				redraw();
			}
		}
		
		/**
		 * 初始化界面元素
		 */		
		protected function initChildren():void
		{
			_bglayer = new Sprite();
			_bglayer.mouseChildren = false;
			_bglayer.mouseEnabled = false;
			_bglayer.graphics.beginFill(0x000000,0);
			_bglayer.graphics.drawRect(0,0,_width,_height);
			_bglayer.graphics.endFill();
			this.addChild(_bglayer);
			_elemBox = new Sprite();
			_elemBox.mouseEnabled = false;
			this.addChild(_elemBox);
			_mask = new Shape();
			this.addChild(_mask);
			_closelayer = new Sprite();
			this.addChild(_closelayer);
			
			setupGUI();
			
			addViewListeners();
		}
		
		/**
		 * 设置ui事件
		 */		
		protected function addViewListeners():void
		{
			_closelayer.addEventListener(MouseEvent.CLICK,function():void
			{
				visible = false;
			},true);
		}
		
		/**
		 * 设置默认样式
		 */		
		protected function setupGUI():void
		{
			var lb:LabelButton = new LabelButton("X");
			lb.background = false;
			lb.style = new LabelButtonStyle(0xFFFFFF,null,null,null,0xFF0000,null);
			closelayer = lb;
		}
		
		protected function redraw():void
		{
			//重绘背景
			_bglayer.graphics.clear();
			_bglayer.graphics.beginFill(0x000000,0);
			_bglayer.graphics.drawRect(0,0,_width,_height);
			_bglayer.graphics.endFill();
			if(_bglayer.numChildren>0)
			{
				_bglayer.graphics.clear();
				_bglayer.width = _width;
				_bglayer.height = _height;
			}
			
			//设置剪裁
			_mask.graphics.clear();
			if(_overFlow)
			{
				_mask.graphics.beginFill(0xFFFFFF);
				_mask.graphics.drawRect(-1,-1,_width+2,_height+2);
				_mask.graphics.endFill();
				_elemBox.mask = _mask;
			}else{
				_elemBox.mask = null;
			}
			
			if(_closelayer.numChildren>0)
			{
				_closelayer.x = _width - _closelayer.width - _closeMargin;
				_closelayer.y = _closeMargin;
			}
		}
	}
}