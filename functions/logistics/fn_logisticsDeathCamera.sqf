/*
	
	Author: Thomas Ryan \ Diffusion9
	
	Description:
		Repurposed code from BIS_fnc_establishingShot by Thomas Ryan.
		Creates an overhead camera with post-process effects.
		Function has two modes: True (Create the shot), and False (kill the shot).
	
	Paramaters:
	0:	OBJECT 	- target the camera should orbit.
	1:	BOOL 	- TRUE to start the sequence, FALSE to kill the sequence.

 */

private ["_tgt", "_state"];
_tgt = [_this, 0, objNull, [objNull, []]] call BIS_fnc_param;
_state = _this select 1;

_txt = "You were Killed in Action";
_alt = 300;
_rad = 200;
_ang = random 360;
_dir = round random 1;

if (_state) then {
	BIS_fnc_establishingShot_fakeUAV = "Camera" camCreate [10,10,10];

	BIS_fnc_establishingShot_fakeUAV cameraEffect ["INTERNAL", "BACK"];

	cameraEffectEnableHUD true;

	private ["_pos", "_coords"];
	_pos = if (typeName _tgt == typeName objNull) then {position _tgt} else {_tgt};
	_coords = [_pos, _rad, _ang] call BIS_fnc_relPos;
	_coords set [2, _alt];

	BIS_fnc_establishingShot_fakeUAV camPrepareTarget _tgt;
	BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
	BIS_fnc_establishingShot_fakeUAV camPrepareFOV 0.700;
	BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0;

	// Timeout the preload after 3 seconds
	BIS_fnc_establishingShot_fakeUAV camPreload 3;

	// Apply post-process effects
	ppColor = ppEffectCreate ["colorCorrections", 1999];
	ppColor ppEffectEnable true;
	ppColor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [0.8, 0.8, 0.8, 0.65], [1, 1, 1, 1.0]];
	ppColor ppEffectCommit 0;

	ppGrain = ppEffectCreate ["filmGrain", 2012];
	ppGrain ppEffectEnable true;
	ppGrain ppEffectAdjust [0.1, 1, 1, 0, 1];
	ppGrain ppEffectCommit 0;

	// Disable stuff after simulation starts
	[] spawn
	{
		waitUntil {time > 0};
		showCinemaBorder false;
		enableEnvironment false;
	};

	// Move camera in a circle
	[_pos, _alt, _rad, _ang, _dir] spawn {
		scriptName "BIS_fnc_establishingShot: camera control";

		private ["_pos", "_alt", "_rad", "_ang", "_dir"];
		_pos = _this select 0;
		_alt = _this select 1;
		_rad = _this select 2;
		_ang = _this select 3;
		_dir = _this select 4;

		while {isNil "BIS_missionStarted"} do {
			private ["_coords"];
			_coords = [_pos, _rad, _ang] call BIS_fnc_relPos;
			_coords set [2, _alt];

			BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
			BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0.5;

			waitUntil {camCommitted BIS_fnc_establishingShot_fakeUAV || !(isNil "BIS_missionStarted")};

			BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
			BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0;
			
			_ang = if (_dir == 0) then {_ang - 0.5} else {_ang + 0.5};
		};
	};

	// Create logic to play sounds
	BIS_fnc_establishingShot_logic_group = createGroup sideLogic;
	BIS_fnc_establishingShot_logic1 = BIS_fnc_establishingShot_logic_group createUnit ["Logic", [10,10,10], [], 0, "NONE"];
	BIS_fnc_establishingShot_logic2 = BIS_fnc_establishingShot_logic_group createUnit ["Logic", [10,10,10], [], 0, "NONE"];
	BIS_fnc_establishingShot_logic3 = BIS_fnc_establishingShot_logic_group createUnit ["Logic", [10,10,10], [], 0, "NONE"];

	[] spawn {
		scriptName "BIS_fnc_establishingShot: UAV sound loop";

		// Determine duration
		private ["_sound", "_duration"];
		_sound = "UAV_loop";
		_duration = getNumber (configFile >> "CfgSounds" >> _sound >> "duration");

		while {!(isNull BIS_fnc_establishingShot_logic1)} do {
			BIS_fnc_establishingShot_logic1 say _sound;
			sleep _duration;

			if (!(isNull BIS_fnc_establishingShot_logic2)) then {
				BIS_fnc_establishingShot_logic2 say _sound;
				sleep _duration;
			};
		};
	};

	[] spawn {
		scriptName "BIS_fnc_establishingShot: random sounds control";

		while {!(isNull BIS_fnc_establishingShot_logic3)} do {
			// Choose random sound
			private ["_sound", "_duration"];
			_sound = format ["UAV_0%1", round (1 + random 8)];
			_duration = getNumber (configFile >> "CfgSounds" >> _sound >> "duration");

			BIS_fnc_establishingShot_logic3 say _sound;

			sleep (_duration + (5 + random 5));
		};
	};

	// Compile SITREP text

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

	// Display SITREP
	_SITREP = [
		[_date + " ", ""],
		[_time, "font = 'PuristaMedium'"],
		["", "<br/>"],
		[_txt, ""],
		["", "<br/>"]
	];
	BIS_fnc_establishingShot_SITREP = [
		_SITREP,
		0.015 * safeZoneW + safeZoneX,
		0.015 * safeZoneH + safeZoneY,
		false,
		"<t align = 'left' size = '1.0' font = 'PuristaLight'>%1</t>"
	] spawn BIS_fnc_typeText2;
	
	sleep 12;
	["<t size = '1' font = 'PuristaMedium'>Awaiting Deployment<br/></t><t size = '.6' font = 'PuristaLight'>The logistics helicopter is currently tasked with another mission<br/>You will be deployed when it is available</t>",-1,-1,30,6,0,789] spawn BIS_fnc_dynamicText;	

} else {
	/// DESTROY
	("BIS_layerStatic" call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN"];
	waitUntil {!(isNull (uiNamespace getVariable "RscStatic_display"))};
	waitUntil {isNull (uiNamespace getVariable "RscStatic_display")};

	// Remove SITREP
	if (!(isNil "BIS_fnc_establishingShot_SITREP")) then {
		terminate BIS_fnc_establishingShot_SITREP;
		["", 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	};

	// Delete sound logics and group
	{if (!(isNil _x)) then {deleteVehicle (missionNamespace getVariable _x)}} forEach ["BIS_fnc_establishingShot_logic1", "BIS_fnc_establishingShot_logic2", "BIS_fnc_establishingShot_logic3"];
	if (!(isNil "BIS_fnc_establishingShot_logic_group")) then {deleteGroup BIS_fnc_establishingShot_logic_group};

	if (!(isNil "_drawEH")) then {
		removeMissionEventHandler ["Draw3D", _drawEH];
	};

	if (!(isNull (uiNamespace getVariable "RscEstablishingShot"))) then {
		((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlSetFade 1;
		((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlCommit 0;
	};

	{
		private ["_layer"];
		_layer = _x call BIS_fnc_rscLayer;
		_layer cutText ["", "PLAIN"];
	} forEach ["BIS_layerEstShot", "BIS_layerStatic", "BIS_layerInterlacing"];

	enableEnvironment false;

	if !(isNil {BIS_fnc_establishingShot_fakeUAV}) then {
		BIS_fnc_establishingShot_fakeUAV cameraEffect ["TERMINATE", "BACK"];
		camDestroy BIS_fnc_establishingShot_fakeUAV;
	};
	
		if !(isNil {ppColor}) then {
			ppEffectDestroy ppColor;
			ppEffectDestroy ppGrain;
	};

	enableEnvironment true;

};