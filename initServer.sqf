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
seedBalance = 500000;
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
// Base Deployment Follow Terrain
baseFollowTerrain = true;
publicVariable "baseFollowTerrain";

// Get default position of all inventory boxes.
[] call ASG_fnc_getDefaultBoxAnchor;

// Deploy the persistent gear state;
call ASG_fnc_persistDeploy;

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

// Initiates the server save state to profileNamespace every x seconds.
call ASG_fnc_persistSave;

// PublicVariable that spawns the attack when mortarTriggerTracker is PV'd.
"mortarTriggerTracker" addPublicVariableEventHandler {
	_varName = _this select 1;
	_trgName = format ["%1_trigger", _varName];
	missionNamespace setVariable [_trgName, createTrigger ["EmptyDetector", (getPOS (missionNamespace getVariable _varName))], true];
	(missionNamespace getVariable _trgName) attachTo [(missionNamespace getVariable _varName), [0,0,0]];
	(missionNamespace getVariable _trgName) setTriggerArea [1000, 1000, 0, false];
	(missionNamespace getVariable _trgName) setTriggerActivation ["WEST", "PRESENT", true];
	(missionNamespace getVariable _trgName) setTriggerStatements ["this", "
		diag_log 'MORTAR:	Target entered area.';
		_number = round floor (getPOS thisTrigger select 0);
		_mortarName = format ['M_%1', _number];
		_trgName = format ['%1_trigger', _mortarName];
		_mortarTar = thisList select 0;
		_scriptName = format ['%1_script', _mortarName];
		_targetName = format ['%1_target', _mortarName];
		missionNamespace setVariable [_targetName, _mortarTar, true];
		missionNameSpace setVariable [_scriptName, [missionNameSpace getVariable _targetName, missionNameSpace getVariable _mortarName] spawn ASG_fnc_mortarFireLogic];
	", "
		diag_log 'MORTAR:	Target left area. Ceasing fire';
		_number = round floor (getPOS thisTrigger select 0);
		_mortarName = format ['M_%1', _number];		
		_scriptName = format ['%1_script', _mortarName];
		diag_log _scriptName;
		terminate (missionNamespace getVariable _scriptName);
		missionNameSpace setVariable [_scriptName, nil];
	"];
	
};

//[_mortarName, _trgName, _targetName, _scriptName, _mortarTar] spawn ASG_fnc_mortarTrack;


