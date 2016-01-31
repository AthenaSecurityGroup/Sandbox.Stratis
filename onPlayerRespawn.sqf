if (player getVariable ["BIS_revive_incapacitated", false]) exitWith {
	[[player], "ASG_fnc_setUniform", nil, true, true] call BIS_fnc_MP;
	true;
};

// Equip Player with ASG Equipment
[player] call ASG_fnc_equipPlayer;

// Re-initialize Box Access by MOSES
[player] execVM "scripts\sand_lockBoxes.sqf";

player forceWalk false;
enableSentences false;
enableRadio false;
showHUD [true,true,true,true,true,true,false,true];

[player] call ASG_fnc_logisticsHeloQueuePlayer;