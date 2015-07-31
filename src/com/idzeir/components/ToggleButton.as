/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Jun 19, 2015 12:03:01 PM			
 * ===================================
 */

package com.idzeir.components
{
	public class ToggleButton extends HBox
	{
		
		public function ToggleButton()
		{
			super();
			this.algin = HBox.MIDDLE;
			this.gap = 0;
			this.mouseEnabled = false;
			
			this.addChild(new LabelButton("<font color='#ffff'>开</font>"));
			this.addChild(new LabelButton("<font color='#ffff' size='20'>关</font>"));
		}
	}
}