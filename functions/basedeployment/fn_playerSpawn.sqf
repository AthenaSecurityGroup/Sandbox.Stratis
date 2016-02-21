/*
	
	ASG_fnc_playerSpawn
	Moves the player to the appropriate deployed base when spawned.
	
*/

_tableIndex = [playerSpawnTable, (str Player)] call KK_fnc_findAll;

{	
	_basePresence = _x select 0;
	if ((baseData select _basePresence select 0) && (east CountSide ((getMarkerPos (baseData select _basePresence select 4 select 2)) nearEntities 75) == 0)) exitWith {
		player setPOS getMarkerPos (baseData select _basePresence select 4 select 2);
	};
} forEach _tableIndex;