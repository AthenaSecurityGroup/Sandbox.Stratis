//	select 0:	OBJ	Incoming player target;
diag_log format ["MORTAR:	Script has started"];
_mortarCheckROF = 100; // Threshold that will be randomized for ROF between mortar ranging shots (seconds).
_mortarTriggerChance = 90; // 75 = %25
_diceRollTime = 15;	// How often the dice rolls again when failing.
_loiterDistance = 75; // How far target must be from last position to be barraged.
_target = _this select 0;
_nearMortar = _this select 1;

(_nearMortar) disableAI "AUTOTARGET";	// ??
(_nearMortar) disableAI "TARGET";	// ?? Hopefully these are working?

_targetPOS = (getPOS _target); _targetPOS deleteAt 2;
_targetPOS = [((_targetPOS select 0) + (random 200)), ((_targetPOS select 1) + (random 200))];
_targetDialPOS = [0,0];	// Sets the initial target dialing position
_strikeAmount = 1;
_tgtCorrectionX = (random 100);
_tgtCorrectionY = (random 80);

waitUntil {
	_diceRoll = round (random 100);
	diag_log format ["MORTAR:%2	Dice (> 75) = %1", _diceRoll, (str _nearMortar)];
	if (_diceRoll > _mortarTriggerChance) then {
		diag_log "MORTAR:	Strike has been triggered.";
		_strikeCounter = 0;
		/// TO DO: for ARMA 1.55
		// _targetRelDir = _nearMortar getRelDir _target;
		// _nearMortar setFormDir _targetRelDir;
		while {_strikeCounter >= 0} do {
			if (!alive _nearMortar) exitWith {
				diag_log "MORTAR:	Mortar destroyed. Terminating.";
				terminate _thisScript;
				true;
			};
			_strikeCounter = _strikeCounter + 1;
			_targetPOS = [round ((_targetPOS select 0) - (random _tgtCorrectionX)), round ((_targetPOS select 1) - (random _tgtCorrectionY))];
			if (((_targetDialPOS distance2D (getPOS _target)) < _loiterDistance) && (_strikeCounter > 4)) exitWith {
				diag_log format ["MORTAR:	Unit is loitering. Preparing mortar strike."];
				_counter = 1;
				while {_counter < 5} do
				{
					_targetPOS = [((getPOS _target select 0) + (random 25)), ((getPOS _target select 1) + (random 29))];
					(_nearMortar) doArtilleryFire [_targetPOS, currentMagazine (_nearMortar), 1];
					_counter = _counter + 1;
					diag_log format ["MORTAR:	Barrage: %1 @ %2", _counter, _targetPOS];
					sleep (random 3);
				};
			};
			diag_log format ["MORTAR:	Strike: %1 -- Coord: %2", _strikeCounter, _targetPOS];
			(_nearMortar) doArtilleryFire [_targetPOS, currentMagazine (_nearMortar), _strikeAmount];
			_targetDialPOS = [(round (getPOS _target select 0)),(round (getPOS _target select 1))];
			if (_strikeCounter > 4) then {_strikeCounter = 1}; // Reset after a barrage or two.
			sleep (_mortarCheckROF + (random 20));
		};
		diag_log format ["MORTAR:	Strike has completed, and will be terminated."];
		terminate _thisScript;
	};
	sleep _diceRollTime;
	(false);
};