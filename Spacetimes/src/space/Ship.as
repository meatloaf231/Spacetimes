package space 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author reGen
	 */
	public class Ship extends FlxSprite
	{
		protected var missleStartSpeed:Number = 200;
		public var startingVelocity:Number = 75;
		public var reloadMissle:Number = 0;
		protected var reloadMissleDuration:Number = 40;
		public var score:Number = 0;
		public var who:String;
		
		public function Ship(X:Number=0,Y:Number=0,ImgShip:Class=null):void
		{
			super(X, Y, ImgShip);
			velocity.y = startingVelocity;
		}
		
		override public function update():void
		{
			var force:Number;
			force = 0.0066742795;
			velocity.x += force * (this.x - (FlxG.width / 2)) * ( -1.0);
			velocity.y += force * (this.y - (FlxG.height / 2)) * ( -1.0);
			
			maxAngular = 180;
			maxVelocity.x = 250;
			maxVelocity.y = 250;
			angularDrag = 5;
			
			if ( -15 <= angularVelocity && angularVelocity <= 15)
			{
				angularVelocity = 0;
			}
			
			if (reloadMissle)
			{
				reloadMissle -= 1;
			}
			
			super.update();
		}
		
	}

}