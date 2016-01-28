if !(isServer) exitWith {};

if ((typeName _this) == "ARRAY") then {_this = _this select 0};


clearmagazinecargoglobal _this;
clearweaponcargoglobal _this;
clearitemcargoglobal _this;
clearbackpackcargoglobal _this;
_this allowDamage false;

_this additemcargoglobal ["optic_Aco", 3];
_this addweaponcargoglobal ["arifle_MX_GL_Black_F", 3];
_this addweaponcargoglobal ["Rangefinder", 3];
_this addmagazinecargoglobal ["1Rnd_HE_Grenade_shell", 18];
_this addmagazinecargoglobal ["UGL_FlareWhite_F", 18];
_this addmagazinecargoglobal ["UGL_FlareRed_F", 18];
_this addmagazinecargoglobal ["1Rnd_Smoke_Grenade_shell", 18];
_this addmagazinecargoglobal ["1Rnd_SmokeRed_Grenade_shell", 18];
_this addmagazinecargoglobal ["1Rnd_SmokeOrange_Grenade_shell", 18];
_this addmagazinecargoglobal ["30Rnd_65x39_caseless_mag", 60];
_this addbackpackcargoglobal ["B_AssaultPack_rgr", 8];
_this addbackpackcargoglobal ["B_Kitbag_rgr", 18];
_this additemcargoglobal ["acc_flashlight", 3];
_this additemcargoglobal ["ItemGPS", 3];