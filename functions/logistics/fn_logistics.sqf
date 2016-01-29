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

	[] spawn {
		private "_time";
		_time = time + 10;

		diag_log format ["logistics: Reinforcement Event Timer: %1", _time];

		waitUntil { time >= _time };

		diag_log format ["logistics: Time Trigger: %1 >= %2", time, _time];
		heloName hideObjectGlobal false;
		heloName enableSimulationGlobal true;
		sleep 10;
		{
			_x hideObjectGlobal false;
			_x enableSimulationGlobal true;
		} forEach (assignedCargo heloName);

		// Give Helo Orders Here
		_waypoint1 = (respawnHelo select 2) addWaypoint [(position respawnIsland), 10];
		_waypoint1 setWayPointBehaviour "CARELESS";
		_waypoint1 setWayPointSpeed "FULL";
		_waypoint1 setWayPointType "LOAD";
		_waypoint1 setWayPointCombatMode "BLUE";
		_waypoint1 setWaypointStatements ["true","(respawnHelo select 0) land 'GET OUT'; (respawnHelo select 0) AnimateDoor ['Door_rear_source', 1];"];

		// The helicopter is in flight now so we will wait for it to touch down.
		waitUntil { getPOS heloName select 2 <= 1 };

		diag_log format ["initServer: Helicopter has landed."];
		{
			diag_log format ["initServer: player: %1", _x];
			_x action ["Eject", vehicle _x];
			unassignVehicle _x;
		} forEach assignedCargo heloName;

		waitUntil { count assignedCargo heloName == 0 };

		heloName AnimateDoor ['Door_rear_source', 0];
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

// (assignedCargo (respawnHelo select 0)) isEqualTo [];
