if !(isServer) exitWith {};

if ((typeName _this) == "ARRAY") then {_this = _this select 0};

clearmagazinecargoglobal _this;
clearweaponcargoglobal _this;
clearitemcargoglobal _this;
clearbackpackcargoglobal _this;
_this allowDamage false;

_this addweaponcargoglobal ["arifle_MXM_Black_F", 1];
_this addweaponcargoglobal ["arifle_MX_Black_F", 4];
_this addweaponcargoglobal ["Rangefinder", 1];
_this addweaponcargoglobal ["Binocular", 1];
_this addmagazinecargoglobal ["30Rnd_65x39_caseless_mag", 120];
_this additemcargoglobal ["optic_Aco", 4];
_this additemcargoglobal ["optic_SOS", 1];
_this additemcargoglobal ["bipod_01_F_blk", 1];
_this additemcargoglobal ["acc_flashlight", 5];
_this additemcargoglobal ["Medikit", 1];
_this additemcargoglobal ["FirstAidKit", 4];
_this additemcargoglobal ["ItemGPS", 2];
_this additemcargoglobal ["B_UavTerminal", 1];
_this addbackpackcargoglobal ["B_UAV_01_backpack_F", 1];
_this addbackpackcargoglobal ["B_AssaultPack_rgr", 4];
_this additemcargoglobal ["U_BG_Guerrilla_6_1", 4];
_this addmagazinecargoglobal ["SmokeShell", 48];
_this addmagazinecargoglobal ["Chemlight_Yellow", 48];