/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 26, 2015 3:52:39 PM			
 * ===================================
 */

package com.idzeir.data
{
	import flash.errors.StackOverflowError;
	import flash.events.EventDispatcher;
	
	public class Provider extends EventDispatcher
	{
		private var _map:Array = [];
		
		public function Provider(value:Array = null)
		{
			value&&(map = value);
		}
		
		public function set map(value:Array):void
		{
			removeAll();
			value.forEach(function(e:*,index:int,arr:Array):void
			{
				addItem(e);
			});
		}
		
		/**
		 * 添加一条数据，激发ProviderEvent.ADD
		 * @param value
		 */		
		public function addItem(value:Object):void
		{
			_map.push(value);
			
			if(this.willTrigger(ProviderEvent.ADD))
			{
				this.dispatchEvent(new ProviderEvent(ProviderEvent.ADD,_map.length-1));
			}
		}
		/**
		 * 删除一条数据，激发ProviderEvent.REMOVE
		 * @param value
		 */		
		public function removeItem(value:Object):void
		{
			var index:int = _map.indexOf(value);
			if(index!=-1)
			{
				removeItemAt(index);
			}
		}
		/**
		 * 提加到指定位置一条数据，初始化激发ProviderEvent.ADD,覆盖数据激活ProviderEvent.CHANGE
		 * @param index 索引位置
		 * @param value 
		 */		
		public function addItemAt(index:int,value:Object):void
		{
			var isChange:Boolean = _map[index] == null ? false : true;
			
			_map[index] = value;
			
			if(this.willTrigger(isChange ? ProviderEvent.ADD : ProviderEvent.CHANGE))
			{
				this.dispatchEvent(new ProviderEvent(isChange ? ProviderEvent.ADD : ProviderEvent.CHANGE,index));
			}
		}
		/**
		 * 删除指定位置的数据，激发ProviderEvent.REMOVE
		 * @param index
		 */		
		public function removeItemAt(index:int):void
		{
			if(_map.length>index)
			{
				_map.splice(index,1);
				if(this.willTrigger(ProviderEvent.REMOVE))
				{
					this.dispatchEvent(new ProviderEvent(ProviderEvent.REMOVE,index));
				}
			}else{
				throw new StackOverflowError("指定索引超出范围",index);
			}
		}
		/**
		 * 清楚全部数据，激发ProviderEvent.CLEAR
		 */		
		public function removeAll():void
		{
			if(_map.length>0&&this.willTrigger(ProviderEvent.CLEAR))
			{
				this.dispatchEvent(new ProviderEvent(ProviderEvent.CLEAR));
			}
			_map.length = 0;
		}
		
	}
}