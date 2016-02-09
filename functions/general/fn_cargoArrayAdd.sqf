// fn_cargoArrayAdd
// Adds cargo from a two-array multinest.

_freightContents = _this select 0;
_target = _this select 1;

{
	_boxName = (_x select 0);
	_weps = _x select 1;
	_wepsCount = _x select 2;
	_mags = _x select 3;
	_magsCount = _x select 4;
	_itemss = _x select 5;
	_itemsCount = _x select 6;
	_backpacks = _x select 7;
	_backpacksCount = _x select 8;
	{
		_target addWeaponCargoGlobal[_x,_wepsCount select _forEachIndex];
	} forEach _weps;
	{
		_target addMagazineCargoGlobal[_x,_magsCount select _forEachIndex];
	} forEach _mags;
	{
		_target addItemCargoGlobal[_x,_itemsCount select _forEachIndex];
	} forEach _itemss;
	{
		_target addBackpackCargoGlobal[_x,_backpacksCount select _forEachIndex];
	} forEach _backpacks;		
} forEach _freightContents;