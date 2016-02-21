/*
	
	ASG_fnc_baseDeployer
	Deploys the base type based on index.
	Boxes are attached to clutterCutters in the base composition
	
*/

private ["_baseIndex","_baseStatus", "_persistDeploy"];

_baseIndex = _this select 0;	// SCALAR 	- 	Index of the base.
_baseStatus = _this select 1;	// BOOL		- 	Deployed, True or False.
_markerName = (baseData select _baseIndex select 4 select 2);
_markerType = (baseData select _baseIndex select 4 select 0);
_markerColor = (baseData select _baseIndex select 4 select 1);
_tarPOS = (getPOS player);
_tarDir = (getDir player);

// Check if there is a third value in the array, which indicates an admin reset or persistence check.
if (count _this > 2) then {
		_persistDeploy = _this select 2;
		_tarPOS = _persistDeploy select 0;
		_tarDir = _persistDeploy select 1;
};

if (_baseStatus) then {
	// Deploy
	_deployedObj = [_tarPOS, _tarDir, (baseComps select _baseIndex)] call ASG_fnc_objectMapper;
	(baseData select _baseIndex) set [3, _deployedObj];
	_cluttArray = [(baseComps select _baseIndex), "Land_ClutterCutter_small_F"] call KK_fnc_findAll;
	{
		_x set [1,6];
		_boxHolder = [(baseComps select _baseIndex), _x] call KK_fnc_findAllGetPath;
	} forEach _cluttArray;
	// Add Base Marker
	_markerVar = createMarker [_markerName,player];
	_markerVar setMarkerType _markerType;
	_markerVar setMarkerColor _markerColor;
	_markerVar setMarkerText _markerName;
	// _markerVar setMarkerDir (_tarDir);
	hint format ["Deploying the %1", (baseData select _baseIndex select 1)];
	// Attach Base Boxes
	[_baseIndex] call ASG_fnc_baseDeployBoxes;
	sleep 5;
	{
		[_x, false] remoteExec ["hideObjectGlobal", 2];
	} forEach _deployedObj;
	
} else {
	// UnDeploy
	// Detach Base Boxes
	[_baseIndex] call ASG_fnc_baseRemoveBoxes;
	{
		deleteVehicle _x;
	} forEach (baseData select _baseIndex select 3);
	hint format ["%1 Dismantled.", (baseData select _baseIndex select 1)];
	// Remove Base Marker
	deleteMarker _markerName;
};

publicVariable "baseData";