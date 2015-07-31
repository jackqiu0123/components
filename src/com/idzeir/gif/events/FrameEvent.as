package com.idzeir.gif.events {	
	import com.idzeir.gif.frames.GIFFrame;
	
	import flash.events.Event;
	
	public class FrameEvent extends Event	
	{
		public var frame:GIFFrame;
	
		public static const FRAME_RENDERED:String = "rendered";
		
		public function FrameEvent ( pType:String, pFrame:GIFFrame )		
		{
			super ( pType, false, false );
			
			frame = pFrame;	
		}
	}
}