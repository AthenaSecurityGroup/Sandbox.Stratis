if (player getVariable ["BIS_revive_incapacitated", false]) exitWith {true};

// Re-initialize Box Access by MOSES
[player] execVM "scripts\sand_lockBoxes.sqf";

player forceWalk false;
enableSentences false;
enableRadio false;
showHUD [true,true,true,true,true,true,false,true];

[player] call ASG_fnc_logisticsHeloQueuePlayer;