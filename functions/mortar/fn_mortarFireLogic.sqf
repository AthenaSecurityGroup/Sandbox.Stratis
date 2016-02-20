/*

	ASG_fnc_mortarFireLogic
	
	Receives two objects; a target, and a mortar.
	This function contains the logic for handling the mortars.
	
	INPUT:
		0	OBJ	Target for the mortar to track.
		1	OBJ	The mortar that tracks the target.

*/

_mortarTar = _this select 0;	// The mortar's target.
_mortarObj = _this select 1;	// The mortar itself.

diag_log format ["MORTAR:	%1 has started.", _thisScript];
diag_log format ["MORTAR:	Incoming Items: %1", _this];
diag_log format ["MORTAR:	Target: %1", _mortarTar];
diag_log format ["MORTAR:	Mortar: %1", _mortarObj];

// MORTAR DEFAULT VALUES
_mortarChance = 75;			//	Chance to trigger mortar engagement. (75 = 25%). 85
_mortarDiceInt = 60;			//	Time between dice rolls after failing a dice roll. 15
_mortarLoiterDist = 75;		//	How far the target must be from its last position to avoid zeroing.
_mortarBrackPOS = [0,0];	//	Default initial value for target bracketing.
_mortarBrackRnds = 1;		//	How many shells dropped per bracket shot.
_strikeCounter = 0;			//	How many times the mortar has fired.

scopeName "mainLoop";
waitUntil {
	if (!alive _mortarObj) exitWith {
		diag_log "MORTAR:	Mortar destroyed. Terminating.";
		terminate _thisScript;
		true;
	};	
	_diceRoll = round (random 100);
	diag_log format ["MORTAR:	Dice Roll: %1", _diceRoll];
	if (_diceRoll > _mortarChance) then {
		_strikeCounter = _strikeCounter + 1;
		private ['_adjustmentX', '_adjustmentY', '_barrage'];
		switch _strikeCounter do {
			case 1 ;
			case 2 ; 
			case 3 : {
				_adjustmentX = round random [-200, 50 , 200];
				_adjustmentY = round random [-200, -50 , 200];
				_barrage = false;
			};
			case 4 : {
				_adjustmentX = round random [-75, -50 , 130];
				_adjustmentY = round random [-75, 50 , 130];
				_barrage = false;
			};
			case 5 : {
				_barrage = true;
				_strikeCounter = 0;
			};
			case default {
				_adjustmentX = round random [-85, 0 , 85];
				_adjustmentY = round random [-85, 0 , 85];
			};
		};
		diag_log format ["MORTAR:	Fire for effect:	%1", _barrage];
		if (_barrage && ((getPOS _mortarTar distance2D _mortarBrackPOS) < _mortarLoiterDist)) then {
			diag_log format ["MORTAR:	Target is loitering. Preparing mortar strike"];
			_barrageCounter = 0;
			while {_barrageCounter < 6} do {
				_adjustmentX = round random [-85, 0 , 85];
				_adjustmentY = round random [-85, 0 , 85];
				_target = [(getPOS _mortarTar select 0) + _adjustmentX,(getPOS _mortarTar select 1) + _adjustmentY];
				_mortarObj doArtilleryFire [_target, currentMagazine (_mortarObj), 1];
				_barrageCounter = _barrageCounter + 1;
				diag_log format ["MORTAR:	Fire for effect %1 at %2", _barrageCounter, _target];
				sleep floor (random 12);
			};
			_barrage = false;
		} else {
			diag_log format ["MORTAR:	Shot out."];
			_mortarObj doArtilleryFire [[(getPOS _mortarTar select 0) + _adjustmentX,(getPOS _mortarTar select 1) + _adjustmentY], currentMagazine (_mortarObj), _mortarBrackRnds];
		};
		
		diag_log format ["MORTAR:	Dice roll has triggered."];
		diag_log format ["MORTAR:	StrikeCounter:	%1", _strikeCounter];
		diag_log format ["MORTAR:	Target POS: 		%1", (getPOS _mortarTar)];
		diag_log format ["MORTAR:	Target adjustment:	%1", [_adjustmentX, _adjustmentY]];
		diag_log format ["MORTAR:	Within loiter distance: %1", ((getPOS _mortarTar distance2D _mortarBrackPOS) < _mortarLoiterDist)];
		
		_mortarBrackPOS = getPOS _mortarTar;
	};
	sleep _mortarDiceInt;
	false;
};

diag_log format ["MORTAR:	%1 has terminated.", _thisScript];
