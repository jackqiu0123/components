/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jun 9, 2015 3:09:00 PM			
 * ===================================
 */

package com.idzeir.components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	
	public class Box extends Sprite
	{
		protected var _gap:int = 0;
		protected var _content:Sprite;
		
		private var _bounds:Rectangle = new Rectangle();
		
		public function Box()
		{
			super();
			_content = new Sprite();
			_content.mouseEnabled = false;
			super.addChild(_content);
		}
		
		public function set gap(value:int):void
		{
			_gap = value;
		}
		/**
		 * 容器显示对象的长宽
		 */		
		public function get bounds():Rectangle
		{
			_bounds.width = _bounds.height = 0;
			for(var i:uint = 0;i<_content.numChildren;++i)
			{
				_bounds.width = Math.max(_bounds.width,_content.getChildAt(i).width);
				_bounds.height = Math.max(_bounds.height,_content.getChildAt(i).height);
			}
			return _bounds;
		}
		
		public function addRawChild(child:DisplayObject):DisplayObject
		{
			return super.addChild(child);
		}
		
		public function removeRawChild(child:DisplayObject):DisplayObject
		{
			return super.removeChild(child);
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			_content.addChild(child);
			update();
			return child;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			_content.removeChild(child);
			update();
			return child;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			_content.addChildAt(child,index);
			update();
			return child;
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = _content.removeChildAt(index);
			update();
			return child;
		}
		
		public function getRawChildAt(index:int):DisplayObject
		{
			return super.getChildAt(index);
		}
		
		override public function getChildAt(index:int):DisplayObject
		{
			return _content.getChildAt(index);
		}
		
		public function get numRawChildren():int
		{
			return super.numChildren;
		}
		
		override public function get numChildren():int
		{
			return _content.numChildren;
		}
		
		override public function getChildIndex(child:DisplayObject):int
		{
			return _content.getChildIndex(child);
		}
		
		public function getRawChildIndex(child:DisplayObject):int
		{
			return super.getChildIndex(child);
		}
		
		override public function removeChildren(beginIndex:int=0, endIndex:int=2147483647):void
		{
			_content.removeChildren(beginIndex,endIndex);
		}
		
		public function removeRawChildren(beginIndex:int=0, endIndex:int=2147483647):void
		{
			super.removeChildren(beginIndex,endIndex);
		}
		
		public function update():void
		{
			
		}
	}
}