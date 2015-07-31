/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jul 7, 2015 5:51:48 PM			
 * ===================================
 */

package com.idzeir.components
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * 渲染项接口
	 */	
	public interface IRender
	{
		/**
		 * 启动初始化接口
		 */		
		function startup(value:Object = null):void;
		
		function get warp():DisplayObject;
		
		function get definition():Class;
		
		function set owner(value:DisplayObjectContainer):void;
	}
}