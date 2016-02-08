/* 

	Sets the player's equipment to ASG default

 */

private ["_unit"];

_unit = _this select 0;
_type = typeof _unit;

if (!(local _unit)) exitwith {};
if (side _unit == West) then 
{
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	_unit addUniform "U_BG_Guerrilla_6_1";
	_unit addVest "V_PlateCarrier1_blk";
	_unit addHeadgear "H_HelmetB_black";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
	switch (_type) do 
	{
		default {};
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
	};
};
sleep 1;
[[player], "ASG_fnc_setUniform", nil, true, true] call BIS_fnc_MP;					// Set uniform, broadcast to all clients.
_rankIndex = [rankAssignments, (str _unit)] call KK_fnc_findAll select 0 select 0;
_rankStr = ([rankAssignments, [_rankIndex]] call KK_fnc_findAllGetPath) select 0;
[[player, _rankStr], "BIS_fnc_setUnitInsignia", nil, true, true] call BIS_fnc_MP;	// Broadcast Insignia to clients.

// forEach allUnits