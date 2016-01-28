/*

	ASG_fnc_logisticsResponder

*/

/// TO DO:
// logisticsResponder and logisticsDeliverOffroad need to be better consolidated.
// Too much repetition.

logisticsOptions = 
[
	[],
	[["Platoon Ammo",[],[],["30Rnd_65x39_caseless_mag","200Rnd_65x39_cased_Box_Tracer","SmokeShell","SmokeShellRed","SmokeShellOrange"],[150,30,75,75,75],["FirstAidKit","Medikit"],[25,1],[],[]]],
	[["Squad Gear",["arifle_MX_GL_Black_F","arifle_MX_Black_F","LMG_Mk200_F","Rangefinder","Binocular"],[1,4,2,1,2],["SmokeShell","SmokeShellRed","SmokeShellOrange","1Rnd_HE_Grenade_shell","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","30Rnd_65x39_caseless_mag","200Rnd_65x39_cased_Box_Tracer"],[12,12,12,4,2,2,2,45,10],["optic_Aco","bipod_01_F_blk","ItemGPS"],[7,2,1],[],[]]],
	["C_Offroad_01_F"]
];

_playerID = _this select 0;
_requestType = _this select 1;
_packageData = (logisticsOptions select _requestType);

if (_requestType == 3) exitWith {
	["C_Offroad_01_F", _playerID] call ASG_fnc_logisticsDeliverOffroad;
};

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
	"Request Denied.\n\nResupply requires an Operating Base or Operations Center." remoteExec ["hint", _playerID]; 
	[comm_logisticsMenu, "1"] call ASG_fnc_menuDisableEntries;
	publicVariable "comm_logisticsMenu";
};

format ["Resupply en route to the %1", _baseName] remoteExec ["hint", _playerID];

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

// Waypoint 1, to the landing zone
_waypoint1 = heloGroup addWaypoint [_landingZone, 1];
_waypoint1 setWayPointBehaviour "CARELESS";
_waypoint1 setWayPointSpeed "FULL";
_waypoint1 setWayPointType "LOAD";
_waypoint1 setWayPointCombatMode "BLUE";
_waypoint1 setWaypointStatements ["true","heloName land 'GET OUT';"];

// The helicopter is in flight now so we will wait for it to touch down.
_heloFlight = false;
waitUntil {
	if ((getPOS heloName select 2) < 1) then {
		heloName AnimateDoor ['Door_rear_source', 1];
		sleep 1.5;
		cargoBox = "B_CargoNet_01_ammo_F" createVehicle [0,0,0];
		cargoBox attachTo [heloName, [0,-5,-1.87]]; cargoBox setVectorDirAndUp [[0,0.75,0.1],[0,-0.5,0.5]];
		{
			clearWeaponCargoGlobal _x; 
			clearMagazineCargoGlobal _x;
			clearItemCargoGlobal _x;
			clearBackpackCargoGlobal _x;
		} forEach [cargoBox];
		[_packageData,cargoBox] call ASG_fnc_cargoArrayAdd;
		sleep 8;
		heloName action ["engineOff", vehicle heloName];
		_heloFlight = true;
	};
	_heloFlight;
};

sleep 15;

// ( isPlayer (missionNamespace getVariable _x) )
// missionNamespace getVariable (baseData select 8 select 2 select _x)

_heloDepartOrder = [heloName,["Order to Depart", {
		(respawnHelo select 0) removeAction (_this select 2);
		sleep 4;
		(respawnHelo select 0) AnimateDoor ['Door_rear_source', 0];
		cargoBox = (attachedObjects (respawnHelo select 0) select 0); 
		[cargoBox, true] remoteExec ["hideObjectGlobal", 2];
		[(respawnHelo select 0), true] remoteExec ["engineOn",2];
		sleep 15;
		_waypoint1 = (respawnHelo select 2) addWaypoint [defaultHeloPosition, 1];
		_waypoint1 setWayPointBehaviour "CARELESS";
		_waypoint1 setWayPointSpeed "FULL";
		_waypoint1 setWayPointType "LOAD";
		_waypoint1 setWayPointCombatMode "BLUE";
		_waypoint1 setWaypointStatements ["true","[(respawnHelo select 0), true] remoteExec ['hideObjectGlobal', 2]; [(respawnHelo select 0), false] remoteExec ['enableSimulationGlobal', 2]; removeAllActions (respawnHelo select 0)"];
	}, "", 0, false, true, "", ""]] remoteExec ["addAction", 0, true];

waitUntil {
	if (!simulationEnabled heloName) exitWith {
		// sell the players items
		cargoBoxValues = [[cargoBox]] call ASG_fnc_logisticsFreightHandler;
	
		bankBalance = bankBalance + (cargoBoxValues select 0);
		profileNameSpace setVariable ["#ASG_BankBalance",bankBalance];
		publicVariable "bankBalance";
		saveProfileNamespace;
		
		[comm_logisticsMenu, "1"] call ASG_fnc_menuDisableEntries;
		publicVariable "comm_logisticsMenu";
		
		deleteVehicle cargoBox;
		true;
	};
	(!simulationEnabled heloName);
};

{
	_valueMessage = format ["Items have been sold.\n\nItem Value: $%1\n\nBank Balance: $%2", (cargoBoxValues select 0), bankBalance];
	if (isplayer (missionNamespace getVariable _x)) then {
		_id = (owner (missionNamespace getVariable _x));
		_valueMessage remoteExec ["hint", _id];
	};
} forEach (CHANNEL_DATA select 3);