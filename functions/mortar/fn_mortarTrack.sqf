/*

    ASG_fnc_mortarTrack -- by: Diffusion9 2016-02-19

    INPUT:  0   STRING  Object variable name.
            1   STRING  Trigger variable name.
            2   STRING  Target object variable name.
            3   STRING  Script variable name.
            4   OBJ     Target Object

    To be used as a part of the mortar trigger system; triggers the mortar to 
    track the desired target, begin a diceroll and bracketing shots.

*/

_objVar = _this select 0;
_trgVar = _this select 1;
_tarVar = _this select 2;
_scriptVar = _this select 3;
_target = _this select 4;

if (!alive (missionNamespace getVariable _objVar)) exitWith {
        deleteVehicle (missionNamespace getVariable _trgVar);
    };
if (isNil {(missionNameSpace getVariable _tarVar)}) then {
        missionNamespace setVariable [_tarVar, _target];
    };
missionNameSpace setVariable [_scriptVar, [(missionNameSpace getVariable _tarVar), (missionNameSpace getVariable _objVar)] spawn ASG_fnc_mortarFireCalculator];