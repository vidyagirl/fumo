package fumo;

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
	FBang;
	FBangEqual;
	FEqual;
	FEqualEqual;
	FGreater;
	FGreaterEqual;
	FLess;
	FLessEqual;
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
	FNot;
	FBreak;
	FContinue;
	// Cool stuff
	FReturn;
	FVar;
	FFunc;
	FEof;
}
