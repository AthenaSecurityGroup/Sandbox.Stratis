
/* 

	Grid Tracker Function
	by: Diffusion9, 2015-12-25
	Processes an incoming player, checks its grid (or creates new grid status), and outputs it for processing
	adds a percentage index if its a new grid

 */

private ["_unit","_unitObj"];

_unit = _this select 0;
_unitObj = (missionNamespace getVariable [(_unit), objNull]);

if (isPlayer _unitObj) then {
	_curMapGrid =  mapGridPosition _unitObj;
	_activeIndex = [activeGrids, _curMapGrid] call KK_fnc_findAll;
	if (_activeIndex isEqualTo []) then {
		_gridData = [_curMapGrid, serverTime, 1, "ASG", (random 100)];
		activeGrids pushBack _gridData;
		_gridData
	} else {
		_extractedData = [activeGrids, [(([activeGrids, _curMapGrid] call KK_fnc_findAll) select 0) deleteAt 0]] call KK_fnc_findAllGetPath;
		_extractedData
	};
};