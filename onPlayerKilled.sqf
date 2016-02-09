if (player getVariable ["BIS_revive_incapacitated", false]) exitWith { true };

cutText ["","BLACK"];

if (simulationEnabled (respawnHelo select 0)) then {
	[(_this select 0), true] call ASG_fnc_logisticsDeathCamera;
	cutText ["","BLACK IN", 30];
};