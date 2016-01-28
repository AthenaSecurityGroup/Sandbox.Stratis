/* 
	
	Search for all the "Land_ClutterCutter_small_F" in baseComps.
	Grab the 6th index of each ClutterCutter array. Create an array of the unique
		placeholder box names.
	Remove the placeholder prefix leaving the proper box name.
	Example: PS11 - P = S11 (1-1's squad box).
	This is a programmatic way of getting a list of all the boxes without having to
		exclusively define multiple arrays.
	
 */

_PHBoxArray = [];
_BoxArray = [];
boxHolders = [];
boxNames = [];

_clutterArray = [baseComps, "Land_ClutterCutter_small_F"] call KK_fnc_findAll;
{
	_x set [2, 6];
	_PHBoxArray pushback ([baseComps,_x] call KK_fnc_findAllGetPath);
} forEach _clutterArray;
{
	_xSplit = _x splitString "";
	_xSplit deleteRange [0,3];
	_xJoined = _xSplit joinString "";
	_BoxArray = (_BoxArray - [_xJoined]) + [_xJoined];
} forEach _PHBoxArray;

{
	_posArray = (getPOS (missionNamespace getVariable _x));
	_azimuth = direction (missionNamespace getVariable _x);
	boxHolders pushback [_x,[_posArray, _azimuth]];
} forEach _BoxArray;

/// TO DO:
// Store in mission variable as default value
publicVariable "boxHolders";

// Use globally-defined boxHolders array to get the names of all the boxes.

{
	_box = missionNamespace getVariable _x;
	boxNames pushback _box;
} forEach boxHolders;

boxDefContents = [boxNames] call ASG_fnc_createCargoArray;

/// TO DO:
// Store in mission variable as default value
publicVariable "boxNames";


