/*

	ASG_fnc_baseEntryCreator
	Reads a multidimensional array with definitions for base deployment menu entries.
	Formats each array index item to the appropriate submenu item.
	
*/


private ["_baseVarName","_baseDeployment", "_baseMenuName", "_baseMenuKey", "_baseExpression", "_baseArr"];

{
	_baseVarName = format ["base_%1", _forEachIndex];
	if (_x select 0) then {_baseDeployment = "Pack Up"} else {_baseDeployment = "Deploy"};
	_baseMenuName = format ["%1 %2", _baseDeployment, (_x select 1)];
	_baseMenuKey = _forEachIndex + 2;
	_baseExpression = format ["[%1] spawn ASG_fnc_baseHandler;", (str _baseVarName)];
	_baseArr = [
		_baseMenuName,
		[_baseMenuKey],
		"",
		-5,
		[["expression", _baseExpression]],
		"1",
		"1"
	];
	missionNamespace setVariable [_baseVarName,_baseArr];
} forEach baseData;