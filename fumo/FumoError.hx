package fumo;

using StringTools;

class FumoError
{
	public static inline var UNTERMINATED_STRING = "FumoError: Unterminated String at line $LINE, position $POS";

	public static function error(error:String, ?line:Int, ?pos:Int)
	{
		trace(error.replace("$LINE", Std.string(line)).replace("$POS", Std.string(pos)));
	}
}
