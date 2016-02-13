sleep 2;
// Disable Squad Leader \ High Command bar
showHUD [true,true,true,true,true,true,false,true];

#include "scripts\includes\inc_playerSpawnGroups.hpp"

_player = (_this select 0);
_psgIndex = [playerSpawnGroups, (str _player)] call KK_fnc_findAll select 0;
_squadName = [playerSpawnGroups, [(_psgIndex select 0), (count (playerSpawnGroups select (_psgIndex select 0))) - 1]] call KK_fnc_findAllGetPath;
["SetName", [(group (_this select 0)), _squadName]] call ASG_fnc_dynamicGroups;
