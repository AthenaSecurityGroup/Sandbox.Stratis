/*

	Delivers an offroad to the logistics dropoff point

*/

_playerID = _this select 1;

private ["_landingZone", "_baseName"];
{
	if (_x select 0) then {
		{
			if ((typeOf _x) == "Land_HelipadSquare_F") exitWith {
				_landingZone = (getPOS _x);
				_baseName = ([baseData, [([baseData, _x] call KK_fnc_findAll select 0 select 0)]] call KK_fnc_findAllGetPath) select 1;
			};
		} forEach (_x select 3);
	};
} forEach baseData;

if (isNil {_landingZone}) exitWith {
	"Request Denied.\n\nDelivery requires an Operating Base or Operations Center." remoteExec ["hint", _playerID]; 
	[comm_logisticsMenu, "1"] call ASG_fnc_menuDisableEntries;
	publicVariable "comm_logisticsMenu";
};

waitUntil {
	if (!simulationEnabled heloName) exitWith {
		heloName enableSimulationGlobal true;
		heloName hideObjectGlobal false;
		(driver heloName) disableAI "Target";
		(driver heloName) disableAI "Autotarget";
		true;
	};
	(!simulationEnabled heloName);
};

format ["Delivery en route to the %1", _baseName] remoteExec ["hint", _playerID];

slingZone = createVehicle ["Land_HelipadEmpty_F", [(_landingZone select 0), (_landingZone select 1), ((_landingZone select 2)+8)], [], 0, "FLY"];

// Waypoint 1, to the slingZone
diag_log format ["Generating waypoint 1"];
_waypoint1 = heloGroup addWaypoint [(position slingZone), 1];
_waypoint1 setWayPointBehaviour "CARELESS";
_waypoint1 setWayPointSpeed "FULL";
_waypoint1 setWayPointType "LOAD";
_waypoint1 setWayPointCombatMode "BLUE";
_waypoint1 setWaypointStatements ["true","heloName land 'LAND';"];

_veh = createVehicle ["C_Offroad_01_F",position heloName,[],0,"NONE"];
_veh allowDamage false;
heloName setSlingLoad _veh;

heloName addItemCargoGlobal ["ToolKit", 1];

[
	_veh,
	["beige",1],
	[
		"HideBumper2", 0,
		"HideConstruction", 0,
		"Proxy", 0,
		"Destruct", 0
	]
] call BIS_fnc_initVehicle;

clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

waitUntil {
	if (((heloName distance slingZone) <= 8)) then {
		true;
		heloName land "NONE";
		heloName setSlingLoad objNull;
		sleep 2;
		_veh allowDamage true;
	};
	(((heloName distance slingZone) <= 8));
};

// Waypoint 1, to the deadzone
_waypoint2 = (respawnHelo select 2) addWaypoint [defaultHeloPosition, 1];
_waypoint2 setWayPointBehaviour "CARELESS";
_waypoint2 setWayPointSpeed "FULL";
_waypoint2 setWayPointType "LOAD";
_waypoint2 setWayPointCombatMode "BLUE";
_waypoint2 setWaypointStatements ["true","[(respawnHelo select 0), true] remoteExec ['hideObjectGlobal', 2]; [(respawnHelo select 0), false] remoteExec ['enableSimulationGlobal', 2];"];

waitUntil {
	if (!simulationEnabled heloName) then {
		[comm_logisticsMenu, "1"] call ASG_fnc_menuDisableEntries;
		publicVariable "comm_logisticsMenu";
		true;
	};
	(!simulationEnabled heloName);
};