/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jun 19, 2015 12:03:51 PM			
 * ===================================
 */

package com.idzeir.acfun.components
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public class HBox extends Box
	{
		public static const TOP:uint = 0;
		public static const MIDDLE:uint = 1;
		public static const BOTTOM:uint = 2;
		
		private var _algin:uint = TOP;
		
		public function HBox()
		{
			super();
		}
		
		override public function update():void
		{
			super.update();
			//间隔逻辑
			var _sPos:int = _gap;
			var bound:Rectangle = bounds;
			
			for(var i:uint = 0;i<numChildren;++i)
			{
				var child:DisplayObject = getChildAt(i);
				child.x = _sPos;
				_sPos += child.width + _gap;
				switch(_algin)
				{
					case TOP:
						child.y = 0;
						break;
					case MIDDLE:
						child.y = (bound.height - child.height)*.5;
						break;
					case BOTTOM:
						child.y = bound.height - child.height;
						break;
				}
			}
		}
		
		public function set algin(value:uint):void
		{
			_algin = value;
			update();
		}
		
		public function set gap(value:int):void
		{
			_gap = value;
			update();
		}
		
		override public function get width():Number
		{
			return _content.width + 2*_gap;
		}
	}
}