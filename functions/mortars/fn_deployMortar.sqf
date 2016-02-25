/*
	ASG_fnc_deployMortar
	0 -		Position 	Standard getPOS array
	1 -		Faction		AAF, CSAT, Militia (case insensitive)
	
	USAGE: 	Deploys mortars and configures them for a custom firing pattern.
			Can define custom factions.
*/

// Mortar skill defines.
_mortarRad = 1000;	// The trigger radius for the mortar to detect targets.

private ["_mortarPOS", "_faction"];
_mortarPOS = _this select 0;
_faction = toUpper (_this select 1);

// Check for faction defines.
private ["_mortarType", "_mortarSide"];
switch (_faction) do {
	case "AAF": {
		_mortarType = "I_Mortar_01_F";
		_mortarSide = Independent;
	};
	case "CSAT": {
		_mortarType = "O_Mortar_01_F";
		_mortarSide = EAST;
	};
	case "MILITIA": {
		_mortarType = "O_G_Mortar_01_F";
		_mortarSide = Independent ;
	};
	default {
		diag_log "MORTAR:	Faction improperly defined.";
		terminate _thisScript;
	};
};

// Generate variable names for use later.
_mortarVarStr = format ["m_%1", round floor (_mortarPOS select 0)];
_mortarTrgStr = format ["%1_trigger", _mortarVarStr];

// Create mortar, and add to Zeus.
diag_log format ["MORTAR:	%1 was deployed.", _mortarVarStr];
missionNameSpace setVariable [_mortarVarStr, [_mortarPOS, 0 , _mortarType, _mortarSide] call BIS_fnc_spawnVehicle];
((missionNamespace getVariable _mortarVarStr) select 2) setGroupId [_mortarVarStr];
Zeus addCuratorEditableObjects [[(missionNameSpace getVariable _mortarVarStr) select 0], true];

// Create tracking triggers and attachTo mortar object.
missionNamespace setVariable [
	_mortarTrgStr,
	createTrigger [
		"EmptyDetector",
		(getPOS ((missionNamespace getVariable _mortarVarStr) select 1 select 0))
	]
];
(missionNameSpace getVariable _mortarTrgStr) attachTo [((missionNamespace getVariable _mortarVarStr) select 0)];
(missionNameSpace getVariable _mortarTrgStr) setTriggerArea [_mortarRad, _mortarRad, 0, false];
(missionNameSpace getVariable _mortarTrgStr) setTriggerActivation ["WEST", "PRESENT", true];
(missionNameSpace getVariable _mortarTrgStr) setTriggerStatements ["this", "
	diag_log 'MORTAR:	Target entered area.';
	_target = (thisList select 0);
	_mortar = (((getPOS thisTrigger) nearEntities ['StaticMortar', 1]) select 0);
	_mortarVarStr = (str (group _mortar) splitString 'R ' select 0);
	_mortarScriptName = format ['%1_script', _mortarVarStr];
	missionNameSpace setVariable [_mortarScriptName, [_target, _mortar] spawn ASG_fnc_mortarFireLogic];
", "
	diag_log 'MORTAR:	Target left area. Ceasing fire';
	_mortar = (((getPOS thisTrigger) nearEntities ['StaticMortar', 1]) select 0);
	_mortarVarStr = (str (group _mortar) splitString 'R ' select 0);
	_mortarScriptName = format ['%1_script', _mortarVarStr];
	terminate (missionNamespace getVariable _mortarScriptName);
	missionNameSpace setVariable [_mortarScriptName, nil];
"];

terminate _thisScript;