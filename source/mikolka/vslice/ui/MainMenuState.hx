package mikolka.vslice.ui;

import mikolka.compatibility.ui.MainMenuHooks;
import mikolka.compatibility.VsliceOptions;
#if !LEGACY_PSYCH
import states.TitleState;
#if MODS_ALLOWED
import states.ModsMenuState;
#end
import states.AchievementsMenuState;
import states.CreditsState;
import states.editors.MasterEditorMenu;
#else
import editors.MasterEditorMenu;
#end
import mikolka.compatibility.ModsHelper;
import mikolka.vslice.freeplay.FreeplayState;
import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import options.OptionsState;
import tjson.TJSON as Json;

#if HSCRIPT_ALLOWED
import mikolka.vslice.components.crash.UserErrorSubstate;
import psychlua.HScript;
import crowplexus.iris.Iris;
import crowplexus.hscript.Expr.Error as IrisError;
import crowplexus.hscript.Printer;
#end

typedef MenuFile = {
	var xArray:Array<Int>;
	var yArray:Array<Int>;
	var backgroundSprite:String;
	var selectedSprite:String;
	var selectedColor:String;
	var version:String;
	var allowArtworks:Bool;
	var artWorkScale:Float;
	var artworkX:Int;
	var artWorkY:Int;
}

class MainMenuState extends MusicBeatState
{
	#if !LEGACY_PSYCH
	public static var psychEngineVersion:String = '1.0.4'; // This is also used for Discord RPC
	#else
	public static var psychEngineVersion:String = '0.6.3'; // This is also used for Discord RPC
	#end
	public static var pSliceVersion:String = '3.1.1'; 
	public static var funkinVersion:String = '0.6.3'; // Version of funkin' we are emulationg
	public static var curSelected:Int = 0;

	public var portraitAlphaTween:FlxTween;

	public var menuItems:FlxTypedGroup<FlxSprite>;

	public var menuJson:MenuFile;

	public var optionShit:Array<String> = [];

	public var artworkArray:Array<String> = [];

	public var artwork:FlxSprite;

	public var yScroll:Float;

	#if HSCRIPT_ALLOWED
	public var hscript:HScript;
	public var gotError:Bool;
	#end

	public var magenta:FlxSprite;
	public var camFollow:FlxObject;
	public function new(isDisplayingRank:Bool = false) {
		//TODO
		super();
	}
	override function create()
	{
		hscript = new HScript(null, Paths.getPath("menu/MainMenu/MainMenu.hxml"));
		menuJson = Json.parse(Paths.getTextFromFile('menu/MainMenu/MainMenu.json'));
		optionShit = CoolUtil.coolTextFile(Paths.getPath('menu/MainMenu/optionShit.menu'));
		artworkArray = CoolUtil.coolTextFile(Paths.getPath('menu/MainMenu/optionArtworks.menu'));
		Paths.clearUnusedMemory();
		ModsHelper.clearStoredWithoutStickers();
		
		ModsHelper.resetActiveMods();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end


		persistentUpdate = persistentDraw = true;

		if(hscript.exists('onCreate'))
			hscript.call('onCreate');

		hscript.set('curSelected', curSelected);

		hscript.set('selectedSomethin', selectedSomethin);

		hscript.set('FlxFlicker', FlxFlicker);

		hscript.set('menu', this);

		hscript.set('psychEngineVersion', psychEngineVersion);
		hscript.set('pSliceVersion', pSliceVersion);
		hscript.set('funkinVersion', funkinVersion);

		yScroll = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image(menuJson.backgroundSprite));
		bg.antialiasing = VsliceOptions.ANTIALIASING;
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image(menuJson.selectedSprite));
		magenta.antialiasing = VsliceOptions.ANTIALIASING;
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		//magenta.color = 0xFFfd719b;
		magenta.color = CoolUtil.colorFromString(menuJson.selectedColor);
		add(magenta);

		artwork = new FlxSprite().loadGraphic(Paths.image('menu_artworks/template'));
		artwork.antialiasing = ClientPrefs.data.antialiasing;
		artwork.scrollFactor.set(0, yScroll);
		artwork.updateHitbox();
		artwork.screenCenter();
		artwork.x = menuJson.artworkX;
		artwork.y = menuJson.artWorkY;
		artwork.scale.x = menuJson.artWorkScale;
		artwork.scale.y = menuJson.artWorkScale;
		add(artwork);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(menuJson.xArray[i], menuJson.yArray[i]);
			menuItem.antialiasing = VsliceOptions.ANTIALIASING;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.updateHitbox();
			//menuItem.screenCenter(X);
		}

		var epicVer:FlxText = new FlxText(0, FlxG.height - 36, FlxG.width, "Sketchbook Version " + menuJson.version, 12);
		var psychVer:FlxText = new FlxText(0, FlxG.height - 18, FlxG.width, "Psych Engine " + psychEngineVersion, 12);
		var fnfVer:FlxText = new FlxText(0, FlxG.height - 18, FlxG.width, 'v${funkinVersion} (P-slice ${pSliceVersion})', 12);

		epicVer.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		psychVer.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		fnfVer.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		
		epicVer.scrollFactor.set();
		psychVer.scrollFactor.set();
		fnfVer.scrollFactor.set();
		add(epicVer);
		add(psychVer);
		add(fnfVer);
		//var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' ", 12);
	
		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		// Unlocks "Freaky on a Friday Night" achievement if it's a Friday and between 18:00 PM and 23:59 PM
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) MainMenuHooks.unlockFriday();
			

		#if MODS_ALLOWED
		MainMenuHooks.reloadAchievements();
		#end
		#end

		#if TOUCH_CONTROLS_ALLOWED
		addTouchPad('LEFT_FULL', 'A_B_E');
		#end

		if(hscript.exists('onCreatePost'))
			hscript.call('onCreatePost');

		super.create();

		//FlxG.camera.follow(camFollow, null, 0.06);
	}

	override public function beatHit():Void
	{
		super.beatHit();
		if(hscript.exists('onBeatHit'))
			hscript.call('onBeatHit');
		hscript.set('curBeat', curBeat);
	}

	override public function stepHit():Void
	{
		super.stepHit();
		if(hscript.exists('onStepHit'))
			hscript.call('onStepHit');
		hscript.set('curStep', curStep);
	}

	public var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			//if (FreeplayState.vocals != null)
				//FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if(hscript.exists('onUpdate'))
			hscript.call('onUpdate');

		hscript.set('elapsed', elapsed);

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
				changeItem(-1);

			if (controls.UI_DOWN_P)
				changeItem(1);

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if(hscript.exists('onSelectedPre'))
					hscript.call('onSelectedPre');
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxTransitionableState.skipNextTransIn = false;
				FlxTransitionableState.skipNextTransOut = false;
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://needlejuicerecords.com/pages/friday-night-funkin');
				}
				else
				{
					selectedSomethin = true;

					if (VsliceOptions.FLASHBANG)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					FlxFlicker.flicker(menuItems.members[curSelected], 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						if(hscript.exists('onSelected'))
							hscript.call('onSelected');
						switch (optionShit[curSelected])
						{
							case 'story_mode':
								MusicBeatState.switchState(new StoryMenuState());
							case 'bios':
								MusicBeatState.switchState(new states.BiosMenuState());
							case 'freeplay':{
								persistentDraw = true;
								persistentUpdate = false;
								// Freeplay has its own custom transition
								FlxTransitionableState.skipNextTransIn = true;
								FlxTransitionableState.skipNextTransOut = true;

								openSubState(new FreeplayState());
								subStateOpened.addOnce(state -> {
									for (i in 0...menuItems.members.length) {
										menuItems.members[i].revive();
										menuItems.members[i].alpha = 1;
										menuItems.members[i].visible = true;
										selectedSomethin = false;
									}
									changeItem(0);
								});
								
							}

							#if MODS_ALLOWED
							case 'mods':
								MusicBeatState.switchState(new ModsMenuState());
							#end

							#if ACHIEVEMENTS_ALLOWED
							case 'awards':
								MusicBeatState.switchState(new AchievementsMenuState());
							#end

							case 'credits':
								MusicBeatState.switchState(new CreditsState());
							case 'options':
								MusicBeatState.switchState(new OptionsState());
								#if !LEGACY_PSYCH OptionsState.onPlayState = false; #end
								if (PlayState.SONG != null)
								{
									PlayState.SONG.arrowSkin = null;
									PlayState.SONG.splashSkin = null;
									#if !LEGACY_PSYCH PlayState.stageUI = 'normal'; #end
								}
							default:
								if(hscript.exists('onEnter'))
									hscript.call('onEnter');
						}
					});

					for (i in 0...menuItems.members.length)
					{
						if (i == curSelected)
							continue;
						FlxTween.tween(menuItems.members[i], {alpha: 0}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								menuItems.members[i].kill();
							}
						});
					}
					if(hscript.exists('onSelectedPost'))
						hscript.call('onSelectedPost');
				}
			}
			if (#if TOUCH_CONTROLS_ALLOWED touchPad.buttonE.justPressed || #end 
				#if LEGACY_PSYCH FlxG.keys.anyJustPressed(ClientPrefs.keyBinds.get('debug_1').filter(s -> s != -1)) 
				#else controls.justPressed('debug_1') #end)
			{
				selectedSomethin = true;
				FlxTransitionableState.skipNextTransIn = false;
				FlxTransitionableState.skipNextTransOut = false;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
		}

		if(hscript.exists('onUpdatePost'))
			hscript.call('onUpdatePost');

		super.update(elapsed);
	}

	function changeArtwork(selected:Int){
		if(hscript.exists('onChangeArtwork'))
			hscript.call('onChangeArtwork');
		remove(artwork);
		artwork = new FlxSprite(-80).loadGraphic(Paths.image('menu_artworks/' + artworkArray[selected]));
		artwork.antialiasing = ClientPrefs.data.antialiasing;
		artwork.scrollFactor.set(0, yScroll);
		artwork.updateHitbox();
		artwork.screenCenter();
		artwork.alpha = 0;
		artwork.x = menuJson.artworkX;
		artwork.y = menuJson.artWorkY;
		artwork.scale.x = menuJson.artWorkScale;
		artwork.scale.y = menuJson.artWorkScale;
		artwork.visible = menuJson.allowArtworks;
		add(artwork);
		portraitAlphaTween = FlxTween.tween(artwork, {alpha: 1}, 0.3, {ease: FlxEase.expoOut});
		if(hscript.exists('onChangeArtworkPost'))
			hscript.call('onChangeArtworkPost');
	}

	function changeItem(huh:Int = 0)
	{
		if(hscript.exists('onChangeItem'))
			hscript.call('onChangeItem');

		hscript.set('huh', huh);
		
		FlxG.sound.play(Paths.sound('scrollMenu'));
		menuItems.members[curSelected].animation.play('idle');
		menuItems.members[curSelected].updateHitbox();

		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		changeArtwork(curSelected);

		menuItems.members[curSelected].animation.play('selected');
		menuItems.members[curSelected].centerOffsets();

		/*camFollow.setPosition(menuItems.members[curSelected].getGraphicMidpoint().x,
			menuItems.members[curSelected].getGraphicMidpoint().y - (menuItems.length > 4 ? menuItems.length * 8 : 0));*/

		if(hscript.exists('onChangeItemPost'))
			hscript.call('onChangeItemPost');
	}
}
