if !(isServer) exitWith {};

if ((typeName _this) == "ARRAY") then {_this = _this select 0};

clearmagazinecargoglobal _this;
clearweaponcargoglobal _this;
clearitemcargoglobal _this;
clearbackpackcargoglobal _this;
_this allowDamage false;

_this addweaponcargoglobal ["arifle_MX_Black_F", 4];
_this addweaponcargoglobal ["LMG_Mk200_F", 2];
_this addweaponcargoglobal ["Binocular", 2];
_this addmagazinecargoglobal ["SmokeShell", 48];
_this addmagazinecargoglobal ["SmokeShellRed", 48];
_this addmagazinecargoglobal ["SmokeShellOrange", 48];
_this addmagazinecargoglobal ["Chemlight_Yellow", 48];
_this addmagazinecargoglobal ["Chemlight_Red", 48];
_this addmagazinecargoglobal ["30Rnd_65x39_caseless_mag", 160];
_this addmagazinecargoglobal ["200Rnd_65x39_cased_Box_Tracer", 20];
_this additemcargoglobal ["optic_Aco", 6];
_this additemcargoglobal ["bipod_01_F_blk", 2];
_this additemcargoglobal ["acc_flashlight", 6];