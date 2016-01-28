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
["Initialize", [true]] call BIS_fnc_dynamicGroups;

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
trackedPlayers = ["A11","A12","A13"];		// Players to track.
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
// LOGISTICS - RESPAWN HELO
// Check the timer, and do what when the timer is up.
defaultHeloPosition = [14.1171,8180.34];
reinforcementEvent = false;				
publicVariable "reinforcementEvent";
logisticsRequest = "";
publicVariable "resupplyEvent";
respawnHelo = [defaultHeloPosition,180,"B_Heli_Transport_03_unarmed_green_F",WEST] call BIS_fnc_spawnVehicle;
publicVariable "respawnHelo";
heloName = (respawnHelo select 0);
heloGroup = (respawnHelo select 2);
heloName setVehicleLock "LOCKED";
heloName allowDamage false;
sleep 15;
heloName enableSimulationGlobal false;
heloName hideObjectGlobal true;
(driver heloName) allowDamage false;
(driver heloName) disableAI "TARGET";
(driver heloName) disableAI "AUTOTARGET";
(driver heloName) disableAI "FSM";
(driver heloName) setBehaviour "Careless";
(driver heloName) setCombatMode "Blue";
group heloName enableAttack false;

clearWeaponCargoGlobal heloName;
clearMagazineCargoGlobal heloName;
clearItemCargoGlobal heloName;
// clearBackpackCargoGlobal heloName;

// A respawning player has entered the respawnHelo, triggering a countdown until reinforcement.
// While this countdown is active players can still be added to the respawn Helo. Players that miss the countdown
// have to wait until the next cycle to be transported in.
"reinforcementEvent" addPublicVariableEventHandler {
	_timer = time + 10;
	diag_log format ["initServer: Reinforcement Event Timer: %1", _timer];
	private ["_timer"];
	_activateRespawn = [_timer] spawn {
		waitUntil {
			if (time >= (_this select 0)) exitWith {
				diag_log format ["initServer: Time Trigger: %1", (time >= (_this select 0))];
				heloName hideObjectGlobal false;
				heloName enableSimulationGlobal true;
				sleep 10;
				{
					_x hideObjectGlobal false;
					_x enableSimulationGlobal true;
				} forEach (assignedCargo heloName);
				true;
			};
			(time >= (_this select 0));
		};
		true;
		// Give Helo Orders Here
		_waypoint1 = (respawnHelo select 2) addWaypoint [(position respawnIsland), 10];
		_waypoint1 setWayPointBehaviour "CARELESS";
		_waypoint1 setWayPointSpeed "FULL";
		_waypoint1 setWayPointType "LOAD";
		_waypoint1 setWayPointCombatMode "BLUE";
		_waypoint1 setWaypointStatements ["true","(respawnHelo select 0) land 'GET OUT'; (respawnHelo select 0) AnimateDoor ['Door_rear_source', 1];"];
		
		// The helicopter is in flight now so we will wait for it to touch down.
		_heloFlight = false;
		waitUntil {
			if ((getPOS heloName select 2) < 1) then {
				sleep 1;
				_list = assignedCargo (respawnHelo select 0);
				{_x action ["Eject", vehicle _x]} forEach _list;
				_heloFlight = true;
			};
			_heloFlight;
		};
		sleep 5;
		// 5 seconds should be enough to kick out all cargo; close the door;
		(respawnHelo select 0) AnimateDoor ['Door_rear_source', 0];
		sleep 3;
		// Set waypoint back to simulationKillzone.
		_waypoint2 = (respawnHelo select 2) addWaypoint [defaultHeloPosition, 10];
		_waypoint2 setWayPointBehaviour "CARELESS";
		_waypoint2 setWayPointSpeed "FULL";
		_waypoint2 setWayPointType "MOVE";
		_waypoint2 setWayPointCombatMode "BLUE";
		_waypoint2 setWaypointStatements ["true","(respawnHelo select 0) enableSimulationGlobal false; (respawnHelo select 0) hideObjectGlobal true;"];
	};
};

// =================================================================
// LOGISTICS - RESUPPLY HELO
// Watch for an update from the variable and execute as appropriate.

"logisticsRequest" addPublicVariableEventHandler {
	_requestInfo = _this select 1;
	[_requestInfo] call ASG_fnc_logisticsRequestReceiver;
};