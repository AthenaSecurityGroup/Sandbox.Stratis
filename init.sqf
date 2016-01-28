// =================================================================
// PRE-INIT SERVER PARAMS
setViewDistance 2000;
{_x disableTIEquipment true;} forEach (allMissionObjects "All");
{_x disableNVGEquipment true;} forEach (allMissionObjects "All");
enableEngineArtillery false;
enableSaving [false,false];
enableRadio false;
enableSentences false;
oldSubs = showSubtitles false; 
showHUD [true,true,true,true,true,true,false,true];

// =================================================================
// GLOBAL EXECUTION
[] execVM "scripts\outlw_magRepack\MagRepack_init_sv.sqf"; 		// Mag Repack Script -- #Includes in description.ext.
[] execVM "scripts\sand_radio.sqf";								// init MosesUK's sandbox radio.
// [] execVM "VCOMAI\init.sqf";									// Activate VCOM.
[] execVM "scripts\playerNameTags.sqf";							// Name tags over players heads.

// =================================================================
// LOGISTICS

// Sets the seed balance of the bank balance, if not otherwise set.
seedBalance = 500000;

// Custom item categories and buy and sell values,
#include "scripts\includes\inc_logisticsIVTable.hpp"

// Spawn position for the logistics helicopter.
defaultHeloPosition = [8956,27248];

// Disconnected Player Body Cleanup
// Only deletes players body if completely empty.
addMissionEventHandler ["HandleDisconnect",{
	_itemCntArray = [];
	_discObj = _this select 0;
	_uniformItems = uniformItems _discObj;
	if (!(_uniformItems isEqualTo [])) then {_itemCntArray pushBack _uniformItems};
	_backpackItems = backpackContainer _discObj;
	if (!(_backpackItems isEqualTo objNull)) then {_itemCntArray pushBack _backpackItems};
	_vestItems = vestItems _discObj;
	if (!(_vestItems isEqualTo [])) then {_itemCntArray pushBack _vestItems};
	if ((count _itemCntArray) == 0) then {deleteVehicle _discObj};
}];