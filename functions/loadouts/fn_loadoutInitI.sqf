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

if isNull _obj throw "Invalid Argument: must provide valid object";

_type = typeof _obj;

removeAllWeapons _obj;
removeAllItems _obj;
removeAllAssignedItems _obj;
removeUniform _obj;
removeVest _obj;
removeBackpack _obj;
removeHeadgear _obj;
removeGoggles _obj;

_obj forceAddUniform "U_I_CombatUniform";
_obj addItemToUniform "FirstAidKit";
_obj addVest "V_PlateCarrierIA1_dgtl";
_obj addHeadgear "H_HelmetIA";

switch (_type) do {
	//Officer
	case "I_officer_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj setunitrank "LIEUTENANT";
	};

	//Squad Leader
	case "I_Soldier_SL_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj setunitrank "SERGEANT";
	};

	//Team Leader
	case "I_Soldier_TL_F": {
		for "_i" from 1 to 3 do {_obj addItemToVest "1Rnd_HE_Grenade_shell";};
		for "_i" from 1 to 3 do {_obj addItemToVest "1Rnd_Smoke_Grenade_shell";};
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_obj addItemToVest "MiniGrenade";};
		_obj addWeapon "arifle_MX_GL_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj setunitrank "CORPORAL";
	};

	//Autorifleman
	case "I_Soldier_AR_F": {
		for "_i" from 1 to 3 do {_obj addItemToVest "100Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_SW_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj addPrimaryWeaponItem "bipod_01_F_blk";
		_obj setunitrank "PRIVATE";
	};

	//AT Rifleman
	case "I_Soldier_LAT_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addBackpack "B_AssaultPack_dgtl";
		for "_i" from 1 to 2 do {_obj addItemToBackpack "NLAW_F";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj addWeapon "launch_NLAW_F";
		_obj setunitrank "PRIVATE";
	};

	//AA Rifleman
	case "I_Soldier_AA_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj addWeapon "launch_I_Titan_F";
		_obj setunitrank "PRIVATE";
	};

	//Light Machine Gunner
	case "I_Soldier_lite_F": {
		for "_i" from 1 to 2 do {_obj addItemToVest "130Rnd_338_Mag";};
		_obj addWeapon "MMG_02_black_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj addPrimaryWeaponItem "bipod_01_F_blk";
		_obj setunitrank "PRIVATE";
	};

	//Medic
	case "I_medic_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj addItemToUniform "FirstAidKit";
		_obj addBackpack "B_AssaultPack_dgtl";
		_obj addItemToBackpack "Medikit";
		for "_i" from 1 to 4 do {_obj addItemToBackpack "FirstAidKit";};
		_obj setunitrank "PRIVATE";
	};

	//Heavy Machine Gunner
	case "I_support_MG_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj addBackpack "I_HMG_01_A_high_weapon_F";
		_obj setunitrank "PRIVATE";
	};

	//Grenade Machine Gunner
	case "I_support_GMG_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj addBackpack "I_GMG_01_high_weapon_F";
		_obj setunitrank "PRIVATE";
	};

	//Assistant Gunner
	case "I_support_AMG_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj addBackpack "I_HMG_01_support_high_F";
		_obj setunitrank "PRIVATE";
	};

	//Mortar Gunner
	case "I_support_Mort_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj addBackpack "I_Mortar_01_weapon_F";
		_obj setunitrank "PRIVATE";
	};

	//Assistant Mortar Gunner
	case "I_support_AMort_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj addBackpack "I_Mortar_01_support_F";
		_obj setunitrank "PRIVATE";
	};

	//Sniper
	case "I_Sniper_F": {
		_obj forceAddUniform "U_I_FullGhillie_sard";
		_obj addVest "V_PlateCarrierIA1_dgtl";
		for "_i" from 1 to 8 do {_obj addItemToVest "10Rnd_338_Mag";};
		_obj addWeapon "srifle_DMR_02_camo_F";
		_obj addPrimaryWeaponItem "muzzle_snds_338_green";
		_obj addPrimaryWeaponItem "acc_pointer_IR";
		_obj addPrimaryWeaponItem "optic_AMS_khk";
		_obj addPrimaryWeaponItem "bipod_01_F_mtp";
		_obj setunitrank "CORPORAL";
	};

	//Spotter
	case "I_Spotter_F": {
		_obj forceAddUniform "U_I_FullGhillie_sard";
		for "_i" from 1 to 2 do {_obj addItemToVest "FirstAidKit";};
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "acc_pointer_IR";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj setunitrank "SERGEANT";
	};

	//UAV
	case "I_soldier_UAV_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj addBackpack "I_UAV_01_backpack_F";
		_obj linkItem "I_UavTerminal";
		_obj setunitrank "PRIVATE";
	};

	//Police
	case "I_Soldier_AAR_F": {
		_obj forceAddUniform "U_B_CTRG_2";
		_obj addVest "V_TacVest_blk_POLICE";
		for "_i" from 1 to 4 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addHeadgear "H_Cap_police";
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj setunitrank "PRIVATE";
	};

	//Basic
	default {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_Black_F";
		_obj addPrimaryWeaponItem "optic_Aco";
		_obj setunitrank "PRIVATE";
	};
};
