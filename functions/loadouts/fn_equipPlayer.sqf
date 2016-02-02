/*

	Sets the player's equipment to ASG default

 */

private ["_unit", "_type"];

_unit = param [0, objNull, [objNull]];

if isNull _unit throw "Invalid Argument: unit must be a valid object";

_type = typeof _unit;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
_unit forceAddUniform "U_I_CombatUniform";
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

[[player], "ASG_fnc_setUniform", nil, true, true] call BIS_fnc_MP;					// Set uniform, broadcast to all clients.
_rankIndex = [rankAssignments, (str _unit)] call KK_fnc_findAll select 0 select 0;
_rankStr = ([rankAssignments, [_rankIndex]] call KK_fnc_findAllGetPath) select 0;
[[player, _rankStr], "BIS_fnc_setUnitInsignia", nil, true, true] call BIS_fnc_MP;	// Broadcast Insignia to clients.

// forEach allUnits