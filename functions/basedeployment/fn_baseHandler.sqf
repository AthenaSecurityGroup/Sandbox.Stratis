/*
	
	ASG_fnc_baseHandler
	Function that triggers as part of the Base Deployment "Expression".
	Redefines menus and publicly pushes to be caught by the publicVariable EventHandler.
	
*/

_baseIndex = ((((missionNamespace getVariable (_this select 0)) select 1) select 0) - 2);
_markerName = (baseData select _baseIndex select 4 select 2);
_baseStatus = (baseData select _baseIndex select 0);
private ["_dist"];
if (count _this > 1) then {
	_dist = _this select 1;
} else {
	_dist = ((player distance getmarkerpos _markerName) > 50);
};

///
if ((_baseStatus isEqualTo true) && (_dist)) exitWith {
	hint format ["You are too far away to dismantle %1.", _markerName];
};
(baseData select _baseIndex) set [0, (!((baseData select _baseIndex) select 0))];
[] call ASG_fnc_baseEntryCreator;
[] call ASG_fnc_baseMenuUpdater;
[_baseIndex, ((baseData select _baseIndex) select 0)] call ASG_fnc_baseDeployer;