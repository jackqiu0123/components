/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jun 9, 2015 3:09:21 PM			
 * ===================================
 */

package com.idzeir.acfun.components
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public class VBox extends Box
	{
		public static const LEFT:uint = 0;
		public static const CENTER:uint = 1;
		public static const RIGHT:uint = 2;
		
		private var _algin:uint = LEFT;
		
		public function VBox()
		{
			super();
			_gap = 5;
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
				child.y = _sPos;
				_sPos += child.height + _gap;
				switch(_algin)
				{
					case LEFT:
						child.x = 0;
						break;
					case CENTER:
						child.x = (bound.width - child.width)*.5;
						break;
					case RIGHT:
						child.x = bound.width - child.width;
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
		
		override public function get height():Number
		{
			return _content.height + 2*_gap;
		}
	}
}