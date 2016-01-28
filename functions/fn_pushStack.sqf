_this select 0 append (_this select 1);
_this select 0

// Example
// arr = [1,2,3];
// [arr,[4,5,6]] call KK_fnc_pushStack; //both arr and function return are [1,2,3,4,5,6]