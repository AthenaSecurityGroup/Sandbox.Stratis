/*
    Author: Moses
    Description:
    Allows for creating allowed access lists for storage objects, using object name.
    Parameter:
    ARRAY - Used for setting up access:
            0: Object to add limitations to. STRING (Editor name) or OBJECT (Object reference).
            1: List of unit names to limit to. STRINGS (Editor names) or OBJECTS (Object references).
    OR
    OBJECT - Will return true or false if the player has access to the object.
    Returns:
    SCALAR - True if setup successful. False if not.
    OR
    BOOL - True if access is allowed. False if not.
    Examples:
    
    //To setup access
    ["BOX1",["myUnitName1",unit2]] call accessInfo;
    //To check access allowed
    if ("BOX1" call accessInfo) then {
        hint "You can access 'BOX1'"
    };
    //or perhaps
    if (cursorTarget call accessInfo) then [{
        hint "You can access this"
    },{
        hint "You cannot access this"
    }];
    //for inventory access limitations
    player addEventHandler ["InventoryOpened",{_this select 1 call accessInfo}];
*/

if (typeName _this == "ARRAY") exitWith {
    params [
        ["_object","",[objNull,""]],
        ["_allowed",[],[[]]]
    ];

    if (_object isEqualTo "") exitWith {false};
    if (_allowed isEqualTo []) exitWith {false};
    if (typeName _object == "STRING") then {
        _object = missionNamespace getVariable [_object,objNull];
    };
    if (isNull _object) exitWith {false};

    _object setVariable ["#MOSES#AccessAllowed",_allowed,isServer];
    true
};

if (typeName _this != "OBJECT") exitWith {
    ["Improper use of function. Expected object(OBJECT) OR array(ARRAY), provided %1(%2)",_this,typeName _this] call BIS_fnc_error;
    true
};

if (isNil {_this getVariable "#MOSES#AccessAllowed"}) exitWith {
    true
};

if (typeName _this == "STRING") then {
    _this = missionNamespace getVariable [_this,objNull];
};
(str player in (_this getVariable ["#MOSES#AccessAllowed",[]]) || {player in (_this getVariable ["#MOSES#AccessAllowed",[]])})	
