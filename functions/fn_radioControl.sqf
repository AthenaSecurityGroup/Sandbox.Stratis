// Handles adding and removing players from custom radio channels via the Radio Controller

private ["_channelStatus","_channelID","_channelName"];
_channelStatus = _this select 0;
_channelID = _this select 1;
_channelName = _this select 2;

if (_channelStatus) then {
	comm_radioControlMenu select _channelID set [0, ("Disconnect " + _channelName)];
	_command = format ["[%1, %2, '%3'] call ASG_fnc_radioControl;", false, _channelID, _channelName];
	comm_radioControlMenu select _channelID select 4 select 0 set [1, _command];
	[true,_channelName,[player]] call RADIO;
	active_backups pushback [_channelName];
} else {
	comm_radioControlMenu select _channelID set [0, ("Connect " + _channelName)];
	_command = format ["[%1, %2, '%3'] call ASG_fnc_radioControl;", true, _channelID, _channelName];
	comm_radioControlMenu select _channelID select 4 select 0 set [1, _command];
	[false,_channelName,[player]] call RADIO;
	active_backups = (active_backups - [[_channelName]]);
};