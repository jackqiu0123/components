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
		
		private var _index:int = -1;
		
		public function ProviderEvent(type:String,index:int = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
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