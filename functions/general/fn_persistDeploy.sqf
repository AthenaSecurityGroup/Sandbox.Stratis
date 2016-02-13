// ASG_fnc_persistDeploy;

{
	clearWeaponCargoGlobal _x; 
	clearMagazineCargoGlobal _x;
	clearItemCargoGlobal _x;
	clearBackpackCargoGlobal _x;
} forEach boxNames;

{
	[[_x], (missionNameSpace getVariable (_x select 0))] call ASG_fnc_cargoArrayAdd;
} forEach (profileNamespace getVariable ["ASGinventory", boxDefContents]);