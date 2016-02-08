/*
	Authors: Diffusion9 and jmlane

	Description:
	Sets the unit's equipment to ASG default.

	Parameter(s):
		0: OBJECT - local unit to regear.

	Returns:
	BOOLEAN - Whether gear changes were applied.
*/
private ["_unit", "_type"];

_unit = param [0, objNull, [objNull]];

if (isNull _unit) throw "Invalid Argument: unit must be a valid object";

_type = typeof _unit;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
_unit forceAddUniform "U_BG_Guerrilla_6_1";
_unit addVest "V_PlateCarrier1_blk";
_unit addHeadgear "H_HelmetB_black";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

switch (_type) do {
	case "B_Helipilot_F" :
	{
		_unit addVest "V_TacVest_blk";
		_unit addHeadgear "H_CrewHelmetHeli_B";
	};

	case "B_Pilot_F" :
	{
		_unit forceAddUniform "U_B_PilotCoveralls";
		_unit addHeadgear "H_PilotHelmetFighter_B";
	};

	default {};
};

[_unit] call ASG_fnc_setUniform;
_rankIndex = [rankAssignments, (str _unit)] call KK_fnc_findAll select 0 select 0;
_rankStr = ([rankAssignments, [_rankIndex]] call KK_fnc_findAllGetPath) select 0;
[_unit, _rankStr] call BIS_fnc_setUnitInsignia;

true;
