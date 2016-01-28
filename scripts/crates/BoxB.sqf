if !(isServer) exitWith {};

if ((typeName _this) == "ARRAY") then {_this = _this select 0};

clearmagazinecargoglobal _this;
clearweaponcargoglobal _this;
clearitemcargoglobal _this;
clearbackpackcargoglobal _this;
_this allowDamage false;

_this addweaponcargoglobal ["arifle_MXC_Black_F", 9];
_this addmagazinecargoglobal ["30Rnd_65x39_caseless_mag", 180];
_this additemcargoglobal ["optic_Aco", 9];
_this additemcargoglobal ["acc_flashlight", 9];
_this addmagazinecargoglobal ["SmokeShell", 36];
_this addmagazinecargoglobal ["Chemlight_Yellow", 36];