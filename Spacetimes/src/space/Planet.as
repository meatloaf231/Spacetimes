package space 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author reGen
	 */
	public class Planet extends FlxSprite
	{
		[Embed(source = "../../Assets/Planet_leopard.png")] 
		private var ImgPlanet:Class;
		
		public function Planet():void
		{
			super(((FlxG.width / 2) - 60), ((FlxG.height / 2) - 60), ImgPlanet);
		}
		
		override public function update():void
		{
			
		}
		
	}

}