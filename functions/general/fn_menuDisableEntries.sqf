
// ASG_fnc_menuDisableEntries

_menu = _this select 0;				//	ARRAY	Menu Data Variable
_status =_this select 1;			//	STRING	1 - Enabled, 0 Dimmed

{
	if (_forEachIndex > 0) then {
		_x set [6, _status];
	};
} forEach _menu;