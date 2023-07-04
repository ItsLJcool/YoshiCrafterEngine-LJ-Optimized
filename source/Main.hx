package;

import backend.Conductor;
import flixel.FlxGame;
import openfl.display.FPS;

using StringTools;

class Main extends Sprite {
	public static var version:String = 'Version: 1.0.0 '; // ${Application.current.meta.get('version')}
	public static var debugInfo:String = #if alpha "Alpha" #elseif beta "Beta" #elseif official "" #else "Custom (Source Modded)" #end;
	public static var engineVersion:String = version + debugInfo;

	public function new() {
		super();

		// temporary
		var controls = sys.io.File.getContent(Paths.getPath('data/tempData.txt')).split("\n");
		for (i in 0...8)
			game.Receptor.keybindList[i % 4].push(FlxKey.fromString(controls[i].trim()));
		game.PlayState.SONG = game.Song.SongParser.parseSongJson("hard", controls[8].trim().toLowerCase());

		addChild(new FlxGame(0, 0, menus.TitleState, 500, 500, true));
		addChild(new FPS(10, 10, 0xFFFFFF));
		addChild(new debug.Overlay());
		FlxG.fixedTimestep = false;

		FlxG.signals.preUpdate.add(Conductor.update);
	}
}
