/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 14, 2015 5:38:28 PM			
 * ===================================
 */

package com.idzeir.utils
{
	import com.idzeir.animation.Frame;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * 显示对象转序列图工具
	 */	
	public class SequenceUtil
	{
		/**
		 * 把显示对象转成序列帧
		 * @param source
		 * @return 
		 */		
		public static function toMap(source:*):Vector.<Frame>
		{
			var outMap:Vector.<Frame> = new Vector.<Frame>();
			
			if(source is MovieClip)
			{
				var mc:MovieClip = source as MovieClip;
				if(mc.totalFrames>1)
				{
					//多帧
					mc.gotoAndStop(1);
					do
					{
						outMap.push(getFrame(mc));
						if(mc.totalFrames == mc.currentFrame){
							break;
						}
						mc.nextFrame();
					}while(true);
					
					return outMap;
				}
			}
			if(source is DisplayObject)
			{
				outMap.push(getFrame(source));
			}
			return outMap;
		}
		
		/**
		 * 取得最小区域的可见帧
		 * @param source
		 * @return 
		 */		
		private static function getFrame(source:DisplayObject):Frame
		{
			var bmd:BitmapData = new BitmapData(source.width,source.height,true,0x00FFFFFF);
			bmd.draw(source);
			
			var rect:Rectangle = bmd.getColorBoundsRect(0xFF000000,0x00000000,false);
			bmd.dispose();
			
			var frameNode:Frame = new Frame(rect.width,rect.height,true,0x00FFFFFF);
			
			var matrix:Matrix = new Matrix();
			matrix.translate(-rect.x,-rect.y);
			
			frameNode.draw(source,matrix,null,null,null,true);
			
			return frameNode;
		}
	}
}