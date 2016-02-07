sleep 0.5;	// Lets the server\client catchup, otherwise BIS_revive_incapacitated checks too early and fails.

if (player getVariable ["BIS_revive_incapacitated", false]) exitWith { true };

cutText ["","BLACK"];

if (simulationEnabled (respawnHelo select 0)) then {
	[(_this select 0), true] call ASG_fnc_logisticsDeathCamera;
	cutText ["","BLACK IN", 30];
};