/* 

	Map Grid Center Finder
	by: Diffusion9, 2015-12-28
	Calculates the center of a map grid position based on the six-digit map grid from mapGridPosition

*/

private ["_incMapGrid", "_xPushback","_yPushback", "_splitGrid"];

_xPushback = [];
_yPushback = [];

if (count (_this select 0) == 6) then {_incMapGrid = _this select 0;};
if (count (_this select 0) == 2) then {
	_incMapGrid = _this select 0;
	_incMapGrid = (mapGridPosition _incMapGrid);
};

_splitGrid = (_incMapGrid splitString "");
{
	if (_forEachIndex < 3) then {
		_xPushback pushback _x;
	} else {
		_yPushback pushback _x;
	};
} forEach _splitGrid;

_xPushback pushback "50";
_yPushback pushback "50";
_xPushback = _xPushback joinString ""; 	// 08750
_yPushback = _yPushback joinString "";	// 25150

[(parseNumber _xPushback), (parseNumber _yPushback)];

