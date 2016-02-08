// =================================================================
// SERVER PARAMS
setViewDistance 2000;
{_x disableTIEquipment true;} forEach (allMissionObjects "All");
{_x disableNVGEquipment true;} forEach (allMissionObjects "All");
enableEngineArtillery false;
enableSaving [false,false];
enableRadio false;
enableSentences false;
showSubtitles false;
showHUD [true,true,true,true,true,true,false,true];

// Dynamic Groups for Server
["Initialize", [true]] call ASG_fnc_dynamicGroups;

// Initialize Bank Account Data
bankBalance = profileNamespace getVariable ["#ASG_BankBalance",seedBalance];
publicVariable "bankBalance";
// Initialize BaseData
#include "scripts\includes\inc_baseData.hpp"
publicVariable "baseData";
// Base Composition Definitions
#include "scripts\includes\inc_baseComps.hpp"
publicVariable "baseComps";
// Player Spawn Table
#include "scripts\includes\inc_playerSpawnTable.hpp"
publicVariable "playerSpawnTable";
// Player Spawn Table
#include "scripts\includes\inc_rankAssignments.hpp"
publicVariable "rankAssignments";
// Base Deployment Follow Terrain
baseFollowTerrain = true;
publicVariable "baseFollowTerrain";

// Get default position of all inventory boxes.
[] call ASG_fnc_getDefaultBoxAnchor;

// =================================================================
// GRID TRACKER
activeGrids = [];
stdGrid = [];
trackerActive = false;						// grid tracking on (true) or off (false);
gridMarkers = false;						// map grid colouring on (true) or off (false);
trackedPlayers = ["A11","A12","A13","A21","A22","A23","A31","A32","A33","A4","B11","B12"];		// Players to track.
[] spawn {
	_exitWaitUntil = false;
	waitUntil {
		sleep 1;
		if (trackerActive) then {
			{
				if (isPlayer (missionNamespace getVariable [(_x), objNull])) then {
					_stdGridPre = [_x, mapGridPosition (missionNamespace getVariable [(_x), objNull])];
					if (_stdGridPre in stdGrid) exitWith {};
					stdGrid pushback _stdGridPre;
					[([_x] call ASG_fnc_gridTracker)] spawn ASG_fnc_gridResponder;
				};
			} forEach trackedPlayers;
		};
		_exitWaitUntil;
	};
};

// =================================================================
// LOGISTICS
[] spawn ASG_fnc_logistics;