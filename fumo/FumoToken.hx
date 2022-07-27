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
	// Bracket stuff
	FLeftParen;
	FRightParen;
	FLeftBrace;
	FRightBrace;
	FLeftBracket;
	FRightBracket;

	// Operators
	FPlus;
	FPlusEqual;
	FMinus;
	FMinusEqual;
	FStar;
	FStarEqual;
	FStarStar;
	FStarStarEqual;
	FSlash;
	FSlashEqual;
	FModulo;
	FModuloEqual;
	FDot;
	FComma;
	// Types
	FInt;
	FFloat;
	FString;
	FBool;
	FAny;
	FNull;
	FVoid;
	// Statements
	FIf;
	FElse;
	FFor;
	FWhile;
	FOr;
	FAnd;
	FBreak;
	FContinue;
	// Statement Check Things
	FBang;
	FBangEqual;
	FEqual;
	FEqualEqual;
	FGreater;
	FGreaterEqual;
	FLess;
	FLessEqual;
	// Cool stuff
	FReturn;
	FVar;
	FFunc;
	FEof;
}
