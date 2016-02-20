// Spawn player at the correct position
[player] call ASG_fnc_playerSpawn;

// Dynamic Groups, registers the player group
#include "scripts\includes\inc_playerSpawnGroups.hpp"
["InitializePlayer", [player, true]] call ASG_fnc_dynamicGroups;

sleep 1;

// Init cfgCommunicationsMenu Items
[] execVM "scripts\commMenu_init.sqf";

sleep 1;

// Box Access by MOSES
[player] execVM "scripts\sand_lockBoxes.sqf";

// Disable Squad Leader \ High Command bar
{_x disableTIEquipment true;} forEach (allMissionObjects "All");
{_x disableNVGEquipment true;} forEach (allMissionObjects "All");
enableEngineArtillery false;
enableSaving [false,false];
enableRadio false;
enableSentences false;
showSubtitles false; 
showHUD [true,true,true,true,true,true,false,true];

// ASG Handbook by DEL-J
[] execVM "scripts\handbook.sqf";

// MOSES' MortarHandler
player addEventHandler ["HandleDamage",{
	if (vehicle player isKindOf "StaticMortar" && {_this select 0 == player && _this select 1 == "" && isNull(_this select 3) && _this select 4 == "" && _this select 5 == -1}) then {
		if (vehicle player getVariable ["#MOSES#HandleDamage",-1] isEqualTo -1) then {
			vehicle player setVariable ["#MOSES#HandleDamage",vehicle player addEventHandler ["HandleDamage",{
				if (_this select 0 == vehicle player && {_this select 1 == "" && isNull(_this select 3) && _this select 4 == "" && _this select 5 == -1}) then {
					damage vehicle player
				};
			}]];
		};
		damage player
	};
}];

// Watch for ASG Uniform Grab
player addEventHandler ["Take", {
	_uniformType = _this select 2;
	if (_uniformType == "U_BG_Guerrilla_6_1") then {
		[player, true] call ASG_fnc_setUniform;
	};
}];

// Handle enemy mortars deployed by Zeus
//  Forces them into custom firing patterns.
handleMortar = Zeus addEventHandler ["CuratorObjectPlaced", {
	_obj = _this select 1;
	0 = [_obj] spawn {
		_obj = _this select 0;
		if ((typeOf _obj) == "O_Mortar_01_F" || (typeOf _obj) == "I_Mortar_01_F") then {
            (group _obj) setGroupOwner 2;
			_posVar = round floor (getPOS _obj select 0);	// 2069
			_objVar = format ["m_%1", _posVar];	// M_2069
			_trgVar = format ["%1_trigger", _objVar];	// M_2069_trigger
			_tarVar = format ["%1_target", _objVar];	// M_2069_target
			missionNamespace setVariable [_objVar, _obj, true];	// Public broadcast
			mortarTriggerTracker = _objVar;	// Pass to eventhandler in init.sqf
			publicVariableServer "mortarTriggerTracker";
			waitUntil {!isNil _trgVar};
			diag_log format ["MORTAR:	handleMortar on Zeus has completed."];
		};
	};
}];