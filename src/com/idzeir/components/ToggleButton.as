/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jun 19, 2015 12:03:01 PM			
 * ===================================
 */

package com.idzeir.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[Event(name="change", type="flash.events.Event")]
	/**
	 * 状态切换按钮
	 * @author iDzeir
	 */	
	public class ToggleButton extends Box
	{
		private var _map:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		
		private var _index:uint = 0;
		
		/**
		 * 切换按钮
		 */		
		public function ToggleButton()
		{
			super();
			this.mouseChildren = false;
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.CLICK,function():void
			{
				if(++_index>=_map.length)
				{
					_index = 0;
				}
				update();
				dispatchEvent(new Event(Event.CHANGE));
			});
		}
		
		/**
		 * 当前显示的索引
		 * @return 
		 */		
		public function get index():uint
		{
			return _index;
		}
		/**
		 * @private
		 */		
		public function set index(value:uint):void
		{
			if(value>=_map.length)return;
			_index = value;
			update();
		}
		/**
		 * 添加一个显示索引
		 * @param value 显示对象
		 * @param index 添加的位置，默认-1为添加到队尾
		 * @return 返回参数value显示对象
		 */		
		public function addTog(value:DisplayObject,index:int = -1):DisplayObject
		{
			if(index==-1)
				_map.push(value);
			else
				_map.splice(index,0,value);
			
			update();
			
			return value;
		}
		/**
		 * 移除一个切换的对象，不会改变旧的索引值
		 * @param index 要移除的索引
		 * @return 删除的显示对象，操作失败返回null。
		 */		
		private function removeTogAt(index:int):DisplayObject
		{
			if(_map.length>index)
			{
				var item:DisplayObject = _map.splice(index,1)[0];
				this.removeChild(item);
				update();
				return item;
			}
			return null;
		}
		
		private function update():void
		{
			this.removeChildren();
			if(_map.length!=0)
			{
				var item:DisplayObject = _map.length>_index?_map[_index]:null;
				item&&addChild(item);
			}
		}
	}
}