/*
	
	ASG_fnc_baseRemoveBoxes
	Removes the boxes from the packed-up base.
	Returns them to a defined a fallback position.
	
*/

private ["_baseIndex", "_cutterList", "_fallbackBases", "_boxAnchor", "_boxStr", "_boxStrSpl", "_boxJoined", "_boxObj", "_currentAttach"];

_baseIndex = _this select 0;
_cutterList = [(baseComps select _baseIndex), "Land_ClutterCutter_small_F"] call KK_fnc_FindAll;
_fallbackBases = (baseData select _baseIndex select 5);
_fallBackAnchors = [];

private ["_fallbackBase","_fallbackBaseContents", "_fallbackBaseHolders", "_fallBackAnchors"];
{
	if (baseData select _x select 0) exitWith {
		_fallbackBase = _x;
		_fallbackBaseContents = (baseComps select _x);
		_fallbackBaseHolders = ([_fallbackBaseContents, "Land_ClutterCutter_small_F"] call KK_fnc_FindAll);
		{
			_x set [1,6];
			_fa = [_fallbackBaseContents, _x] call KK_fnc_FindAllGetPath;
			_fallBackAnchors pushback _fa;
		} forEach _fallbackBaseHolders;
	};
} forEach _fallbackBases;
_fallbackPrefix = _fallBackAnchors select 0;
if (_fallBackAnchors isEqualTo []) then {_fallbackPrefix = ""};
_fallbackSplit = (_fallbackPrefix splitstring "");
if ((count _fallbackSplit) > 0) then {
	_fallbackSplit deleteRange [3,3];
	_fallbackPrefix = (_fallbackSplit joinstring "");
} else {
	_fallbackPrefix = "";
};
{
	_x set [1, 6];
	_boxAnchor = [(baseComps select _baseIndex), _x] call KK_fnc_FindAllGetPath;
	_boxStr = _boxAnchor;
	_boxStrSpl = (_boxStr splitString "");
	_boxStrSpl deleteRange [0, 3];
	_boxJoined = (_boxStrSpl joinString "");
	_boxObj = (missionNamespace getVariable [_boxJoined, objNull]);
	_currentAttach = (attachedTo _boxObj);
	_attachTarget = ([_fallbackPrefix, (str _boxObj)] joinString "");
	
	if (_fallbackPrefix == "") then {
		if (_boxAnchor == (str _currentAttach)) then {
			detach _boxObj;
			_boxObj setPOS (([boxHolders,[(([boxHolders, (str _boxObj)] call KK_fnc_findAll select 0) select 0)]] call KK_fnc_findAllGetPath select 1) select 0);
			_boxObj setDir (([boxHolders,[(([boxHolders, (str _boxObj)] call KK_fnc_findAll select 0) select 0)]] call KK_fnc_findAllGetPath select 1) select 1);
		};
	} else {
		if (_boxAnchor == (str _currentAttach)) then {
			detach _boxObj;
			_boxObj attachTo [(missionNamespace getVariable [_attachTarget, objNull]), [0,0,0.8]];
		};
	};
} forEach _cutterList;