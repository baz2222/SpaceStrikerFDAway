package com.juniorgames.spacestrikerfdaway 
{
	import starling.display.Sprite;
	public class JGStarlingParticles extends Sprite 
	{
		private static var jgInstance:JGStarlingParticles;
		public function JGStarlingParticles() 
		{
			jgInstance = this;
			//super();
			
		}
		public static function getInstance():JGStarlingParticles
		{
			return jgInstance;
		}
		public function update():void
		{
			
		}
	}

}