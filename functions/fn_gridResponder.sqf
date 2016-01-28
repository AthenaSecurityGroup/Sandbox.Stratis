
/* 

	Grid Tracker Responder Function
	by: Diffusion9, 2015-12-28
	Receives grid data and executes based on spawn chance and decay time.
		USAGE: [["081731",120.3,1,"ASG",100]] call ASG_fnc_gridResponder
		0 - mapGridPosition
		1 - Time
		2 - Status
		3 - Faction Name
		4 - [optional] Spawn percentage chance
 */

 private ["_incGridInfo", "_faction", "_gridTarget"];

_incGridInfo = _this select 0;
_faction = _this select 0 select 3;
_gridTarget = _incGridInfo select 0;

if (isNil {_incGridInfo select 4} || ((typeName (_incGridInfo select 4)) != (typeName 0))) then {
	// true.
	// no value in spawn position.
} else {
	// false.
	// value in spawn position.
	_spawnChance = _incGridInfo deleteAt 4;
	if (_spawnChance > 10) then {
		_kdestPos = [(_incGridInfo select 0)] call ASG_fnc_gridGetCent;
		_kRandSpawnPos = [_kdestPos, 500, 1000, 3, 0, 20, 0] call BIS_fnc_findSafePos;
		hint format ["Spawn Chance Triggered: \n %1 \n \n Target Position: %2", _spawnChance, _kRandSpawnPos];
		_spawnedUnits = [
			_kRandSpawnPos,
			EAST,
			(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad"),
			[],
			[],
			[],
			[],
			[],
			[]
		] call BIS_fnc_spawnGroup;
		// [_kRandSpawnPos, "AAF"] spawn ASG_fnc_gridTerritoryTracker;
		_enemyGrid = true;
		_Spawnleader = (leader _spawnedUnits);
		[_spawnedUnits, (getPOS _Spawnleader), 1000] call bis_fnc_taskPatrol;
	};
};

if (gridMarkers) then {
	// _kRandSpawnPos	=	the grid that the enemy spawned inside.
	// _faction			=	the enemy faction (red marker).
	[_gridTarget, _faction] spawn ASG_fnc_gridTerritoryTracker;
	if (_enemyGrid) then {
		[_kRandSpawnPos, "AAF"] spawn ASG_fnc_gridTerritoryTracker;
	};
};

// [A11, (mapGridPosition player)] select ([[A11, (mapGridPosition player)], player] call KK_fnc_findAll select 0 select 0);