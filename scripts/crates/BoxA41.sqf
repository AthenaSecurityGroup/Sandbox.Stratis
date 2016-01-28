if ((typeName _this) == "ARRAY") then {_this = _this select 0};
if !(isServer) exitWith {};
clearmagazinecargoglobal _this;
clearweaponcargoglobal _this;
clearitemcargoglobal _this;
clearbackpackcargoglobal _this;
_this allowDamage false;

_this addweaponcargoglobal ["Rangefinder", 2];
_this additemcargoglobal ["ItemGPS", 2];
_this addweaponcargoglobal ["arifle_MXC_Black_F", 6];
_this addweaponcargoglobal ["srifle_DMR_02_F", 2];
_this addweaponcargoglobal ["MMG_02_black_F", 2];
_this additemcargoglobal ["bipod_01_F_blk", 4];
_this additemcargoglobal ["optic_Aco", 6];
_this additemcargoglobal ["optic_SOS", 4];
_this addmagazinecargoglobal ["SmokeShell", 36];
_this addmagazinecargoglobal ["Chemlight_Yellow", 36];