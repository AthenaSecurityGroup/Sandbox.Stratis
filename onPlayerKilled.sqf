sleep 0.5;	// Lets the server\client catchup, otherwise BIS_revive_incapacitated checks too early and fails.

if (player getVariable ["BIS_revive_incapacitated", false]) exitWith { true };

cutText ["Awaiting Deployment.","BLACK"];

// [[(_this select 0)], "ASG_fnc_setUniform", nil, true, true] call BIS_fnc_MP;					// Set uniform, broadcast to all clients.