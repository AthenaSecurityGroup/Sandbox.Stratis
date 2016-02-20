/*
	
 	ASG_fnc_persistDeploy
		No input or output
		
		USAGE: Deploys persistent variables for persistent bases, squad box contents,
		and vehicles within x meters of deployed bases.

*/


// Clear the boxes to avoid duplication.
{
	clearWeaponCargoGlobal _x; 
	clearMagazineCargoGlobal _x;
	clearItemCargoGlobal _x;
	clearBackpackCargoGlobal _x;
} forEach boxNames;

// Deploy saved items to squad boxes.
{
	[[_x], (missionNameSpace getVariable (_x select 0))] call ASG_fnc_cargoArrayAdd;
} forEach (profileNamespace getVariable ["ASGinventory", boxDefContents]);

// Deploy bases to their saved locations.
{
	
} forEach (profileNamespace getVariable ["ASGBases", []]);

// Deploy saved vehicles to base areas.
_vehicleList = profileNameSpace getVariable ["ASGvehicles",[]];
if(!(_vehicleList isEqualTo [])) then {
	{
		_vehType = _x select 0;
		_vehPOS = _x select 1;
		_vehdir = _x select 2;
		_vehInv = _x select 3;
		_vehInvWeapons = _vehInv select 0;
		_vehInvWeaponsCount = _vehInv select 1;
		_vehInvMags = _vehInv select 2;
		_vehInvMagsCount = _vehInv select 3;
		_vehInvExtras = _vehInv select 4;
		_vehInvExtrasCount = _vehInv select 5;
		_vehInvContainers = _vehInv select 6;
		_vehInvContainersCount = _vehInv select 7;
		_vehicle = _vehType createVehicle _vehPOS;
		_vehicle lock 0;
		_vehicle setDir _vehdir;
		if(_vehType isEqualTo "C_Offroad_01_F") then {[
				_vehicle,
				["beige",1],
				[
					"HideBumper2", 0,
					"HideConstruction", 0,
					"Proxy", 0,
					"Destruct", 0
				]
			] call BIS_fnc_initVehicle;
		};

		clearWeaponCargoGlobal _vehicle;
		clearMagazineCargoGlobal _vehicle;
		clearItemCargoGlobal _vehicle;
		clearBackpacKCargoGlobal _vehicle;
		{_vehicle addWeaponCargoGlobal [_x,_vehInvWeaponsCount select _forEachIndex];
		} forEach _vehInvWeapons;
		{_vehicle addMagazineCargoGlobal [_x,_vehInvMagsCount select _forEachIndex];
		} forEach _vehInvMags;
		{_vehicle addItemCargoGlobal [_x,_vehInvExtrasCount select _forEachIndex];
		} forEach _vehInvExtras;
		{_vehicle addBackpackCargoGlobal [_x,_vehInvContainersCount select _forEachIndex];
		} forEach _vehInvContainers;
	} forEach _vehicleList;
};