// Spawn player at the correct position
[player] call ASG_fnc_playerSpawn;

// Dynamic Groups, registers the player group
#include "scripts\includes\inc_playerSpawnGroups.hpp"
["InitializePlayer", [player, true]] call ASG_fnc_dynamicGroups;

if (isServer) then {
	if (isNil {([playerSpawnGroups, (str player)] call KK_fnc_findAll select 0)}) exitWith {true};
	_squadPath = ([playerSpawnGroups, (str leader group (_this select 0))] call KK_fnc_findAll select 0); _squadPath set [1,1]; _squadName = [playerSpawnGroups, (_squadPath)] call KK_fnc_findAllGetPath;
	["SetName", [(group player), _squadName]] call ASG_fnc_dynamicGroups;
};

sleep 1;

// Init cfgCommunicationsMenu Items
[] execVM "scripts\commMenu_init.sqf";

// Equip Player with ASG Equipment
[player] call ASG_fnc_equipPlayer;

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
		[player] call ASG_fnc_setUniform;
	};
}];