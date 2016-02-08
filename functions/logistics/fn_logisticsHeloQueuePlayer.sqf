/*
	Authors: Diffusion9 and jmlane

	Description:
	Queue unit for reinforcement via logistical helo.

	Parameter(s):
		0: OBJECT - unit to queue for reinforcement
		1 (Optional): OBJECT - helo unit (default: PV respawnHelo unit reference)

	Returns:
	ARRAY of function handlers
*/
private ["_unit", "_helo", "_loadInHelo", "_fadeIn"];

_unit = param [0, objNull];
_helo = param [1, respawnHelo select 0]; // TODO: Remove global variable.

if isNull _unit throw "Invalid Argument: _unit must be valid object";

diag_log format ["logisticsHeloQueuePlayer: _unit = %1, _helo = %2", _unit, _helo];

[_unit, true] remoteExec ["hideObjectGlobal", 2];
[_unit, false] remoteExec ["enableSimulationGlobal", 2];

_queueForHelo = [_unit] spawn {
	_unit = _this select 0;
	ASG_logisticsHeloQueue_Add = _unit;
	publicVariableServer "ASG_logisticsHeloQueue_Add";
};

_fadeIn = [_unit, _helo] spawn {
	_unit = _this select 0;
	_helo = _this select 1;

	waitUntil {
		sleep 2;
		simulationEnabled _helo && _unit in _helo;
	};

	cutText ["","BLACK IN", 30];
	[_unit, false] call ASG_fnc_logisticsDeathCamera;
	// Get the player's real (not in-game) rank via Insignia display name;
	_rankName = format ["%1 %2", getText ((missionconfigfile >> "CfgUnitInsignia" >> (player call BIS_fnc_getUnitInsignia)) select 0), name player];
	_respawnText = format ["%1, %2", (getPos respawnIsland) call BIS_fnc_locationDescription, worldName];

	[
		[_rankName, "font = 'PuristaMedium'"], ["", "<br/>"],
		[_respawnText,"size = '0.6'"]
	] spawn {
		private ["_text"];
		_text = _this;
		
		// Compile date
		private ["_month", "_day", "_hour", "_minute"];
		_month = str (date select 1);
		_day = str (date select 2);
		_hour = str (date select 3);
		_minute = str (date select 4);
		
		if (date select 1 < 10) then {_month = format ["0%1", str (date select 1)]};
		if (date select 2 < 10) then {_day = format ["0%1", str (date select 2)]};
		if (date select 3 < 10) then {_hour = format ["0%1", str (date select 3)]};
		if (date select 4 < 10) then {_minute = format ["0%1", str (date select 4)]};
		
		private ["_time", "_date"];
		_time = format ["%1:%2", _hour, _minute];
		_date = format ["%1-%2-%3", str (date select 0), _month, _day];
		
		// Compile SITREP
		private ["_SITREP"];
		_SITREP = [
			[_date + " ", ""],
			[_time, "font = 'PuristaMedium'"]
		];
		
		if (count _text > 0) then {
			_SITREP = _SITREP + [["", "<br/>"]];
			{_SITREP = _SITREP + [_x]} forEach _text;
		};
		
		// Display SITREP
		[
			_SITREP,
			safeZoneX - 0.01,
			safeZoneY + (1 - 0.125) * safeZoneH,
			true,
			"<t align = 'right' size = '1.0' font = 'PuristaLight'>%1</t>"
		] spawn BIS_fnc_typeText2;
	};
};

[_queueForHelo, _fadeIn];
