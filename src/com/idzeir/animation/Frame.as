/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 14, 2015 4:31:24 PM			
 * ===================================
 */

package com.idzeir.animation
{
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * 动画帧节点
	 */	
	public class Frame extends BitmapData
	{
		private var _name:String = null;
		
		private var _offX:Number = 0;
		private var _offY:Number = 0;
		
		public function Frame(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
		
		/**
		 * y方向的偏移量 
		 */
		public function get offY():Number
		{
			return _offY;
		}

		/**
		 * x方向的便宜量 
		 */
		public function get offX():Number
		{
			return _offX;
		}

		override public function draw(source:IBitmapDrawable, matrix:Matrix=null, colorTransform:ColorTransform=null, blendMode:String=null, clipRect:Rectangle=null, smoothing:Boolean=false):void
		{
			super.draw(source, matrix, colorTransform, blendMode, clipRect, smoothing);
			_offX = -1*matrix.tx;
			_offY = -1*matrix.ty;
		}
		
		/**
		 * 动画帧名称
		 */
		public function get name():String
		{
			return _name;
		}

		/**
		 * @private
		 */
		public function set name(value:String):void
		{
			_name = value;
		}

		//======取消原有的销毁和复制
		override public function dispose():void {}
		override public function clone():BitmapData { return this;}
	}
}