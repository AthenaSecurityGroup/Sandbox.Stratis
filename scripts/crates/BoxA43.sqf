if ((typeName _this) == "ARRAY") then {_this = _this select 0};
if !(isServer) exitWith {};
clearmagazinecargoglobal _this;
clearweaponcargoglobal _this;
clearitemcargoglobal _this;
clearbackpackcargoglobal _this;
_this allowDamage false;

_this addbackpackcargoglobal ["I_Mortar_01_support_F", 2];
_this addbackpackcargoglobal ["I_Mortar_01_weapon_F", 2];