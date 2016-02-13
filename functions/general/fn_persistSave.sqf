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
			sleep 3600; // def: 3600 -- every one hour.
			diag_log "SERVER:	Preparing to save persistent states to profileNamespace...";
			_savedInventoryData = [boxNames] call ASG_fnc_createCargoArray;
			profileNamespace setVariable ["ASGinventory", _savedInventoryData];
			diag_log "SERVER:	Saved squad box inventory...";
		};		
	};
	// Save base positions and orientations.
	/// TO DO
	// Save vehicle and their contents in x area around bases.
	/// TO DO
};
