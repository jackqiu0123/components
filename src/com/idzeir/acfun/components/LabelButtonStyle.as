/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jun 19, 2015 12:26:14 PM			
 * ===================================
 */

package com.idzeir.acfun.components
{
	/**
	 * LabelButton 显示样式
	 */	
	public class LabelButtonStyle
	{
		/**
		 * 默认颜色 
		 */		
		private static var DEFAULT_TEXT_COLOR:int = 0x000000;
		private static var DEFAULT_BG_COLOR:int = 0xFFFFFF;
		
		private var _colors:Array;
		/**
		 * colors 依次为普通状态，选中状态，滑入状态的字体颜色和背景颜色，
		 * 例如：0xFFFFFF,0XFF0000是定义了普通状态的字体颜色和背景
		 */		
		public function LabelButtonStyle(...colors:*)
		{
			_colors = colors;
		}
		/**
		 * 默认未选中字体颜色
		 */		
		public function get normalTextColor():int
		{
			return _colors.length > 0?(_colors[0]||DEFAULT_TEXT_COLOR):DEFAULT_TEXT_COLOR;
		}
		/**
		 * 默认背景颜色
		 */		
		public function get normalBackgroundColor():int
		{
			return _colors.length > 1?(_colors[1]||DEFAULT_BG_COLOR):DEFAULT_BG_COLOR;
		}
		/**
		 * 选中状态字体颜色
		 */		
		public function get selectedTextColor():int
		{
			return _colors.length > 2?(_colors[2]||normalTextColor):normalTextColor;
		}
		/**
		 * 选中状态背景颜色
		 */		
		public function get selectedBackgroundColor():int
		{
			return _colors.length > 3?(_colors[3]||normalBackgroundColor):normalBackgroundColor;
		}
		/**
		 * 滑入状态字体颜色
		 */		
		public function get overTextColor():int
		{
			return _colors.length > 4?(_colors[4]||normalTextColor):normalTextColor;
		}
		/**
		 * 滑入状态背景颜色
		 */		
		public function get overBackgroundColor():int
		{
			return _colors.length > 5?(_colors[5]||normalBackgroundColor):normalBackgroundColor;
		}
	}
}