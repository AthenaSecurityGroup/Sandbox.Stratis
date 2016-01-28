// Array "unshift" implementation using append, a faster alternative to BIS_fnc_arrayUnShift: 

// Example
// arr = [1,2,3];
// [arr, 0] call KK_fnc_unshift; //both arr and return of function are [0,1,2,3]

private ["_arr", "_tmp"];

_arr = _this select 0;
_tmp = [_this select 1];
_tmp append _arr;
_arr resize 0;
_arr append _tmp;
_arr