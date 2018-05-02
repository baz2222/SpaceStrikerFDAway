package com.juniorgames.spacestrikerfdaway 
{
	import starling.display.Sprite;
	public class JGStarlingSprite extends Sprite 
	{
		private static var jgInstance:JGStarlingSprite;
		public function JGStarlingSprite() 
		{
			jgInstance = this;
			//super();
			
		}
		public static function getInstance():JGStarlingSprite
		{
			return jgInstance;
		}
		public function update():void
		{
			
		}
	}

}