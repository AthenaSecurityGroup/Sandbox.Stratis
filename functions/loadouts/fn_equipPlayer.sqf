/*
	Authors: Diffusion9 and jmlane

	Description:
	Sets the unit's equipment to ASG default.

	Parameter(s):
		0: OBJECT - local unit to regear.

	Returns:
	BOOLEAN - Whether gear changes were applied.
*/
private ["_unit", "_result", "_func", "_isRespawn", "_getIsIncap", "_type", "_rankHash", "_rankIndex", "_rankStr"];

_unit = param [0, objNull, [objNull]];

_func = {
	_unit = param [0, objNull, [objNull]];
	if (isNull _unit) throw "Invalid Argument: unit must be a valid object";
	_result = false;
	_isRespawn = if (isNull param [1, objNull, [objNull]]) then {false} else {true};
	_getIsIncap = {_unit getVariable ["BIS_revive_incapacitated", false]};

	if (local _unit && !([] call _getIsIncap)) then {
		_type = typeof _unit;

		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		_unit forceAddUniform "U_BG_Guerrilla_6_1";;
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
		_result = true;
	};

	_rankHash = [] call ASG_fnc_getRankHash;
	_rankIndex = [_rankHash, (str _unit)] call KK_fnc_findAll select 0 select 0;
	_rankStr = ([_rankHash, [_rankIndex]] call KK_fnc_findAllGetPath) select 0;

	[_unit, _rankStr, _isRespawn, _getIsIncap] spawn {
		_unit = _this select 0;
		_rankStr = _this select 1;
		_isRespawn = _this select 2;
		_isIncap = [] call (_this select 3);

		// Clients need to wait until unit is ready before setting texture/material/insignia
		if (hasInterface && !isServer) then {
			waitUntil {
				sleep 0.1;
				_isIncap = [] call (_this select 3);
				_hasLoadout = _unit getVariable ["BIS_revive_loadoutApplied", false];
				!isNull player && (_hasLoadout || !_isIncap);
			};
			// TODO: Figure out a better way than randomly sleeping. Super dumb BIS.
			if (_isIncap) then {sleep 0.2};
			if (_isRespawn) then {sleep 0.5};
		};

		[_unit, _isRespawn] call ASG_fnc_setUniform;
		[_unit, _rankStr] call BIS_fnc_setUnitInsignia;
	};

	_result;
};

_unit addEventHandler ["Respawn", _func];
[_unit] call _func;
