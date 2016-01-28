if ((typeName _this) == "ARRAY") then {_this = _this select 0};
if !(isServer) exitWith {};
clearmagazinecargoglobal _this;
clearweaponcargoglobal _this;
clearitemcargoglobal _this;
_this allowDamage false;

_this addmagazinecargoglobal ["30Rnd_65x39_caseless_mag", 200];
_this addmagazinecargoglobal ["130Rnd_338_Mag", 50];
_this addmagazinecargoglobal ["10Rnd_338_Mag", 100];