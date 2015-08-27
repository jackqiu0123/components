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
		
		public function DropDownList(render:IRender = null,_dir:uint = DOWN)
		{
			super();
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
			}
		}
		
		protected function clear(e:ProviderEvent):void
		{
			trace("clear",e.index);
		}
		
		protected function change(e:ProviderEvent):void
		{
			trace("change",e.index);
		}
		
		protected function remove(e:ProviderEvent):void
		{
			trace("remove",e.index);
		}
		
		protected function add(e:ProviderEvent):void
		{
			trace("add",e.index);
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