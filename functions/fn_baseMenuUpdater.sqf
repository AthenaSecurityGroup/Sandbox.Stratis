/*
	
	ASG_fnc_baseMenuUpdater;
	Assign each Deployment Menu entry to the appropriate player.
	Menus are assigned to each player locally. Whitelist is editable in baseData array.
	
*/

private ["_baseFindAll", "_basePlayerIndex", "_baseVarName"];

_baseFindAll = [baseData, str player] call KK_fnc_FindAll;

if (!(_baseFindAll isEqualTo [])) then {comm_baseDeployMenu = [["Deployment",false]]};
{	
	_basePlayerIndex = _x select 0;
	_baseVarName = format ["base_%1", _basePlayerIndex];
	comm_baseDeployMenu set [(_basePlayerIndex + 1), missionNamespace getVariable _baseVarName];
} forEach _baseFindAll;