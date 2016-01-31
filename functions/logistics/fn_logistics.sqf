defaultHeloPosition = getMarkerPos "Helipoint";
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

ASG_logisticsHeloQueue = []; // TODO: Don't use a global.

// A respawning player has entered the respawnHelo, triggering a countdown until reinforcement.
// While this countdown is active players can still be added to the respawn Helo. Players that miss the countdown
// have to wait until the next cycle to be transported in.
[heloName, ASG_logisticsHeloQueue] spawn {
	if !isServer throw "reinforcementEvent should run on the server only";

	_helo = _this select 0;
	_queue = param [1, []];

	while {alive _helo} do {
		waitUntil {
			sleep 5;
			!(simulationEnabled _helo) && {count _queue > 0};
		};

		_assigned = [_helo, _queue] call ASG_fnc_logisticsHeloProcessQueue;
		diag_log format ["logistics: queue processed, %1 on helo", _assigned];

		_helo hideObjectGlobal false;
		_helo enableSimulationGlobal true;
		{
			_x hideObjectGlobal false;
			_x enableSimulationGlobal true;
		} forEach _assigned;

		// Give Helo Orders Here
		_waypoint1 = group _helo addWaypoint [position respawnIsland, 10];
		_waypoint1 setWayPointBehaviour "CARELESS";
		_waypoint1 setWayPointSpeed "FULL";
		_waypoint1 setWayPointType "LOAD";
		_waypoint1 setWayPointCombatMode "BLUE";
		_waypoint1 setWaypointStatements ["true","(respawnHelo select 0) land 'GET OUT'; (respawnHelo select 0) AnimateDoor ['Door_rear_source', 1];"];

		// The helicopter is in flight now so we will wait for it to touch down.
		waitUntil {
			sleep 0.5;
			getPOS _helo select 2 <= 0.5;
		};

		{
			_x action ["Eject", vehicle _x];
			unassignVehicle _x;
		} forEach _assigned;

		waitUntil {
			sleep 3;
			{_x in _helo} count _assigned == 0;
		};

		_helo AnimateDoor ['Door_rear_source', 0];
		// Set waypoint back to simulationKillzone.
		_waypoint2 = group _helo addWaypoint [defaultHeloPosition, 10];
		_waypoint2 setWayPointBehaviour "CARELESS";
		_waypoint2 setWayPointSpeed "FULL";
		_waypoint2 setWayPointType "MOVE";
		_waypoint2 setWayPointCombatMode "BLUE";
		_waypoint2 setWaypointStatements ["true","(respawnHelo select 0) enableSimulationGlobal false; (respawnHelo select 0) hideObjectGlobal true;"];
	};
};

"ASG_logisticsHeloQueue_Add" addPublicVariableEventHandler {
	_value = param [1, nil];
	diag_log format ["ASG_logisticsHeloQueue_Add handler running: _value = %1, queue = %2", _value, ASG_logisticsHeloQueue];
	ASG_logisticsHeloQueue pushBack _value;
};

// =================================================================
// LOGISTICS - RESUPPLY HELO
// Watch for an update from the variable and execute as appropriate.

"logisticsRequest" addPublicVariableEventHandler {
	_requestInfo = _this select 1;
	[_requestInfo] call ASG_fnc_logisticsRequestReceiver;
};
