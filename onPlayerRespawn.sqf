// Equip Player with ASG Equipment
[player] call ASG_fnc_equipPlayer;

// Re-initialize Box Access by MOSES
[player] execVM "scripts\sand_lockBoxes.sqf";

player forceWalk false;
enableSentences false;
enableRadio false;
showHUD [true,true,true,true,true,true,false,true];

// =================================================================
// RESPAWN HELICOPTER

// Checks for player on Respawn Island (due to how BIS Revive works);
if ((mapGridPosition player) == (mapGridPosition respawnIsland)) then {
	diag_log "Player has respawned and is at Respawn Island.";
	[player, true] remoteExec ["hideObjectGlobal", 2];
	[player, false] remoteExec ["enableSimulationGlobal", 2];
	_heloStatus = [] spawn {
		waitUntil {
			if (!simulationEnabled (respawnHelo select 0)) exitWith {
				sleep (random 2);
				player moveInCargo (respawnHelo select 0);
				sleep (random 2);
				[player, (respawnHelo select 0)] remoteExec ["assignAsCargo", 2];
				if (!reinforcementEvent) then {
					reinforcementEvent = true;
					publicVariable "reinforcementEvent";	// so other clients see it too.
				};
				true;
			};
			sleep 5;	// Check status every 5 seconds.
			false;
		};	
	};
	
	_fadeIn = [] spawn {
		_messageIn = false;
		waitUntil {
			if ((simulationEnabled (respawnHelo select 0)) && (player in (respawnHelo select 0))) then {
				sleep 4;
				cutText ["","BLACK IN", 30];
				// Get the player's real (not in-game) rank via Insignia display name;
				_rankName = format ["%1 %2", (getText ((missionconfigfile >> "CfgUnitInsignia" >> (player call BIS_fnc_getUnitInsignia)) select 0)), (name player)];
				_groupName = format ["Reinforcing %1", (group player)];
				_respawnText = format ["Northern %1", worldName];
				[
					[
						[_rankName, "<t align = 'center' shadow = '1' size = '1.1' font='PuristaBold'>%1</t><br/>", 10],
						[_groupName, "<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>", 5],
						["Respawn Island, North Altis", "<t align = 'center' shadow = '1' size = '0.5'>%1</t>", 50]
					]
				] spawn BIS_fnc_typeText;				
				_messageIn = true;
			};
		_messageIn;
		};
	};	
};