/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 12, 2015 3:31:34 PM			
 * ===================================
 */

package com.idzeir.components
{
	import flash.display.DisplayObject;

	/**
	 * 按钮基类
	 */	
	public class Button extends Panel
	{
		
		public function Button()
		{
			super();
			AssetsManager.getInstance().getImage("logo.png",function(value:DisplayObject):void
			{
				addChild(value);
			},trace);
			
			AssetsManager.getInstance().getEmbed("lib.swf","com.idzeir.assets.Rect",function(value:DisplayObject):void
			{
				//value.x = 100;
				addChild(value);
			},trace);
		}
		
		override public function setSize(w:Number, h:Number, isFlow:Boolean=false):void
		{
			super.setSize(w,h,isFlow);
		}
		
		override protected function redraw():void
		{
			super.redraw();
		}
		
		override protected function initChildren():void
		{
			super.initChildren();
			this.closelayer = null;
		}
		
		override protected function addViewListeners():void
		{
			
		}
	}
}