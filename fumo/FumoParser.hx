package fumo;

import fumo.FumoToken;

using StringTools;

class FumoParser
{
	public var script:String;
	public var pos:Pos;
	public var start:Pos;
	public var len:Int;
	public var out:Array<FumoToken> = [];
	public var line:Int = 1;

	public function new() {}

	public function parse(s:String)
	{
		script = s;

		var currentLineIsComment = false;

		if (out == null || out.length > 0)
		{
			out = [];
		}

		pos = 0;
		len = s.length;
		line = 1;

		while (pos < len)
		{
			start = pos;

			var c = s.charCodeAt(pos++);
			var d:Pos = start;

			switch (c)
			{
				case " ".code, "\t".code, "\n".code, "\r".code:
					if (c == "\n".code)
					{
						line++;
						trace("nl: " + line);
					}
				case '('.code:
					addToken(d, FLeftParen, '(');
				case ')'.code:
					addToken(d, FRightParen, ')');
				case '{'.code:
					addToken(d, FLeftBrace, '{');
				case '}'.code:
					addToken(d, FRightBrace, '}');
				case '['.code:
					addToken(d, FLeftBracket, '[');
				case ']'.code:
					addToken(d, FRightBracket, ']');
				case '+'.code:
					if (match('='))
					{
						addToken(d, FPlusEqual, "+=");
					}
					else
					{
						addToken(d, FPlus, "+");
					}
				case '-'.code:
					if (match('='))
					{
						addToken(d, FMinusEqual, "-=");
					}
					else
					{
						addToken(d, FMinus, "-");
					}
				case '/'.code:
					if (match('='))
					{
						addToken(d, FSlashEqual, "/=");
					}
					else if (match('/'))
					{
						while (pos < len && s.charCodeAt(pos) != "\n".code)
						{
							pos++;
						}
					}
					else
					{
						addToken(d, FSlash, "/");
					}
				case '*'.code:
					if (match('*'))
					{
						if (match("=", 2))
							addToken(d, FStarStarEqual, "**=");
						else
							addToken(d, FStarStar, "**");
					}
					else if (match('='))
					{
						addToken(d, FStarEqual, "*=");
					}
					else
					{
						addToken(d, FStar, "*");
					}
				case '%'.code:
					if (match('='))
					{
						addToken(d, FModuloEqual, "%=");
					}
					else
					{
						addToken(d, FModulo, "%");
					}
				case '='.code:
					if (match('='))
					{
						addToken(d, FEqualEqual, "==");
					}
					else
					{
						addToken(d, FEqual, "=");
					}
				case '!'.code:
					if (match('='))
					{
						addToken(d, FBangEqual, "!=");
					}
					else
					{
						addToken(d, FBangEqual, "!");
					}
				case '>'.code:
					if (match('='))
					{
						addToken(d, FGreaterEqual, ">=");
					}
					else
					{
						addToken(d, FGreater, ">");
					}
				case '<'.code:
					if (match('='))
					{
						addToken(d, FLessEqual, "<=");
					}
					else
					{
						addToken(d, FLess, "<");
					}
				// Credit to LeotomasMC for this code (https://github.com/LeotomasMC/chroma-fighters-scripting/)
				case '"'.code | "'".code:
					while (pos < script.length)
					{
						if (script.charCodeAt(pos) == '\n'.code)
							line++;
						if (script.charCodeAt(pos) == c)
							break;
						pos++;
					}
					if (pos < script.length)
					{
						var value = script.substring(start + 1, pos++);
						addToken(d, FString, '"' + value + '"', value);
					}
					else
						FumoError.error(FumoError.UNTERMINATED_STRING, line, start);
				default:
					if (c >= '0'.code && c <= '9'.code || c == '.'.code)
					{
						var dot = c == '.'.code;
						while (pos < len)
						{
							var c = s.charCodeAt(pos);
							if (c >= '0'.code && c <= '9'.code || c == '.'.code)
							{
								if (c == '.'.code)
									dot = true;

								pos++;
							}
							else
								break;
						}

						if (dot)
						{
							addToken(d, FFloat, script.substring(start, pos).replace('\n', ''),
								Std.parseFloat(script.substring(start, pos).replace('\n', '')));
						}
						else
						{
							addToken(d, FInt, script.substring(start, pos), Std.parseInt(script.substring(start, pos).replace('\n', '')));
						}
					}
			}
		}
	}

	public function addToken(pos:Int, type:FumoTokenType, lexeme:String, ?value:Any)
	{
		out.push({
			pos: pos,
			type: type,
			lexeme: lexeme,
			value: value
		});
	}

	private function match(expected:String, increment:Int = 1)
	{
		if (start + increment > len)
			return false;
		if (script.charCodeAt(start + increment) != expected.charCodeAt(0))
			return false;

		pos += increment;
		return true;
	}

	private function peek(increment:Int = 1)
	{
		if (script == null)
			return null;
		return script.charCodeAt(start + increment);
	}
}
