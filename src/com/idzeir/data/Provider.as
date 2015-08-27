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
	import flash.events.EventDispatcher;
	
	/**每增加一条数据激发一次*/
	[Event(name="add", type="com.idzeir.data.ProviderEvent")]
	/**删除单条数据时候激发*/
	[Event(name="remove", type="com.idzeir.data.ProviderEvent")]
	/**发送数据覆盖时候激发*/
	[Event(name="change", type="com.idzeir.data.ProviderEvent")]
	/**清空对象时候激发*/
	[Event(name="clear", type="com.idzeir.data.ProviderEvent")]
	
	/**
	 * 组件数据 
	 */	
	public class Provider extends EventDispatcher
	{
		/**数据容器*/
		private var _map:Array = [];
		
		/**
		 * 将数组转换成provider
		 * @param value
		 */		
		public function Provider(value:Array = null)
		{
			value&&(map = value);
		}
		
		public function set map(value:Array):void
		{
			removeAll();
			value&&value.forEach(function(e:*,index:int,arr:Array):void
			{
				addItem(e);
			});
		}
		/**
		 * JSON化数据对象转成字符串，使用内置JSON
		 * @return 
		 */		
		override public function toString():String
		{
			return JSON.stringify(_map);
		}
		
		/**
		 * 返回内容索引
		 * @param value
		 * @return 
		 */		
		public function indexOf(value:*):int
		{
			return _map.indexOf(value);
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
			
			if(this.willTrigger(!isChange ? ProviderEvent.ADD : ProviderEvent.CHANGE))
			{
				this.dispatchEvent(new ProviderEvent(!isChange ? ProviderEvent.ADD : ProviderEvent.CHANGE,index));
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
				throw new Error("指定索引超出范围",index);
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