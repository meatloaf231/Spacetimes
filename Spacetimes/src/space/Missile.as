package space 
{
	/**
	 * ...
	 * @author reGen
	 */
	public class Missile extends Ship
	{
		[Embed(source = "../../Assets/Missile_1.png")] 
		private var ImgMissile:Class;
		private var arming:Number = 60;
		public var armed:Boolean = false;
		
		public function Missile(av: Number, an: Number, x: Number, y: Number, vx: Number, vy: Number):void
		{
			arming = 60;
			armed = false;
			super(x, y, ImgMissile);
			angularVelocity = av;
			angle = an;
			velocity.x = vx;
			velocity.y = vy;
		}
		
		override public function update():void
		{
			if (!armed)
			{
				if (arming > 0)
				{ 
					arming -= 1;
				}
				if (arming == 0)
				{
					armed = true;
				}
			}
				
			super.update();
		}
		
	}

}