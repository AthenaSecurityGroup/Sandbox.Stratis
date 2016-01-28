if !(isServer) exitWith {};
if ((typeName _this) == "ARRAY") then {_this = _this select 0};
clearmagazinecargoglobal _this;
clearweaponcargoglobal _this;
clearitemcargoglobal _this;
clearbackpackcargoglobal _this;
_this allowDamage false;

_this addweaponcargoglobal ["launch_NLAW_F", 2];
_this addweaponcargoglobal ["launch_B_Titan_F", 2];
_this addmagazinecargoglobal ["NLAW_F", 8];
_this addmagazinecargoglobal ["Titan_AA", 4];
_this addmagazinecargoglobal ["SatchelCharge_Remote_Mag", 6];
_this addmagazinecargoglobal ["ATMine_Range_Mag", 6];
_this addmagazinecargoglobal ["APERSMine_Range_Mag", 18];
_this addmagazinecargoglobal ["ClaymoreDirectionalMine_Remote_Mag", 6];
_this addmagazinecargoglobal ["DemoCharge_Remote_Mag", 6];
_this addmagazinecargoglobal ["HandGrenade", 18];
_this additemcargoglobal ["MineDetector", 2];