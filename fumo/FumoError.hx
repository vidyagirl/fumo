package fumo;

// Would use hx-color-trace, but I'm trying to make this library as "vanilla" as possible
class FumoErrorTools
{
	inline public static var RED = "\033[0;31m";
	inline public static var GREEN = "\033[0;32m";
	inline public static var YELLOW = "\033[0;33m";
	inline public static var BLUE = "\033[0;34m";
	inline public static var MAGENTA = "\033[0;35m";
	inline public static var CYAN = "\033[0;36m";
	inline public static var NC = "\033[0m"; // No Color

	public static function error(text:String, line:Int)
	{
		trace(RED + "Error: " + text + " (line " + line + ")" + NC);
	}

	public static function warn(text:String, line:Int)
	{
		trace(YELLOW + "Warning: " + text + " (line " + line + ")" + NC);
	}
}
