/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jun 19, 2015 12:13:45 PM			
 * ===================================
 */

package com.idzeir.acfun.components
{
	/**
	 * 统一字体工具
	 */	
	public class Style
	{
		private static var _font:String = "微软雅黑,宋体";
		
		public static function get font():String
		{
			return _font;
		}
		
		public static function set font(value:String):void
		{
			_font = value;
		}
	}
}