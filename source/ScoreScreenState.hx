package;

import Controls.KeyboardScheme;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
#if sys
import sys.io.File;
#end

///
/// Currently isn't done, and probably wont be for awhile since the sprites for the sicks and other ratings are big as fuck.
/// too lazy to get this done kek.
///


class ScoreScreenState extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;
	var versionShit:FlxText;

    var score:Int;
    var scoreTxt:FlxText;
	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        controlsStrings = CoolUtil.coolStringFile("Watch Replay\nBack to Menu");
		trace(controlsStrings);

		menuBG.color = FlxColor.GRAY;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...controlsStrings.length)
		{
				var controlLabel:Alphabet = new Alphabet(FlxG.width / 2 - 30, FlxG.height - 50 + (70 * i) + 30, controlsStrings[i], true, false);
				controlLabel.isMenuItem = true;
				controlLabel.targetY = i;
				grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}
    

        if (PlayState.isStoryMode)
            score = PlayState.campaignScore;
        else
            score = Highscore.getScore(PlayState.SONG.song, PlayState.storyDifficulty);

        // I am so sorry for this :(

        var ratingShits:FlxSprite = new FlxSprite();
        var ratingSTxt:FlxText = new FlxText();
        ratingShits.setGraphicSize(Std.int(ratingShits.width - 400));
        ratingShits.loadGraphic(Paths.image('shit'));
        var ratingBads:FlxSprite = new FlxSprite();
        ratingBads.setGraphicSize(Std.int(ratingBads.width - 400));
        var ratingBTxt:FlxText = new FlxText();
        ratingBads.loadGraphic(Paths.image('bad'));
        var ratingGoods:FlxSprite = new FlxSprite();
        ratingGoods.setGraphicSize(Std.int(ratingGoods.width - 400));
        var ratingGTxt:FlxText = new FlxText();
        ratingGoods.loadGraphic(Paths.image('good'));
        var ratingSicks:FlxSprite = new FlxSprite();
        var ratingSITxt:FlxText = new FlxText();
        ratingSicks.setGraphicSize(Std.int(ratingSicks.width - 400));
        ratingSicks.loadGraphic(Paths.image('sick'));
        var ratingMiss:FlxSprite = new FlxSprite();
        var ratingMTxt:FlxText = new FlxText();
        ratingMiss.setGraphicSize(Std.int(ratingMiss.width - 400));
        ratingMiss.loadGraphic(Paths.image('miss'));

        ratingShits.x = 50;
        ratingSTxt.x = ratingShits.width + 45;
        ratingShits.y = (FlxG.height / 2) * 0.1;
        ratingSTxt.y = (FlxG.height / 2) * 0.1;
        ratingSTxt.setFormat("VCR OSD Mono", 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        ratingSTxt.text = PlayState.shits + "";

        ratingBads.x = 50;
        ratingBTxt.x = ratingBads.width + 45;
        ratingBads.y = (FlxG.height / 2) * 0.3;
        ratingBTxt.y = (FlxG.height / 2) * 0.3;
        ratingBTxt.setFormat("VCR OSD Mono", 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        ratingBTxt.text = PlayState.bads + "";        

        ratingGoods.x = 50;
        ratingGTxt.x = ratingGoods.width + 45;
        ratingGoods.y = (FlxG.height / 2) * 0.5;
        ratingGTxt.y = (FlxG.height / 2) * 0.5;
        ratingGTxt.setFormat("VCR OSD Mono", 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        ratingGTxt.text = PlayState.goods + "";        

        ratingSicks.x = 50;
        ratingSITxt.x = ratingSicks.width + 45;
        ratingSicks.y = (FlxG.height / 2) * 0.7;
        ratingSITxt.y = (FlxG.height / 2) * 0.7;
        ratingSITxt.setFormat("VCR OSD Mono", 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        ratingSITxt.text = PlayState.sicks + "";     

        ratingMiss.x = 50;
        ratingMTxt.x = ratingMiss.width + 45;
        ratingMiss.y = (FlxG.height / 2) * 0.9;
        ratingMTxt.y = (FlxG.height / 2) * 0.9;
        ratingMTxt.setFormat("VCR OSD Mono", 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        ratingMTxt.text = PlayState.misses + "";     

        var scoreTxt:FlxText = new FlxText(50,(FlxG.height / 2) * 1.5, 0, "Score: 0");
        scoreTxt.scrollFactor.set();
		scoreTxt.setFormat("VCR OSD Mono", 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		versionShit = new FlxText(5, FlxG.height - 34, 0, "Kade Engine " + MainMenuState.kadeEngineVer, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
        add(ratingSicks);
        add(ratingShits);
        add(ratingGoods);
        add(ratingBads);
        add(ratingSITxt);
        add(ratingSTxt);
        add(ratingGTxt);
        add(ratingBTxt);
        add(scoreTxt);

		super.create();
	}

    var lerpScore:Int = 0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);
            if (scoreTxt != null)
            {
                scoreTxt.text = "Score: " + Math.floor(FlxMath.lerp(lerpScore, score, 0.4));

                if (Math.abs(lerpScore - score) <= 10)
                    lerpScore = score;
            }
			if (controls.BACK)
				FlxG.switchState(new OptionsMenu());
			if (controls.UP_P)
				changeSelection(-1);
			if (controls.DOWN_P)
				changeSelection(1);
		

			if (controls.ACCEPT)
			{
                switch(curSelected)
                {
                    case 0:
                        PlayState.loadRep = true;
                        LoadingState.loadAndSwitchState(new PlayState());
                    case 1:
                        if (PlayState.isStoryMode)
                            LoadingState.loadAndSwitchState(new StoryMenuState());
                        else
                            LoadingState.loadAndSwitchState(new FreeplayState());
                }
			}
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end
		
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
