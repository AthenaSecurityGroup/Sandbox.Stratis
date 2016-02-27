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
		_detectSide = "GUER D";
	};
	case "CSAT": {
		_mortarType = "O_Mortar_01_F";
		_mortarSide = EAST;
		_detectSide = "EAST D";
	};
	case "MILITIA": {
		_mortarType = "O_G_Mortar_01_F";
		_mortarSide = EAST ;
		_detectSide = "EAST D";
	};
	default {
		diag_log "MORTAR:	Faction improperly defined.";
		terminate _thisScript;
	};
};

// Generate variable names for use later.
_mortarVarStr = format ["m_%1", round floor (_mortarPOS select 0)];
_mortarTrgStr = format ["%1_trigger", _mortarVarStr];
_mortarSpotStr = format ["%1_spotArea", _mortarVarStr];

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
if (_mortarSide == EAST) then {
	(missionNameSpace getVariable _mortarTrgStr) setTriggerActivation ["WEST", "EAST D", true];
} else {
	(missionNameSpace getVariable _mortarTrgStr) setTriggerActivation ["WEST", "GUER D", true];
};
(missionNameSpace getVariable _mortarTrgStr) setTriggerStatements ["this", "
	_target = (thisList select 0);
	_mortar = (((getPOS thisTrigger) nearEntities ['StaticMortar', 1]) select 0);
	_mortarVarStr = (str (group _mortar) splitString 'R ' select 0);
	_mortarScriptName = format ['%1_trackScript', _mortarVarStr];
	if (isNil {_mortar}) exitWith {
		terminate (missionNamespace getVariable _mortarScriptName);
		missionNameSpace setVariable [_mortarScriptName, nil];
		missionNameSpace setVariable [(format ['%1_target', _mortarVarStr]), nil];
		deleteVehicle thisTrigger;
		diag_log format ['MORTAR:	Mortar is dead. Terminating.'];
	};
	missionNameSpace setVariable [_mortarScriptName, [_target, _mortar] spawn ASG_fnc_mortarFireLogic];
	missionNameSpace setVariable [(format ['%1_target', _mortarVarStr]), _target];
	diag_log format ['MORTAR:	A target is present for %1', _mortarVarStr];
	if (!alive _mortar) then {
		terminate (missionNamespace getVariable _mortarScriptName);
		missionNameSpace setVariable [_mortarScriptName, nil];
		missionNameSpace setVariable [(format ['%1_target', _mortarVarStr]), nil];
		deleteVehicle thisTrigger;
		diag_log format ['MORTAR:	Mortar is dead. Terminating.'];
	};
", "
	_mortar = (((getPOS thisTrigger) nearEntities ['StaticMortar', 1]) select 0);
	_mortarVarStr = (str (group _mortar) splitString 'R ' select 0);
	_mortarScriptName = format ['%1_trackScript', _mortarVarStr];
	terminate (missionNamespace getVariable _mortarScriptName);
	missionNameSpace setVariable [_mortarScriptName, nil];
	missionNameSpace setVariable [(format ['%1_target', _mortarVarStr]), nil];
	diag_log format ['MORTAR:	Targets left area. %1 terminating.', _mortarVarStr];
	if (!alive _mortar) then {
		deleteVehicle thisTrigger;
	};
"];

sleep 0.5;

// Equip Militia Mortar Special Case
// TODO:	Update fn_loadoutInitO (or similar) to accept a second param to override typeOf _obj
//			and force a specific soldier loadout. Like: [_obj, "O_soldierU_F"] call ASG_fnc_loadoutInitO;
//			or something.

if (_mortarType == "O_G_Mortar_01_F") then {
	removeUniform ((missionNamespace getVariable _mortarVarStr) select 1 select 0);
	removeVest ((missionNamespace getVariable _mortarVarStr) select 1 select 0);
	((missionNamespace getVariable _mortarVarStr) select 1 select 0) forceAddUniform "U_I_G_Story_Protagonist_F";
	((missionNamespace getVariable _mortarVarStr) select 1 select 0) addVest "V_Chestrig_khk";
	removeHeadgear ((missionNamespace getVariable _mortarVarStr) select 1 select 0);
};