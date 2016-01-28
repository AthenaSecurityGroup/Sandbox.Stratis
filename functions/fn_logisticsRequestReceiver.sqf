/*

	ASG_fnc_logisticsRequestReceiver;
	
	After being detected by the PV handler, sorts the type received and reacts appropriately.

*/

_requestType = _this select 0 select 0;
_playerID = _this select 0 select 1;

diag_log "Logistics request received";

switch (_requestType) do {
    case 1: {
		[_playerID, 1] spawn ASG_fnc_logisticsResponder;
	};
    case 2: {
		[_playerID, 2] spawn ASG_fnc_logisticsResponder;
	};
	case 3: {
		[_playerID, 3] spawn ASG_fnc_logisticsResponder;
	};
    default {
		diag_log "Error with logistics request variable.";
	};
};