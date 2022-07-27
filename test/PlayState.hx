package;

import flixel.FlxState;
import fumo.FumoParser;

class PlayState extends FlxState
{
	var fumoParser:FumoParser;

	override public function create()
	{
		fumoParser = new FumoParser();
		// fumoParser.parse("+ - += %= **= **, ==");
		fumoParser.parse('123
		 123.4');
		trace(fumoParser.out);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
