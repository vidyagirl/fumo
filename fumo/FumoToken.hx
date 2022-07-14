package fumo;

typedef Pos = Int;

typedef FumoToken =
{
	var type:FumoTokenType;
	var pos:Pos;
	var ?value:Any;
	var lexeme:String;
}

enum FumoTokenType
{
	FEof;

	FBang;
	FAnd;
	FOr;
	FEqual;
	FDoubleEquals;
	FBangEqual;
	FGreater;
	FGreaterEqual;
	FLess;
	FLessEqual;
	FComma;
	FDot;
	FStar;
	FSlash;
	FPlus;
	FMinus;
	FModulo;
	FIncrement;
	FDecrement;
	FPlusEqual;
	FMinusEqual;
	FStarEqual;
	FSlashEqual;
	FModuloEqual;
	FLeftParen; // (
	FRightParen; // )
	FLeftBracket; // [
	FRIghtBracket;
	FInt;
	FFloat;
	FBool;
	FString;
	FAny;
	FVoid;
	FNull;
	FFunction(name:String, returnType:FumoTokenType, ?params:Array<FumoTokenType>);
	FVar(name:String, type:FumoTokenType, value:Dynamic);
	FReturn(type:FumoTokenType);
	FPrint(s:String);
}

class FumoTokenTools
{
	public static inline function getPos(tk:FumoToken):Pos
	{
		return tk.pos;
	}
}
