/*

	ASG_fnc_mortarFireLogic
	
	Receives two objects; a target, and a mortar.
	This function contains the logic for handling the mortars.
	
	INPUT:
		0	OBJ	Target for the mortar to track.
		1	OBJ	The mortar that tracks the target.

*/

private ['_mortarTar', '_mortarObj'];
_mortarTar = _this select 0;	// The mortar's target.
_mortarObj = _this select 1;	// The mortar itself.
_mortarVarStr = _this select 2;	// The mortar's sister mortar.
_mortarSister = format ['%1_sister', _mortarVarStr];
_mortarTrigger = format ['%1_trigger', _mortarVarStr];

diag_log format ["MORTAR:	%1 has started.", _thisScript];
diag_log format ["MORTAR:	Incoming Items: %1", _this];
diag_log format ["MORTAR:	Target: %1", _mortarTar];
diag_log format ["MORTAR:	Mortar: %1", _mortarObj];


// MORTAR DEFAULT VALUES
_mortarChance = 70;			//	Chance to trigger mortar engagement. (75 = 25%). 85
_mortarDiceInt = 60;		//	Time between dice rolls after failing a dice roll. 15
_mortarLoiterDist = 75;	//	How far the target must be from its last position to avoid zeroing.
_mortarBrackPOS = [0,0];	//	Default initial value for target bracketing.
_mortarBrackRnds = 1;		//	How many shells dropped per bracket shot.
_strikeCounter = 0;			//	How many times the mortar has fired.

// DISABLE THE AI
_mortarObj disableAI "TARGET";
_mortarObj disableAI "AUTOTARGET";

// After the trigger is kicked off, wait 1 minute to create the feeling of a call for fire.
// Otherwise the dice roll could trigger a mortar within ~10 seconds of first contact.
diag_log "MORTAR:	Beginning call for fire. Wait 60 seconds.";
sleep 60;
scopeName "mainLoop";
waitUntil {
	if (!alive (((missionNamespace getVariable _mortarVarStr) select 1) select 0)) exitWith {
		diag_log "MORTAR:	Mortar destroyed. Terminating.";
		(missionNamespace getVariable _mortarSister) setDamage 1;
		((missionNamespace getVariable _mortarVarStr) select 0) setDamage 1;
		deleteVehicle (missionNamespace getVariable _mortarTrigger);
		terminate _thisScript;
		true;
	};
	if ((((missionNamespace getVariable _mortarVarStr) select 1) select 0) distance _mortarTar < 200) exitWith {
		diag_log "MORTAR:	Enemies too close. Abandoning and destroying.";
		doGetOut ((missionNamespace getVariable _mortarVarStr) select 0);
		sleep 3;
		(missionNamespace getVariable _mortarSister) setDamage 1;
		((missionNamespace getVariable _mortarVarStr) select 0) setDamage 1;
		deleteVehicle (missionNamespace getVariable _mortarTrigger);
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
			waitUntil {
				_adjustmentX = round floor random [-300, 50 , 300];
				_adjustmentY = round floor random [-300, -50 , 300];
				sleep 0.2;
				( (abs _adjustmentX > 50) && (abs _adjustmentY > 100) );
			};
				_barrage = false;
			};
			case 4 : {
			waitUntil {
				_adjustmentX = round floor random [-150, 50 , 150];
				_adjustmentY = round floor random [-150, -50 , 150];
				sleep 0.2;
				( (abs _adjustmentX > 50) && (abs _adjustmentY > 75) );
			};
				_barrage = false;
			};
			case 5 : {
				_adjustmentX = round random [-25, 0 , 25];
				_adjustmentY = round random [-25, 0 , 25];
				_barrage = false;
			};
			case 6 : {
				_barrage = true;
				_strikeCounter = 0;
			};			
			case default {
				_adjustmentX = round random [-85, 0 , 85];
				_adjustmentY = round random [-85, 0 , 85];
				_barrage = false;
			};
		};
		diag_log format ["MORTAR:	Fire for effect: %1", _barrage];
		if (_barrage && ((getPOS _mortarTar distance2D _mortarBrackPOS) < _mortarLoiterDist)) then {
			diag_log format ["MORTAR:	Target is loitering. Preparing mortar strike"];
			_barrageCounter = 0;
			while {_barrageCounter < 7} do {
				_adjustmentX = round random [-85, 0 , 85];
				_adjustmentY = round random [-85, 0 , 85];
				_target = [(getPOS _mortarTar select 0) + _adjustmentX,(getPOS _mortarTar select 1) + _adjustmentY];
				_mortarObj doArtilleryFire [_target, currentMagazine (_mortarObj), 1];
				_barrageCounter = _barrageCounter + 1;
				diag_log format ["MORTAR:	Fire for effect %1 at %2", _barrageCounter, _target];
				sleep 3;
			};
			_barrage = false;
			diag_log format ["MORTAR:	Barrage has ended. Beginning 60 second cooldown."];
			sleep 60;
		} else {
			diag_log format ["MORTAR:	Shot out."];
			_mortarObj doArtilleryFire [[(getPOS _mortarTar select 0) + _adjustmentX,(getPOS _mortarTar select 1) + _adjustmentY], currentMagazine (_mortarObj), _mortarBrackRnds];
		};
		diag_log format ["MORTAR:	StrikeCounter:	%1", _strikeCounter];
		diag_log format ["MORTAR:	Target POS: %1", (getPOS _mortarTar)];
		diag_log format ["MORTAR:	Target adjustment: %1", [_adjustmentX, _adjustmentY]];
		diag_log format ["MORTAR:	Within loiter distance: %1", ((getPOS _mortarTar distance2D _mortarBrackPOS) < _mortarLoiterDist)];
		_mortarBrackPOS = getPOS _mortarTar;
	};
	sleep _mortarDiceInt;
	false;
};

diag_log format ["MORTAR:	%1 has terminated.", _thisScript];
