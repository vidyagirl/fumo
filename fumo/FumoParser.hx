package fumo;

import fumo.FumoError.FumoErrorTools;
import fumo.FumoToken.FumoTokenType;
import fumo.FumoToken.Pos;

class FumoParser
{
	public static var script:String;
	public static var pos:Pos;
	public static var start:Pos;
	public static var len:Int;
	public static var out:Array<FumoToken> = [];
	public static var line:Int = 1;

	public static function parse(s:String):Array<FumoToken>
	{
		script = s;

		var currentLineIsComment = false;

		if (out.length > 0 || out == null)
			out = [];

		pos = 0;
		len = s.length;
		line = 0;

		while (pos < len)
		{
			start = pos;
			var c = s.charCodeAt(pos++);

			var d:Pos = start;
			switch (c)
			{
				case " ".code, "\t".code, "\n".code, "\r".code:
					if (c == "\n".code)
						line++;
				case '('.code:
					addToken(d, FLeftParen, null, "(");
				case ')'.code:
					addToken(d, FRightParen, null, ")");
				case '+'.code:
					addToken(d, match('=') ? FPlusEqual : FPlus, null, "+" + (match('=') ? "=" : ""));
				case '-'.code:
					addToken(d, match('=') ? FMinusEqual : FMinus, null, "-" + (match('=') ? "=" : ""));
				case '*'.code:
					addToken(d, match('=') ? FStarEqual : FStar, null, "*" + (match('=') ? "=" : ""));
				case '/'.code:
					if (match('/'))
					{
						while (pos < len && s.charCodeAt(pos) != "\n".code)
						{
							pos++;
						}
					}
					else
						addToken(d, match('=') ? FSlashEqual : FSlash, null, "/" + (match('=') ? "=" : ""));
				case '%'.code:
					addToken(d, match('=') ? FModuloEqual : FModulo, null, "%" + (match('=') ? "=" : ""));
				case "v".code:
					if (matchWord("ar"))
					{
						var name:String;
						var type:FumoTokenType = FAny;
						var value:Dynamic = null;
						trace('var');
						// addToken(d, FVar, null, "var")
					};
				case "f".code:
					if (matchWord("unction"))
					{
						var name:String;
						var returnType:FumoTokenType = FVoid;
						trace('func');
						// addToken(d, FFunction, null, "function")
					}
				// Credit to LeotomasMC for this code (https://github.com/LeotomasMC/chroma-fighters-scripting/)
				case '"'.code | "'".code:
					while (pos < len)
					{
						if (s.charCodeAt(pos) == "\n".code)
							line++;
						if (s.charCodeAt(pos) == c)
							break;
						pos++;
					}

					if (pos > len)
					{
						FumoErrorTools.error("Unterminated string", line);
					}
					else
					{
						var str = s.substring(start + 1, pos++);
						addToken(d, FString, str, "\"" + str + "\"");
					}
				default:
			}
		}

		return out;
	}

	private static function seek(increment:Int = 1)
	{
		if (start + increment > len)
			return -1;
		return script.charCodeAt(start + increment);
	}

	private static function match(expected:String, ?increment:Int = 1)
	{
		if (start + increment > len)
			return false;
		if (script.charCodeAt(start + increment) != expected.charCodeAt(0))
			return false;

		pos += increment;
		return true;
	}

	private static function matchWord(word:String, increment:Int = 1)
	{
		for (i in 0...word.length)
			if (script.charCodeAt(start + increment + i) != word.charCodeAt(i))
				return false;
		return true;
	}

	private static function isDigit(pos:Int)
	{
		for (code in [
			"0".code, "1".code, "2".code, "3".code, "4".code, "5".code, "6".code, "7".code, "8".code, "9".code
		])
		{
			if (script.charCodeAt(pos) == code)
				return true;
		}
		return false;
	}

	private static inline function addToken(pos:Int, type:FumoTokenType, ?value:Any, lexeme:String)
	{
		out.push({
			pos: pos,
			type: type,
			value: value,
			lexeme: lexeme
		});
	}
}
