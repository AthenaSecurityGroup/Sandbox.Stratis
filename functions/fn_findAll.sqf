/*
	
	KK_fnc_findAll
	Searches a multidimensional array for a value.
	Returns the indexes of all values.
	by: Killzone Kid -- http://killzonekid.com/arma-scripting-tutorials-kk_fnc_findall/
	
*/

private ["_fnc","_tmp","_res","_lvl","_def"];
_fnc = {
	{
		if (isNil "_x") then {
			if (!_def) then {
				_tmp set [_lvl,_forEachIndex];
				_res pushBack +_tmp;
			};
		} else {
			if (typeName _x == "ARRAY") then {
				_tmp set [_lvl,_forEachIndex];
				_lvl = _lvl + 1;
				_x call _fnc;
				_tmp resize _lvl;
				_lvl = _lvl - 1;
			} else {
				if (_def) then {
					if (_x isEqualTo _fnd) then {
						_tmp set [_lvl,_forEachIndex];
						_res pushBack +_tmp;
					};
				};
			};
		};
	} forEach _this;
};
_tmp = []; _res = []; _lvl = 0;
_fnd = _this select 1;
_def = !isNil "_fnd";
_this select 0 call _fnc;
_res