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
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	/**
	 * 下拉列表
	 */	
	public class DropDownList extends Sprite
	{
		//下拉列表方向类型
		public static const DOWN:uint = 40;
		public static const UP:uint = 38;
		public static const RIGHT:uint = 39;
		public static const LEFT:uint = 37;
		
		
		private var _direct:uint = DOWN;
		
		private var _provider:Provider;
		
		private var _map:Dictionary = new Dictionary(true);
		private var _render:IRender;
		
		private var _box:VBox;
		
		public function DropDownList(render:IRender = null,_dir:uint = DOWN)
		{
			super();
			_render = render;
			_box = this.addChild(new VBox()) as VBox;
		}
		
		public function set dataProvider(value:Provider):void
		{
			removeListeners();
			_provider = value;
			addListeners();
		}
		
		public function get provider():Provider
		{
			return _provider;
		}
		
		private function addListeners():void
		{
			if(_provider)
			{
				_provider.addEventListener(ProviderEvent.ADD,add);
				_provider.addEventListener(ProviderEvent.REMOVE,remove);
				_provider.addEventListener(ProviderEvent.CHANGE,change);
				_provider.addEventListener(ProviderEvent.CLEAR,clear);
				_provider.addEventListener(ProviderEvent.UPDATE,update);
			}
		}
		
		private function removeListeners():void
		{
			if(_provider)
			{
				_provider.removeEventListener(ProviderEvent.ADD,add);
				_provider.removeEventListener(ProviderEvent.REMOVE,remove);
				_provider.removeEventListener(ProviderEvent.CHANGE,change);
				_provider.removeEventListener(ProviderEvent.CLEAR,clear);
				_provider.removeEventListener(ProviderEvent.UPDATE,update);
			}
		}
		
		protected function update(e:ProviderEvent):void
		{
			var data:* = this.provider.getItemAt(e.index);
			var item:IRender = _map[data];
			if(item)
			{
				//更新数据
				item.startup(data);
			}
		}
		
		protected function clear(e:ProviderEvent):void
		{
			//trace("clear",e.index);
			for(var i:* in _map)
			{
				delete _map[i];
			}
			_box.removeChildren();
		}
		
		protected function change(e:ProviderEvent):void
		{
			//trace("change",e.index);
			var data:* = this.provider.getItemAt(e.index);
			var item:IRender = _map[data];
			if(item)
			{
				//更新数据
				item.startup(data);
			}
		}
		
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
		
		protected function add(e:ProviderEvent):void
		{
			//trace("add",e.index);
			var item:IRender = new (_render.definition)();
			item.owner = this;
			var data:* = this.provider.getItemAt(e.index);
			_map[data] = item;
			item.startup(data);
			_box.addChild(item.warp);
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