/*
	Authors: jmlane and Diffusion9

	Description:
	Assign and move queued units into helo.

	Parameter(s):
		0: OBJECT - helo unit.
		1: ARRAY of OBJECTS - units queued for helo.

	Returns:
	ARRAY of units assigned and moved to parameter 0 helo.
*/
private ["_helo", "_queue", "_processed"];
_helo = param [0, objNull, [objNull]];
_queue = param [1, objNull, [[]]];
_processed = [];

if isNull _helo throw "Invalid Argument: must provide object";
if isNull _queue throw "Invalid Argument: must provide array";

while {_helo emptyPositions "cargo" > 0 && count _queue > 0} do {
	{
		diag_log format ["processing queue: index = %1, value = %2, total = %3", _x, _forEachIndex, _queue];

		if (!isNull _x && alive _x) then {
			[_x, _helo] remoteExec ["assignAsCargo", 2];
			[_x, _helo] remoteExec ["moveInCargo", 0];
			sleep 0.1;
			if (_x in _helo) then {
				_queue deleteAt _forEachIndex;
				_processed pushBack _x;
			};
		} else {
			_queue deleteAt _forEachIndex;
			unassignVehicle _x;
		};
	} forEach _queue;
};

_processed;
