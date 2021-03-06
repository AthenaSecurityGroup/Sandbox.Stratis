sleep 0.5;	// Lets the server\client catchup, otherwise BIS_revive_incapacitated checks too early and fails.

///	Handles dead players being kicked from the channel
///	To do: https://github.com/Diffusion9/Sandbox.Stratis/issues/19

if (player getVariable ["BIS_revive_incapacitated", false]) exitWith {
	// Re-applies uniform texture after players die, if they have the right uniform.
	sleep 0.5;
	if (uniform player == "U_BG_Guerrilla_6_1") then {
		diag_log "DEBUG:	Player was downed. Applying uniform:";
		diag_log format ["DEBUG:	%1, %2", player, (uniform player)];
		[player, true] call ASG_fnc_setUniform;
	};
	// Anything < 4 doesn't seem to work?!?!
	sleep 4; // I suppose we could use an event handler here, maybe, but this seems to work for now.
	// Ensures the players are reconnected to the proper radio channel after death.
	diag_log "DEBUG:	Check for Radio Channels:";
	for "_i" from 0 to (count CHANNELS) do {
		if (!isNil {comm_radioControlMenu}) then {
			if ((((comm_radioControlMenu) select _i select 0) splitString " " select 0) == "Disconnect") then {
				_channel = (CHANNELS select (_i - 1) select 0);
				diag_log format ["DEBUG:	%1, %2", _channel, _i];
				[false, _i, _channel] call ASG_fnc_radioControl;
				[true, _i, _channel] call ASG_fnc_radioControl;
			};
		};
	};
	true;
};

cutText ["","BLACK"];

if (simulationEnabled (respawnHelo select 0)) then {
	[(_this select 0), true] call ASG_fnc_logisticsDeathCamera;
	cutText ["","BLACK IN", 20];
};

sleep 4;

// Yes, double code, I know. Eventually I want to rewrite the custom radio
// channels menu to be programmatically generated and more closely tied with, and
// integrated into moses' radio, so this bandaid will suffice for now.
for "_i" from 0 to (count CHANNELS) do {
	if (!isNil {comm_radioControlMenu}) then {
		if ((((comm_radioControlMenu) select _i select 0) splitString " " select 0) == "Disconnect") then {
			_channel = (CHANNELS select (_i - 1) select 0);
			[true, _i, _channel] call ASG_fnc_radioControl;
		};
	};
};