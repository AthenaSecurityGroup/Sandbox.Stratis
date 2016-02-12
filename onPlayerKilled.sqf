sleep 0.5;	// Lets the server\client catchup, otherwise BIS_revive_incapacitated checks too early and fails.

///	Handles dead players being kicked from the channel
///	To do: https://github.com/Diffusion9/Sandbox.Stratis/issues/19

if (player getVariable ["BIS_revive_incapacitated", false]) exitWith {
	// Anything < 2 doesn't seem to work reliably, oddly enough.
	sleep 2; // I suppose we could use an event handler here, maybe, but this seems to work for now.
	// Ensures the players are reconnected to the proper radio channel after death.
	for "_i" from 0 to (count CHANNELS) do {
		if (!isNil {comm_radioControlMenu}) then {
			if ((((comm_radioControlMenu) select _i select 0) splitString " " select 0) == "Disconnect") then {
				diag_log _i;
				_channel = (CHANNELS select (_i - 1) select 0);
				[true, _i, _channel] call ASG_fnc_radioControl;
			};
		};
	};
	// Re-applies uniform texture after players die, if they have the right uniform.
	if (uniform player == "U_BG_Guerrilla_6_1") then {
		[player, true] call ASG_fnc_setUniform;
	};
	true;
};

cutText ["","BLACK"];

if (simulationEnabled (respawnHelo select 0)) then {
	[(_this select 0), true] call ASG_fnc_logisticsDeathCamera;
	cutText ["","BLACK IN", 20];
};