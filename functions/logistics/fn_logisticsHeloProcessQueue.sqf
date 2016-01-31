/*
	Authors: jmlane and Diffusion9

	Description:
	Assign and move queued units into helo.

	Parameter(s):
		0: OBJECT - helo unit.

	Returns:
	ARRAY of units assigned and moved to parameter 0 helo.
*/
private ["_helo", "_queue", "_processed"];
_helo = _this select 0;
_processed = [];

if isNull _helo throw "Invalid Argument: must provide object";

_queue = _helo getVariable ["reinforcementQueue", []];

while {_helo emptyPositions "cargo" > 0 && {count _queue > 0}} do {
	{
		if (alive _x) then {
			[_x, _helo] remoteExec ["assignAsCargo", 2];
			[_x, _helo] remoteExec ["moveInCargo", 0];
			if (_x in _helo) then {
				_queue = _queue - [_x];
				_processed pushBack _x;
			};
		} else {
			_queue = _queue - [_x];
			unassignVehicle _x;
		};
	} forEach _queue;
};

_helo setVariable ["reinforcementQueue", _queue];
_processed;
