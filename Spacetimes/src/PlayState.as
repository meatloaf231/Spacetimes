package  
{
	/**
	 * ...
	 * @author reGen
	 */
	
	 import flash.media.Microphone;
	 import org.flixel.*;
	 import space.*;
	 
	public class PlayState extends FlxState
	{
		[Embed(source = "../Assets/Smoke.png")]
		private var ImgSmoke:Class;
	
		[Embed(source = "../Assets/ShipExplosion.mp3")]
		private var SoundShipExplosion:Class;
		
		
		private var _redScoreText: FlxText;
		private var _blueScoreText: FlxText;
		public var _redship: RedShip;
		public var _blueship: BlueShip;
		private var _planet: Planet;
		private var _missiles: FlxGroup;
		private var _ships: FlxGroup;
		
		override public function create():void
		{
			FlxG.score = 0;
			//FlxG.bgColor = 0xFFABCC7D;
			
			_redship = new RedShip();
			_blueship = new BlueShip();
			//add(_redship);
			//add(_blueship);
			
			_ships = new FlxGroup();
			_ships.add(_redship);
			_ships.add(_blueship);
			add(_ships);
			
			_planet = new Planet();
			add(_planet);
			
			_missiles = new FlxGroup();
			add(_missiles);
			
			_blueScoreText = new FlxText(10, 8, 200, "0");
			_blueScoreText.setFormat(null, 32, 0xAAAAFF, "left");
			_blueScoreText.scrollFactor.x = _blueScoreText.scrollFactor.y = 0;
			add(_blueScoreText);
			
			_redScoreText = new FlxText(590, 8, 200, "0");
			_redScoreText.setFormat(null, 32, 0xFFAAAA, "right");
			_redScoreText.scrollFactor.x = _redScoreText.scrollFactor.y = 0;
			add(_redScoreText);
			
			super.create();
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("SPACE") && _redship.alive == true && !_redship.reloadMissle)
			{
				fireMissile(_redship.getRedMissileLaunchInformation());
			}
			
			if (FlxG.keys.justPressed("SHIFT") && _blueship.alive == true && !_blueship.reloadMissle)
			{
				fireMissile(_blueship.getBlueMissileLaunchInformation());
			}
			
			if (FlxG.keys.justPressed("R"))
			{
				newGame();
			}
			
			_blueScoreText.text = _blueship.score.toString();
			_redScoreText.text = _redship.score.toString();
			
			/*collisions*/
			FlxG.overlap(_redship, _blueship, shipsCollide);
			FlxG.overlap(_ships, _planet, collidesPlanet);
			FlxG.overlap(_missiles, _planet, collidesPlanet);
			FlxG.overlap(_ships, _missiles, missleCollidesShip);
			FlxG.overlap(_missiles, _missiles, misslesCollide);
			/*end collisions*/
			
			super.update();
		}
		
		private function fireMissile(info:FlxObject):void
		{
			var addedMissile: Missile = new Missile(info.angularVelocity, info.angle, info.x, info.y, info.velocity.x, info.velocity.y);
			_missiles.add(addedMissile);
		}
		
		private function shipsCollide(red:RedShip, blue:BlueShip):void
		{
			red.kill();
			blue.kill();
			FlxG.shake(0.0075, 0.35, null, true);
			//FlxG.state = new PlayState();
		}
		
		private function collidesPlanet(ship:Ship, leopardArePrettyCool:Planet):void
		{
			if (ship.who == "redShip")
			{
				_blueship.score += 1;
			}
			else
			{
				_redship.score += 1;
			}
			var expl:FlxEmitter = createExplosion();
			expl.at(ship);
			expl.start();
			ship.kill();
			FlxG.shake(0.0045, 0.2, null, true);
		}
		
		private function missleCollidesShip(ship:Ship, missle:Missile):void
		{
			if (missle.armed)
			{
				if (ship.who == "redShip")
				{
					_blueship.score += 1;
				}
				else
				{
					_redship.score += 1;
				}
				ship.kill();
				missle.kill();
				FlxG.shake(0.0065, 0.25, null, true);
			}
			//FlxG.state = new PlayState();
		}
		
		private function misslesCollide(foo:Missile, bar:Missile):void
		{
			foo.kill();
			bar.kill();
			FlxG.shake(0.0035, 0.15, null, true);
		}
		
		public function createJets():FlxEmitter
		{
			var jet:FlxEmitter = new FlxEmitter();
			jet.gravity = 0;
			jet.maxRotation = 0;
			jet.setXSpeed( -500, 500);
			jet.setYSpeed( -500, 500);
			var numParticles: int = 10;
			for (var i: int = 0; i < numParticles; i++)
			{
				var particle: FlxSprite = new FlxSprite();
				particle.makeGraphic(2, 2, 0xFF597137);
				particle.exists = false;
				jet.add(particle);
			}
			jet.start(false, 40, 0.05, 0);
			return jet;
		}
		
		public function createExplosion():FlxEmitter
		{
			var explosion:FlxEmitter = new FlxEmitter();
			explosion.gravity = 0;
			explosion.maxRotation = 0;
			explosion.setXSpeed( -50, 50);
			explosion.setYSpeed( -50, 50);
			explosion.lifespan = 1;
			explosion.makeParticles(ImgSmoke, 15, 16, false, 0.8);
			explosion.start(true, 1, 1, 0);
			add(explosion);
			return explosion;
		}
		
		public function newGame():void
		{
			_missiles.kill();
			_missiles.revive();
			
			//reset redship
			if (!_redship.alive) _redship.revive();
			_redship.velocity.y = _redship.startingVelocity * ( -1);
			_redship.velocity.x = 0
			_redship.x = (FlxG.width * 7) / 8;
			_redship.y = FlxG.height / 2;
			
			//reset blueship
			if (!_blueship.alive) _blueship.revive();
			_blueship.velocity.y = _blueship.startingVelocity;
			_blueship.velocity.x = 0
			_blueship.x = FlxG.width / 8;
			_blueship.y = FlxG.height / 2;
			
		}
		
	}

}