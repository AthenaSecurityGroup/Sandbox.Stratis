/*
	Authors: DEL-J and jmlane

	Description:
	Set loadout for given object to desired configuration.

	Parameter(s):
		0: OBJECT - person object.

	Returns:
	BOOL - True if successful, false otherwise.
*/
private ["_obj", "_type"];
_obj = param [0, objNull, [objNull]];

if (isNull _obj) throw "Invalid Argument: must provide valid object";
if (_obj in playableUnits) exitWith {false};

_type = typeof _obj;

removeAllWeapons _obj;
removeAllItems _obj;
removeAllAssignedItems _obj;
removeUniform _obj;
removeVest _obj;
removeBackpack _obj;
removeHeadgear _obj;
removeGoggles _obj;

switch (_type) do {
	// Militia Officer
	case "B_G_officer_F": {
		_obj forceAddUniform "U_BG_leader";
		for "_i" from 1 to 8 do { _obj addItemToVest "20Rnd_762x51_Mag"; };
		_obj addWeapon "srifle_DMR_06_olive_F";
		_obj setunitrank "LIEUTENANT";
	};

	// Militia Squad Leader
	case "B_G_Soldier_SL_F": {
		_obj forceAddUniform "U_BG_Guerilla3_1";
		for "_i" from 1 to 8 do { _obj addItemToVest "20Rnd_762x51_Mag"; };
		_obj addWeapon "srifle_DMR_06_olive_F";
		_obj setunitrank "SERGEANT";
	};

	// Militia Team Leader
	case "B_G_Soldier_TL_F": {
		_obj forceAddUniform "U_BG_Guerrilla_6_1";
		for "_i" from 1 to 8 do { _obj addItemToVest "20Rnd_762x51_Mag"; };
		_obj addWeapon "srifle_DMR_06_olive_F";
		_obj setunitrank "CORPORAL";
	};

	// Militia Rifleman
	case "B_G_Soldier_F": {
		_obj forceAddUniform "U_BG_Guerilla2_1";
		for "_i" from 1 to 8 do { _obj addItemToVest "20Rnd_762x51_Mag"; };
		_obj addWeapon "srifle_DMR_06_olive_F";
		_obj setunitrank "PRIVATE";
	};

	// Militia Autorifleman
	case "B_G_Soldier_AR_F": {
		_obj forceAddUniform "U_BG_Guerilla2_2";
		for "_i" from 1 to 2 do { _obj addItemToVest "150Rnd_762x54_Box"; };
		_obj addWeapon "LMG_Zafir_F";
		_obj setunitrank "PRIVATE";
	};

    // Friendly Police
	case default {
		_obj addHeadgear "H_Cap_police";
		_obj forceAddUniform "U_I_HeliPilotCoveralls";
		_obj addVest "V_TacVest_blk_POLICE";
		for "_i" from 1 to 4 do { _obj addItemToVest "30Rnd_65x39_caseless_mag"; };
		_obj addWeapon "arifle_MXC_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj setunitrank "PRIVATE";
	};
};