/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 12, 2015 3:31:34 PM			
 * ===================================
 */

package com.idzeir.components
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * 图片按钮基类
	 */	
	public class ImageButton extends Panel
	{
		protected var _normalBox:Sprite;
		protected var _overBox:Sprite;
		protected var _selectBox:Sprite;
		
		protected var _map:Vector.<Sprite> = new Vector.<Sprite>();
		protected var _skinMap:Vector.<String> = new Vector.<String>();
		
		private var _selected:Boolean = false;
		
		public function ImageButton()
		{
			super();
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
			if(!_bglayer.contains(_overBox))
			{
				skin = _selected?_selectBox:_normalBox;
			}
		}

		/**
		 * 配置按钮 皮肤 外部图片地址组，[normal,over,select]
		 * @param urls 
		 */		
		public function set skinUrlMap(urls:Array):void
		{
			if(urls.length!=3)
			{
				throw new Error("参数个数错误,应该为3个");
				return
			}
			_map.push(_normalBox,_overBox,_selectBox);
			urls.forEach(function(url:String,index:int,arr:Array):void
			{
				_skinMap.push(url);
			});
			getSkinImage();
		}
		
		/**
		 * 配置按钮 皮肤 显示对象组，[normal,over,select]
		 * @param urls
		 */		
		public function set skinMap(urls:Array):void
		{
			if(urls.length!=3)
			{
				throw new Error("参数个数错误,应该为3个");
				return
			}
			_map.push(_normalBox,_overBox,_selectBox);
			urls.forEach(function(child:DisplayObject,index:int,arr:Array):void
			{
				var box:DisplayObjectContainer = _map.shift();
				box.removeChildren();
				box.addChild(child);
			});
			_skinMap.length = 0;
			_map.length = 0;
			if(_width!=0||_height!=0)
			{
				setSize(_width,_height);
			}
		}
		
		protected function getSkinImage():void
		{
			if(_skinMap.length>0)
			{
				var url:String = _skinMap.shift();
				AssetsManager.getInstance().getImage(url,function(child:DisplayObject):void
				{
					var box:DisplayObjectContainer = _map.shift();
					box.removeChildren();
					box.addChild(child);
					getSkinImage();
				},function(res:String):void
				{
					getSkinImage();
				});
			}else{
				_skinMap.length = 0;
				_map.length = 0;
				if(_width!=0||_height!=0)
				{
					setSize(_width,_height);
				}
			}
		}
		
		override public function setSize(w:Number, h:Number, isFlow:Boolean=false):void
		{
			super.setSize(w,h,true);
		}
		
		override protected function setupGUI():void
		{
			skin = _normalBox;
		}
		
		override protected function initChildren():void
		{
			_normalBox ||= new Sprite();
			_overBox ||= new Sprite();
			_selectBox ||= new Sprite();
			
			super.initChildren();
			this.closelayer = null;
			this.mouseChildren = false;
			this.mouseEnabled = true;
			this.buttonMode = true;
		}
		
		private function set skin(value:DisplayObject):void
		{
			_bglayer.removeChildren();
			_bglayer.addChild(value);
		}
		
		override protected function addViewListeners():void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER,function():void
			{
				skin = _overBox;
			});
			this.addEventListener(MouseEvent.MOUSE_OUT,function():void
			{
				skin = _selected?_selectBox:_normalBox;
			});
		}
	}
}