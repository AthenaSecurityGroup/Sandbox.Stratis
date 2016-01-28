//////////////////////////////////////////////////////////////////////////////////////////////////////
///// 	EARPLUG CONTROL
///// 		Adds a Toggle Earplug controller to the supports menu for all players.
///// 		Allows players to insert earplugs to reduce ambient volume.
/////

earPlugIn = false;
[player,"earplugToggle",nil,nil,""] call BIS_fnc_addCommMenuItem;

/////
//////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////
///// 	RADIO CONTROL
///// 		Adds a radio controller to the supports menu for whitelisted players.
///// 		Allows players to connect or disconnect from special channels.
/////

_rcWhitelist = ["A11","A11A","A11B","A12","A12A","A12B","A13","A13A","A13B",
"A21","A21A","A21B","A22","A22A","A22B","A23","A23A","A23B",
"A31","A31A","A31B","A32","A32A","A32B","A33","A33A","A33B",
"PL1","PS1","RO1","CM1","PL2","PS2","RO2","CM2","PL3","PS3","RO3","CM3",
"RO6","HP1","HP2","HP3","WSL","ASL","OPS","CM6","HQ6","HQ4","HQ5"];
if (toUpper str player in _rcWhiteList) then {
// Programmatically define each Radio Control submenu entry, based on the existing Radio channels.
active_backups = [];
comm_radioControlMenu = [["Radio Control",false]];
_existingChannelIDs = [CHANNEL_DATA, (toUpper str player)] call KK_fnc_FindAll;
_existingChannelNames = [];
private ["_existingChannelNames"];
{
	_existingChannelNames pushback (([CHANNELS,[(_x select 0)]] call KK_fnc_FindAllGetPath) select 0);
} forEach _existingChannelIDs;

{
	_channelStatus = "Connect " + (_x select 0); // "Platoon 1"
	_channelIndex = _forEachIndex + 1; // "1"
	_channelHotKey = _channelIndex + 1; // "2"
	_callRadio = format ["[%1, %2, ""%3""] call ASG_fnc_radioControl;", true, _channelIndex, (_x select 0)];
	if ((_x select 0) in _existingChannelNames) then {
		_channelStatus = "Disconnect " + (_x select 0);
		_callRadio = format ["[%1, %2, ""%3""] call ASG_fnc_radioControl;", false, _channelIndex, (_x select 0)];
		active_backups pushback [(_x select 0)];
	};
	_channelDefine = [_channelStatus, [_channelHotKey], "", -5, [["expression", _callRadio]], "1", "1", ""];
	comm_radioControlMenu set [_channelIndex, _channelDefine];
} forEach CHANNELS;

// Finally, add the commMenu item to the player.
comm_addRadioControl = [player,"radioControl",nil,nil,""] call BIS_fnc_addCommMenuItem;
};

/////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
///// 	BASE DEPLOYMENT CONTROL
///// 		Adds a Deployment entry to the Supports Menu for whitelisted players.
///// 		Allows deployment of a variety of base types depending on the source player.
/////		Deployable bases must be defined here, and functions/inc_baseComps.hpp in the same index.
/////

// Functions which define and set the Base Deployment menu for whitelisted players.
[] call ASG_fnc_baseEntryCreator;
[] call ASG_fnc_baseMenuUpdater;

// PublicVariable that spawns the baseMenuUpdater when comm_baseDeployMenu is PV'd.
"baseData" addPublicVariableEventHandler {
	[] call ASG_fnc_baseEntryCreator;
	[] call ASG_fnc_baseMenuUpdater;
};

// Add the commMenu item to the player.
comm_addBaseDeployment = [player,"baseDeploy",nil,nil,""] call BIS_fnc_addCommMenuItem;

/////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
///// 	LOGISTICS CONTROL
/////
/////

if ((str player) in (baseData select 4 select 2)) then {
	
	comm_logisticsMenu =
	[
		["Logistics Request",false],
		["Platoon Ammo Package", [2], "", -5, [["expression", "[1] call ASG_fnc_logisticsRequestSender;"]], "1", "1"],
		["Squad Gear Package", [3], "", -5, [["expression", "[2] call ASG_fnc_logisticsRequestSender;"]], "1", "1"],
		["Deliver Offroad", [4], "", -5, [["expression", "[3] call ASG_fnc_logisticsRequestSender;"]], "1", "1"]
	];
	
	// Finally, add the commMenu to the appropriate players
	comm_addLogistics = [player,"logistics",nil,nil,""] call BIS_fnc_addCommMenuItem;
};

/////
//////////////////////////////////////////////////////////////////////////////////////////////////////

