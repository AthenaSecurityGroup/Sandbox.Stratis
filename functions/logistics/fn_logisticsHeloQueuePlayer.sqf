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

_queueForHelo = [_unit, _helo] spawn {
	_unit = _this select 0;
	_helo = _this select 1;
	private "_queue";

	_queue = _helo getVariable ["reinforcementQueue", []];
	_queue = (_queue - [_unit]) + [_unit]; // TODO: use pushBackUnique in 1.55+
	_helo setVariable ["reinforcementQueue", _queue, true];
	diag_log format ["logisticsHeloQueuePlayer: _helo.reinforcementQueue = %1", _queue];

	reinforcementEvent = true;
	publicVariableServer "reinforcementEvent";
	diag_log format ["logisticsHeloQueuePlayer: reinforcementEvent has been PV'd"];
};

_fadeIn = [_unit, _helo] spawn {
	_unit = _this select 0;
	_helo = _this select 1;

	waitUntil {
		sleep 2;
		simulationEnabled _helo && _unit in _helo;
	};

	cutText ["","BLACK IN", 30];
	// Get the player's real (not in-game) rank via Insignia display name;
	_rankName = format ["%1 %2", getText ((missionconfigfile >> "CfgUnitInsignia" >> (_unit call BIS_fnc_getUnitInsignia)) select 0), name _unit];
	_groupName = format ["Reinforcing %1", group _unit];
	_respawnText = format ["Northern %1", worldName];
	[
		[
			[_rankName, "<t align = 'center' shadow = '1' size = '1.1' font='PuristaBold'>%1</t><br/>", 10],
			[_groupName, "<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>", 5],
			[_respawnText, "<t align = 'center' shadow = '1' size = '0.5'>%1</t>", 50]
		]
	] spawn BIS_fnc_typeText;
};

[_queueForHelo, _fadeIn];
