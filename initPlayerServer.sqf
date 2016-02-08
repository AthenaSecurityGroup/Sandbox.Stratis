sleep 2;
// Disable Squad Leader \ High Command bar
showHUD [true,true,true,true,true,true,false,true];

#include "scripts\includes\inc_playerSpawnGroups.hpp"

_player = (_this select 0);
_isLeader = [playerSpawnGroups, (str _player)] call KK_fnc_findAll;

_squadPath = ([playerSpawnGroups, (str leader group (_this select 0))] call KK_fnc_findAll select 0);
_squadPath set [1,1]; _squadName = [playerSpawnGroups, (_squadPath)] call KK_fnc_findAllGetPath;
["SetName", [(group (_this select 0)), _squadName]] call ASG_fnc_dynamicGroups;
