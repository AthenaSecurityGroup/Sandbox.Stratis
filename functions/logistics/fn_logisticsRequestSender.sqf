/*

	ASG_fnc_LogisticsRequestSender;
	
	Receives a request-type from a commMenu item on the Client.
	Hides the Logistics menu, and broadcasts the hidden menu to all clients.
	Broadcasts the logisticsRequest value to server to activate related PV handler.

*/

_requestID = _this select 0;
_playerID = (owner player);

logisticsRequest = [_requestID, _playerID];
publicVariableServer "logisticsRequest";

// Disable Menu Options
[comm_logisticsMenu, "0"] call ASG_fnc_menuDisableEntries;
publicVariable "comm_logisticsMenu";

diag_log "Logistics request sent...";