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
		
		public function DropDownList(render:IRender = null,_dir:uint = DOWN)
		{
			super();
		}
		
		public function set dataProvider(value:Array):void
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