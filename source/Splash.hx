package;

import flixel.FlxState;
import flixel.util.FlxTimer;
import sys.FileSystem;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

using StringTools;

@:access(flixel.FlxGame)
@:access(Main)
class Splash extends FlxState
{
	// var video:FunkinVideo;
	var _cachedAutoPause:Bool;

	var spriteEvents:FlxTimer;
	var logo:FlxSprite;

	override function create()
	{

		FlxG.mouse.visible = false;
		var event = new FlxTimer().start(1, (t0:FlxTimer) -> {
			var folder = [];
			folder = FileSystem.readDirectory(Paths.getPath('images/branding'));
			var img = folder[FlxG.random.int(0, folder.length - 1)];
			trace(folder);

			logo = new FlxSprite().loadGraphic(Paths.image('branding/${img.replace('.png', '')}'));
			logo.screenCenter();
			logo.visible = false;
			add(logo);

			spriteEvents = new FlxTimer().start(1, (t0:FlxTimer) -> {
				new FlxTimer().start(0.25, (t1:FlxTimer) -> {
					logo.visible = true;
					logo.scale.set(0.2, 1.25);
					new FlxTimer().start(0.06125, (t2:FlxTimer) -> {
						logo.scale.set(1.25, 0.5);
						new FlxTimer().start(0.06125, (t3:FlxTimer) -> {
							logo.scale.set(1.125, 1.125);
							FlxTween.tween(logo.scale, {x: 1, y: 1}, 0.25,
								{
									ease: FlxEase.elasticOut,
									onComplete: (t:FlxTween) -> {
										new FlxTimer().start(1, (t5:FlxTimer) -> {
											FlxTween.tween(logo.scale, {x: 0.2, y: 0.2}, 1, {ease: FlxEase.quadIn});
											FlxTween.tween(logo, {alpha: 0}, 1,
												{
													ease: FlxEase.quadIn,
													onComplete: (t:FlxTween) -> {
														finish();
													}
												});
										});
									}
								});
						});
					});
				});
			});
		});
	}

	override function update(elapsed:Float)
	{
		if (logo != null)
		{
			logo.updateHitbox();
			logo.screenCenter();

			if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER)
			{
				finish();
			}
		}

		super.update(elapsed);
	}

	function finish()
	{
		if (spriteEvents != null)
		{
			spriteEvents.cancel();
			spriteEvents.destroy();
		}
		complete();
	}

	function complete()
	{
		FlxG.switchState(new Init());
	}
}
