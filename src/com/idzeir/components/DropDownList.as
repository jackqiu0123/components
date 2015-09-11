/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 26, 2015 3:45:36 PM			
 * ===================================
 */

package com.idzeir.components
{
	import com.idzeir.data.Provider;
	import com.idzeir.data.ProviderEvent;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	[Event(name="change", type="flash.events.Event")]
	
	/**
	 * 下拉列表
	 */	
	public class DropDownList extends Sprite
	{
		//下拉列表方向类型
		public static const DOWN:uint = 40;
		public static const UP:uint = 38;
		
		private var _direct:uint = DOWN;
		
		private var _provider:Provider;
		
		private var _map:Dictionary = new Dictionary(true);
		private var _render:IRender;
		
		protected var _box:VBox;
		
		protected var _setWidth:Number = 0;
		protected var _setHeight:Number = 0;
		//protected var _slider:Slider;
		protected var _mask:Shape;

		private var _selectRender:IRender;
		
		private var _isOpen:Boolean = false;

		private var content:VBox;
		
		private var _index:uint = 0;
		
		public function DropDownList(render:IRender = null,_dir:uint = DOWN)
		{
			super();
			_render = render;
			addChildren();
		}
		
		/**
		 * 初始化显示对象
		 */		
		protected function addChildren():void
		{
			content = new VBox();
			content.gap = 0;
			
			_selectRender = new (_render.definition)();
			_selectRender.owner = content;
			_selectRender.startup();
			content.addChild(_selectRender.warp);
			
			_box = new VBox();//content.addChild(new VBox()) as VBox;
			_mask = new Shape()//content.addRawChild(new Shape()) as Shape;
			//_slider = this.addChild(new Slider()) as Slider;
			//_box.mask = _mask;
			
			this.addChild(content);
			
			setGUI();
			
			redraw();
			
			addViewListeners();
		}
		
		/**
		 * 增加默认的事件控制
		 */		
		protected function addViewListeners():void
		{
			/*_slider.addEventListener(Event.CHANGE,function():void
			{
				_box.y = -(_box.height - _mask.height)*_slider.value/100;
			});*/
			
			_box.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
			{
				var tar:IRender = e.target as IRender;
				if(tar)
				{
					for(var i:uint = 0; i<provider.size;++i)
					{
						var o:* = provider.getItemAt(i);
						if(o&&_map[o]==tar)
						{
							index = i;
							break;
						}
					}
				}
				close();
			});
			
			_selectRender.warp.addEventListener(MouseEvent.CLICK,function():void
			{
				if(_isOpen)
				{
					content.removeChild(_box);
				}else{
					content.addChild(_box);
				}
				_isOpen=!_isOpen;
			});
		}
		/**
		 * 当前下来条显示状态，true为显示下拉条，否则为隐藏
		 * @return 
		 */		
		public function get isOpen():Boolean
		{
			return _isOpen;
		}
		
		/**
		 * 当前选中的数据项
		 * @return 
		 */		
		public function get selectedItem():*
		{
			return provider.getItemAt(_index);
		}
		/**
		 * 关闭下拉列表
		 */		
		public function close():void
		{
			if(content.contains(_box))
			{
				content.removeChild(_box);
				_isOpen = false;
			}
		}
		/**
		 * 打开下拉列表
		 */		
		public function open():void
		{
			if(!content.contains(_box))
			{
				content.addChild(_box);
				_isOpen = true;
			}
		}
		
		/**
		 * 选中项索引
		 * @param value
		 */		
		public function set index(value:uint):void
		{
			if(_index!=value)
			{
				_index = value;
				_selectRender.startup(provider.getItemAt(value));
				if(willTrigger(Event.CHANGE))
				{
					dispatchEvent(new Event(Event.CHANGE));
				}
			}
		}
		/**
		 * @private
		 */		
		public function get index():uint
		{
			return _index;
		}
		
		/**
		 * 默认ui
		 */		
		protected function setGUI():void
		{
			_mask.graphics.beginFill(0xFFFFFF);
			_mask.graphics.drawRect(0,0,100,100);
			_mask.graphics.endFill();
			
			this.graphics.beginFill(0xFFFFFF,0);
			this.graphics.drawRect(0,0,100,100);
			this.graphics.endFill();
			
			//_slider.setSize(6,100);
			//_slider.percent = .5
			
			//默认大小
			_setWidth = _setHeight = 100;
		}
		/**
		 * 重绘布局
		 */		
		public function redraw():void
		{
			//_slider.x = _setWidth - _slider.width;
			//_slider.height = _setHeight;
			//拖动过的组件重新定位滑块有问题，
			//_slider.percent = .5;
			
			_mask.graphics.clear();
			_mask.graphics.beginFill(0xFFFFFF);
			_mask.graphics.drawRect(0,0,_setWidth,_setHeight);
			_mask.graphics.endFill();
			
			this.graphics.clear();
			this.graphics.beginFill(0xFFFFFF,0);
			this.graphics.drawRect(0,0,_setWidth,_setHeight);
			this.graphics.endFill();
		}
		/**
		 * 设置大小
		 * @param w 宽
		 * @param h 高
		 */		
		public function setSize(w:Number,h:Number):void
		{
			_setWidth = w;
			_setHeight = h;
			redraw();
		}
		/**
		 * 组件宽未设置情况为组件显示宽，默认宽100
		 * @param value
		 */		
		override public function set width(value:Number):void
		{
			_setWidth = value;
			redraw();
		}
		/**
		 * @private 
		 */		
		override public function get width():Number
		{
			if(_setWidth!=0)
			{
				return _setWidth;
			}
			return super.width;
		}
		/**
		 * 组件高未设置情况为组件显示高，默认宽100
		 * @param value
		 */		
		override public function set height(value:Number):void
		{
			_setHeight = value;
			redraw();
		}
		/**
		 * @private
		 */		
		override public function get height():Number
		{
			if(_setHeight!=0)
			{
				return _setHeight;
			}
			return super.height;
		}
		/**
		 * 组件显示的数据对象
		 * @param value
		 */		
		public function set provider(value:Provider):void
		{
			removeListeners();
			_provider = value;
			addListeners();
		}
		/**
		 * @private
		 */		
		public function get provider():Provider
		{
			return _provider;
		}
		/**
		 * 增加监听数据的事件
		 */		
		private function addListeners():void
		{
			if(_provider)
			{
				_provider.addEventListener(ProviderEvent.ADD,add);
				_provider.addEventListener(ProviderEvent.REMOVE,remove);
				_provider.addEventListener(ProviderEvent.CHANGE,change);
				_provider.addEventListener(ProviderEvent.CLEAR,clear);
				_provider.addEventListener(ProviderEvent.UPDATE,update);
				_provider.addEventListener(ProviderEvent.INSERT,add);
			}
		}
		/**
		 * 移除数据事件
		 */		
		private function removeListeners():void
		{
			if(_provider)
			{
				_provider.removeEventListener(ProviderEvent.ADD,add);
				_provider.removeEventListener(ProviderEvent.REMOVE,remove);
				_provider.removeEventListener(ProviderEvent.CHANGE,change);
				_provider.removeEventListener(ProviderEvent.CLEAR,clear);
				_provider.removeEventListener(ProviderEvent.UPDATE,update);
				_provider.removeEventListener(ProviderEvent.INSERT,add);
			}
		}
		/**
		 * 数据更新之后的处理，调用updateItem
		 * @param e
		 */		
		protected function update(e:ProviderEvent):void
		{
			var data:* = this.provider.getItemAt(e.index);
			var item:IRender = _map[data];
			if(item)
			{
				//更新数据
				item.startup(data);
				if(e.index==_index)
					_selectRender.startup(data);
			}
		}
		/**
		 * 数据情况之后的处理
		 * @param e
		 */		
		protected function clear(e:ProviderEvent):void
		{
			//trace("clear",e.index);
			for(var i:* in _map)
			{
				delete _map[i];
			}
			_box.removeChildren();
		}
		/**
		 * 数据覆盖的处理，直接替换provider元素
		 * @param e
		 */		
		protected function change(e:ProviderEvent):void
		{
			//trace("change",e.index);
			var data:* = this.provider.getItemAt(e.index);
			var item:IRender = _map[data];
			if(item)
			{
				//更新数据
				item.startup(data);
				if(e.index==_index)
					_selectRender.startup(data);
			}
		}
		/**
		 * 移除单条记录
		 * @param e
		 */		
		protected function remove(e:ProviderEvent):void
		{
			//trace("remove",e.index);
			var data:* = this.provider.getItemAt(e.index);
			var item:IRender = _map[data];
			if(item)
			{
				delete _map[data];
				_box.removeChild(item.warp);
			}
		}
		/**
		 * 增加数据处理
		 * @param e
		 */		
		protected function add(e:ProviderEvent):void
		{
			//trace("add",e.index);
			var item:IRender = new (_render.definition)();
			item.owner = this;
			var data:* = this.provider.getItemAt(e.index);
			_map[data] = item;
			item.startup(data);
			if(e.index==_index)
				_selectRender.startup(data);
			
			if((_box.numChildren-1)>=e.index)
			{
				_box.addChildAt(item.warp,e.index);
			}else{
				_box.addChild(item.warp);
			}
			
			updatePos();
		}

		/**
		 * 更新显示对象的位置
		 */		
		public function updatePos():void
		{
			
		}
		
		/**
		 * 下拉列表方向 
		 */
		public function get direct():uint
		{
			return _direct;
		}

		/**
		 * @private
		 */
		public function set direct(value:uint):void
		{
			_direct = value;
		}

	}
}