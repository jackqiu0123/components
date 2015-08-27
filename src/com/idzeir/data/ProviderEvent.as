/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 26, 2015 4:31:12 PM			
 * ===================================
 */

package com.idzeir.data
{
	import flash.events.Event;
	
	
	public class ProviderEvent extends Event
	{
		public static const CLEAR:String = "allClear";
		public static const REMOVE:String = "remove";
		public static const ADD:String = "add";
		public static const CHANGE:String = "change";
		public static const UPDATE:String = "update";
		
		private var _index:int = -1;
		
		public function ProviderEvent(type:String,index:int = -1, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_index = index;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		override public function clone():Event
		{
			return new ProviderEvent(type,index,bubbles,cancelable);
		}
	}
}