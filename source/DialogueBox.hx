package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		var gaming:Bool = PlayState.SONG.song.toLowerCase() != 'lo-fight' && PlayState.SONG.song.toLowerCase() != 'b-lo-fight' && PlayState.SONG.song.toLowerCase() != 'overhead' && PlayState.SONG.song.toLowerCase() != 'b-overhead' && PlayState.SONG.song.toLowerCase() != 'b-ballistic' && PlayState.SONG.song.toLowerCase() != 'ballistic';


		if (gaming)
			{
				bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
				bgFade.scrollFactor.set();
				bgFade.alpha = 0;
				add(bgFade);

				new FlxTimer().start(0.83, function(tmr:FlxTimer)
					{
						bgFade.alpha += (1 / 5) * 0.7;
						if (bgFade.alpha > 0.7)
							bgFade.alpha = 0.7;
					}, 5);
			}
			else
				{
					bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), FlxColor.GRAY);
					bgFade.scrollFactor.set();
					bgFade.alpha = 0;
					add(bgFade);
	
					new FlxTimer().start(0.83, function(tmr:FlxTimer)
						{
							bgFade.alpha += (1 / 5) * 0.7;
							if (bgFade.alpha > 0.7)
								bgFade.alpha = 0.7;
						}, 5);
				}

			box = new FlxSprite(-20, 45);

			var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'lo-fight' | 'overhead' | 'ballistic' | 'lo-fight-b-side' | 'overhead-b-side' | 'ballistic-b-side':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.antialiasing = true;
		}

		box.animation.play('normalOpen');
		if (gaming)
			box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		else
			{
				box.y = FlxG.height - 285;
				box.x = 20;
			}
		
		box.updateHitbox();

		this.dialogueList = dialogueList;

		if (!hasDialog)
			return;

		if (gaming)
			{
				portraitLeft = new FlxSprite(-20, 40);
				portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
				portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				portraitLeft.updateHitbox();
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				portraitLeft.visible = false;

				portraitRight = new FlxSprite(0, 40);
				portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
				portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
				portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
				portraitRight.updateHitbox();
				portraitRight.scrollFactor.set();
				add(portraitRight);
				portraitRight.visible = false;
			}
			else
			{
					portraitLeft = new FlxSprite(200, FlxG.height - 525);
					portraitLeft.frames = Paths.getSparrowAtlas('whittyPort', 'bonusWeek');


					switch(PlayState.SONG.song.toLowerCase())
					{
						case 'lo-fight':
							portraitLeft.animation.addByPrefix('enter', 'Whitty Portrait Normal', 24, false);
						case 'lo-fight-b-side':
							portraitLeft.animation.addByPrefix('enter', 'Whitty Portrait Normal', 24, false);
						case 'overhead':
							portraitLeft.animation.addByPrefix('enter', 'Whitty Portrait Agitated', 24, false);
						case 'overhead-b-side':
							portraitLeft.animation.addByPrefix('enter', 'Whitty Portrait Agitated', 24, false);
						case 'ballistic':
							portraitLeft.animation.addByPrefix('enter', 'Whitty Portrait Crazy', 24, true);
						case 'ballistic-b-side':
							portraitLeft.animation.addByPrefix('enter', 'Whitty Portrait Crazy', 24, true);
					}

					portraitLeft.antialiasing = true;
					portraitLeft.updateHitbox();
					portraitLeft.scrollFactor.set();
					add(portraitLeft);
					portraitLeft.visible = false;
	
					portraitRight = new FlxSprite(800, FlxG.height - 489);
					portraitRight.frames = Paths.getSparrowAtlas('boyfriendPort', 'bonusWeek');
					portraitRight.animation.addByPrefix('enter', 'BF portrait enter', 24, true);
					portraitRight.antialiasing = true;
					portraitRight.updateHitbox();
					portraitRight.scrollFactor.set();
					add(portraitRight);
					portraitRight.visible = false;

					portraitRight.setGraphicSize(Std.int(portraitRight.width * 0.8));
					portraitLeft.setGraphicSize(Std.int(portraitLeft.width * 0.8));
			}


			if (PlayState.SONG.song.toLowerCase() != 'lo-fight' && PlayState.SONG.song.toLowerCase() != 'overhead' && PlayState.SONG.song.toLowerCase() != 'ballistic')
			{
				handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
				add(handSelect);
			}

		add(box);
		box.screenCenter(X);
		if (gaming)
			portraitLeft.screenCenter(X);

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'VCR OSD Mono';
		if (gaming)
			dropText.color = 0xFFD89494;
		else
		{
			dropText.color = FlxColor.RED;
			dropText.antialiasing = true;
		}
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'VCR OSD Mono';
		if (gaming)
			swagDialogue.color = 0xFF3F2021;
		else
		{
			swagDialogue.color = FlxColor.BLACK;
			swagDialogue.antialiasing = true;
		}

		if (PlayState.SONG.song.toLowerCase() != 'lo-fight' && PlayState.SONG.song.toLowerCase() != 'b-lo-fight' && PlayState.SONG.song.toLowerCase() != 'overhead' && PlayState.SONG.song.toLowerCase() != 'b-overhead')
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		else if (PlayState.SONG.song.toLowerCase() == 'ballistic' || PlayState.SONG.song.toLowerCase() == 'b-ballistic')
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('ballistic', 'shared'), 0.6)];
		else
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('whitty', 'shared'), 0.6)];

		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);

		this.dialogueList = dialogueList;
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY)
		{
			remove(dialogue);

			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}

		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();

		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
					
					if (PlayState.SONG.song.toLowerCase() == 'ballistic')
						swagDialogue.sounds =  [FlxG.sound.load(Paths.sound('ballistic', 'shared'), 0.6)];
					else if (PlayState.SONG.song.toLowerCase() == 'lo-fight' || PlayState.SONG.song.toLowerCase() == 'overhead')
						swagDialogue.sounds =  [FlxG.sound.load(Paths.sound('whitty', 'shared'), 0.6)];
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					trace('bf pog!!!');
					portraitRight.animation.play('enter');
					swagDialogue.sounds =  [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}