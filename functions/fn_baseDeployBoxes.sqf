/*
	
	ASG_fnc_baseDeployBoxes
	Deploys squad boxes to the defined base in ASG_fnc_baseDeployBoxes.
	Squad boxes are attached to named grasscutters defined in inc_baseComps.hpp.
	
*/

private ["_baseIndex", "_cutterList", "_boxAnchor", "_boxStr", "_boxStrSpl", "_boxJoined", "_boxObj", "_activeBoxes"];

_baseIndex = _this select 0;
_cutterList = [(baseComps select _baseIndex), "Land_ClutterCutter_small_F"] call KK_fnc_FindAll;
_activeBoxes = [];

{
	_x set [1, 6];
	_boxAnchor = [(baseComps select _baseIndex), _x] call KK_fnc_FindAllGetPath;
	_boxStr = _boxAnchor;
	_boxStrSpl = (_boxStr splitString "");
	_boxStrSpl deleteRange [0, 3];
	_boxJoined = (_boxStrSpl joinString "");
	_boxObj = (missionNamespace getVariable [_boxJoined, objNull]);
	_currentAttach = (attachedTo _boxObj);
	if ((isNull _currentAttach)) then {
		_boxObj attachTo [(missionNamespace getVariable [_boxAnchor, objNull]), [0,0,0.8]];
		_activeBoxes pushBack _boxObj;
		(baseData select _baseIndex) set [6, _activeBoxes];
	};
	_baseDataIndex = (([baseData, _boxObj] call KK_fnc_FindAll) select 0 select 0);
	if (_baseDataIndex >= _baseIndex) then {
		_boxObj attachTo [(missionNamespace getVariable [_boxAnchor, objNull]), [0,0,0.8]];
		_activeBoxes pushBack _boxObj;
		(baseData select _baseIndex) set [6, _activeBoxes];
	};
} forEach _cutterList;
publicVariable "baseData";

if ((_baseIndex < 7) && (baseFollowTerrain)) then {
	{_x setVectorUp (surfaceNormal position _x)} forEach (baseData select _baseIndex select 3);
};