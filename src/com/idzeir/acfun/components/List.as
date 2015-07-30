/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jul 7, 2015 5:49:48 PM			
 * ===================================
 */

package com.idzeir.acfun.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	[Event(name="select", type="flash.events.Event")]
	/**
	 * 列表容器
	 */	
	public class List extends VBox
	{
		private var _render:IRender = new LabelRender();
		
		private var _selected:int;
		
		public function List()
		{
			super();
			gap = 0;
			_content.mouseEnabled = mouseEnabled = false;
			_content.mouseChildren = true;
			this._content.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
			{
				var tar:IRender = e.target as IRender;
				if(tar)
				{
					_selected = _content.getChildIndex(tar.warp);
					dispatchEvent(new Event(Event.SELECT));
				}
			});
		}
		
		public function get selected():int
		{
			return _selected;
		}

		public function withRender(skin:*):List
		{
			_render = skin;
			return this;
		}
		
		public function set dateProvider(value:Array):void
		{
			this.removeChildren();
			for each(var i:* in value)
			{
				var item:IRender = new (_render.definition)();
				item.owner = _content;
				item.startup(i);
				this.addChild(item.warp);
			}
		}
		
		
	}
}