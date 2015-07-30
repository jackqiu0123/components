/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jun 19, 2015 3:53:22 PM			
 * ===================================
 */

package com.idzeir.acfun.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[Event(name="change", type="flash.events.Event")]
	/**
	 * 单选radio组
	 */	
	public class RadioGroup extends HBox
	{
		private var _map:Array = null;
		
		public function RadioGroup()
		{
			super();
			this.algin = HBox.MIDDLE;
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			this.addEventListener(MouseEvent.CLICK,onClick,true);
		}
		
		protected function onClick(e:MouseEvent):void
		{
			var tarRadio:Radio = e.target as Radio;
			if(tarRadio)
			{
				for each(var i:Radio in _map)
				{
					i.selected = i==tarRadio;
				}
				//阻止radio点击事件
				e.stopImmediatePropagation();
				e.stopPropagation();
				this.dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		/**
		 * 一组单选的radio
		 */		
		public function set group(value:Array):void
		{
			for each(var i:Radio in value)
			{
				this.addChild(i);
			}
			_map = value;
		}
		
		/**
		 * 当前选中的索引
		 */		
		public function get index():int
		{
			for(var i:uint = 0;i<_map.length;i++)
			{
				if(_map[i].selected)
				{
					return i;
				}
			}
			return -1;
		}
		
		/**
		 * 指定当前选中radio
		 */		
		public function set index(value:int):void
		{
			for(var i:uint = 0; i<_map.length;++i)
			{
				_map[i].selected = (i == value);
			}
		}
	}
}