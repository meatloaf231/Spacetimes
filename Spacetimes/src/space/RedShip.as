package space 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author reGen
	 */
	public class RedShip extends Ship
	{
		[Embed(source = "../../Assets/Ship_red_2.png")] 
		private var ImgShip:Class;
		
		public function RedShip():void
		{
			super((FlxG.width * 7) / 8, FlxG.height / 2, ImgShip);
			velocity.y *= -1
			who = "redShip";
		}
		
		override public function update():void
		{
			maxAngular = 180;
			maxVelocity.x = 250;
			maxVelocity.y = 250;
			angularDrag = 5;
			
			if (FlxG.keys.A)
			{
				angularVelocity -= 20;
			}
			
			else if (FlxG.keys.D)
			{
				angularVelocity += 20;
			}
			
			else
			{
				angularVelocity /= 1.25;
				if (angularVelocity < 2)
					angularVelocity = 0;
			}
			
			if (FlxG.keys.W)
			{
				velocity.x += Math.sin(angle * (Math.PI / 180)) * 5;
				velocity.y += -Math.cos(angle * (Math.PI / 180)) * 5;
			}
			
			else if (FlxG.keys.S)
			{
				angularVelocity /= 1.25;
				if (angularVelocity < 2)
					angularVelocity = 0;
			}
			
			super.update();
		}
		
		public function getRedMissileLaunchInformation():FlxObject
		{
			reloadMissle = reloadMissleDuration;
			var info: FlxObject = new FlxObject();
			info.velocity.x = velocity.x;
			info.velocity.y = velocity.y;
			info.angle = angle;
			info.angularVelocity = angularVelocity;
			info.x = x;
			info.y = y;
			info.x += Math.sin(angle * (Math.PI / 180));
			info.y += - Math.cos(angle * (Math.PI / 180));
			info.velocity.x += Math.sin(angle * (Math.PI / 180)) * missleStartSpeed;
			info.velocity.y += - Math.cos(angle * (Math.PI / 180)) * missleStartSpeed;
			return info;
		}
		
		override public function kill():void 
		{
			super.kill();
		}
		
	}

}