/*
	
 	ASG_fnc_persistSave
		No input or output
		
		USAGE: Runs the routines to save the persistence state to profileNamespace.
		Can be tweaked, but originally will run once every hour.

*/

if (isServer) then {
	// Save contents of squad boxes
	saveSquadBox = [] spawn {
		waitUntil {
			sleep 2;
			_savedInventoryData = [boxNames] call ASG_fnc_createCargoArray;
			profileNamespace setVariable ["ASGinventory", _savedInventoryData];
			sleep 3600; // def: 3600 -- every one hour.
		};
	};

	// Save nearby vehicles
	_savedvehicleData = [];
	{
		if (_x select 0) then {
			_nearEntities = (getMarkerPOS (_x select 4 select 2)) nearEntities [["Car","Tank","Air"], 150];
			_savedvehicleData = [];
			{
				_weapons = getWeaponCargo _x;
				_mags = getMagazineCargo _x;
				_items = getItemCargo _x;
				_backpacks = getBackpackCargo _x;
				_combine = [];
				_combine = _weapons + _mags + _items + _backpacks;
				_savedvehicleData set[count _savedvehicleData,[(typeOf(_x)),(getPos _x),(getDir _x),_combine]];
			} forEach _nearEntities;
		};
	} forEach baseData;
	profileNamespace setVariable ["ASGvehicles", _savedvehicleData];
	saveProfileNamespace;
}; // end isServer.
