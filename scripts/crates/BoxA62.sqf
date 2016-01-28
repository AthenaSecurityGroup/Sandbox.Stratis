if ((typeName _this) == "ARRAY") then {_this = _this select 0};
if !(isServer) exitWith {};
clearmagazinecargoglobal _this;
clearweaponcargoglobal _this;
clearitemcargoglobal _this;
clearbackpackcargoglobal _this;
_this allowDamage false;

_this addbackpackcargoglobal ["B_AssaultPack_rgr", 6];
_this additemcargoglobal ["U_BG_Guerrilla_6_1", 6];
_this addbackpackcargoglobal ["B_Kitbag_cbr", 6];
_this additemcargoglobal ["MineDetector", 2];
_this additemcargoglobal ["Medikit", 2];
_this additemcargoglobal ["B_UavTerminal", 1];
_this addbackpackcargoglobal ["B_UAV_01_backpack_F", 1];