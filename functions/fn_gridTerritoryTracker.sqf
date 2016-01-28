/* 

	Grid Territory Tracker Function v1.0
	by: Diffusion9, 2015-12-28
	Input: mapGridPosition, example: 087251
	Colours in a grid location on the map with a coloured marker.
		USAGE:	[(mapGridPosition)] spawn ASG_fnc_gridTerritoryTracker
		0	mapGridPosition (ex: 087251)
		
	Notes:	- mapGridPosition return value is based on getPOS X and Y positions
			- gridPOS: x 10422.22, y 11466.66 is x 104 y 114
			- {(_x select 0) setMarkerAlphaLocal 0} forEach activeGrids; -- to hide the grids
			- {(_x select 0) setMarkerAlphaLocal 1} forEach activeGrids; -- to show the grids
				\\ TO BE INTEGRATED INTO CONTROL PANEL
 */

private ["_gridToAdd", "_centerGridArray" ,"_faction"];

_gridToAdd = _this select 0;	// inc example: 087251
_faction = _this select 1;		// "ASG", "AAF", etc.
switch (_faction) do {
	case "ASG": {_faction = "ColorBLUFOR"};
	case "AAF": {_faction = "ColorOPFOR"};
};

_centerGridArray = [_gridToAdd] call ASG_fnc_gridGetCent;
_gridToAdd = (mapGridPosition _centerGridArray);

deleteMarker _gridToAdd;
_testMarker = createMarker [_gridToAdd,_centerGridArray];
_testMarker setMarkerShape "RECTANGLE";
_testMarker setMarkerSize [50,50];
_testMarker setMarkerColor _faction;