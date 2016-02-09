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

_obj forceAddUniform "U_O_OfficerUniform_ocamo";
_obj addVest "V_PlateCarrier1_blk";
_obj addHeadgear "H_HelmetB_light_black";

switch (_type) do {
	//Officer
	case "O_Soldier_O_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addItemToVest "SmokeShell";
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "LIEUTENANT";
	};

	//Squad Leader
	case "O_Soldier_SL_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		for "_i" from 1 to 2 do {_obj addItemToVest "HandGrenade";};
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Arco";
		_obj setunitrank "SERGEANT";
	};

	//Team Leader
	case "O_Soldier_TL_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addItemToVest "SmokeShell";
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "CORPORAL";
	};

	//Rifleman
	case "O_Soldier_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addItemToVest "SmokeShell";
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "PRIVATE";
	};

	//Grenadier
	case "O_Soldier_GL_F": {
		_obj addItemToVest "SmokeShell";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addItemToVest "3Rnd_HE_Grenade_shell";
		_obj addWeapon "arifle_MX_GL_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "PRIVATE";
	};

	//Autorifleman
	case "O_Soldier_AR_F": {
		for "_i" from 1 to 2 do {_obj addItemToVest "200Rnd_65x39_cased_Box_Tracer";};
		_obj addWeapon "LMG_Mk200_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "PRIVATE";
	};

	//AT Rifleman
	case "O_Soldier_LAT_F": {
		_obj addItemToVest "SmokeShell";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addBackpack "B_AssaultPack_ocamo";
		for "_i" from 1 to 2 do {_obj addItemToBackpack "RPG32_F";};
		_obj addItemToBackpack "RPG32_HE_F";
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj addWeapon "launch_RPG32_F";
		_obj setunitrank "PRIVATE";
	};

	//AA Rifleman
	case "O_Soldier_AA_F": {
		_obj addItemToVest "SmokeShell";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj addWeapon "launch_O_Titan_F";
		_obj setunitrank "PRIVATE";
	};

	//Light Machine Gunner
	case "O_HeavyGunner_F": {
		for "_i" from 1 to 2 do {_obj addItemToVest "150Rnd_93x64_Mag";};
		_obj addWeapon "MMG_01_tan_F";
		_obj addPrimaryWeaponItem "bipod_02_F_tan";
		_obj addPrimaryWeaponItem "optic_Arco";
		_obj setunitrank "PRIVATE";
	};

	//Heavy Machine Gunner
	case "O_support_MG_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addBackpack "O_HMG_01_weapon_F";
		_obj addWeapon "arifle_MXC_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "PRIVATE";
	};

	//Grenade Machine Gunner
	case "O_support_GMG_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addBackpack "O_GMG_01_weapon_F";
		_obj addWeapon "arifle_MXC_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "PRIVATE";
	};

	//Assistant Machine Gunner
	case "O_support_AMG_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addBackpack "O_HMG_01_support_F";
		_obj addWeapon "arifle_MXC_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "PRIVATE";
	};

	//Mortar Gunner
	case "O_support_Mort_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addBackpack "O_Mortar_01_weapon_F";
		_obj addWeapon "arifle_MXC_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "PRIVATE";
	};

	//Mortar Assistant
	case "O_support_AMort_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addBackpack "O_Mortar_01_support_F";
		_obj addWeapon "arifle_MXC_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "PRIVATE";
	};

	//Recon Team Leader
	case "O_recon_TL_F": {
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShell";};
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_obj addItemToVest "HandGrenade";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShellRed";};
		for "_i" from 1 to 2 do {_obj addItemToVest "Chemlight_red";};
		for "_i" from 1 to 2 do {_obj addItemToVest "O_IR_Grenade";};
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj addWeapon "Rangefinder";
		_obj linkItem "NVGoggles_OPFOR";
		_obj setunitrank "SERGEANT";
	};

	//Recon Marksman
	case "O_recon_M_F": {
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShell";};
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_obj addItemToVest "HandGrenade";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShellRed";};
		for "_i" from 1 to 2 do {_obj addItemToVest "Chemlight_red";};
		for "_i" from 1 to 2 do {_obj addItemToVest "O_IR_Grenade";};
		_obj addWeapon "arifle_MXM_F";
		_obj addPrimaryWeaponItem "optic_Arco";
		_obj linkItem "NVGoggles_OPFOR";
		_obj setunitrank "CORPORAL";
	};

	//Recon Scout
	case "O_recon_F": {
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShell";};
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_obj addItemToVest "HandGrenade";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShellRed";};
		for "_i" from 1 to 2 do {_obj addItemToVest "Chemlight_red";};
		for "_i" from 1 to 2 do {_obj addItemToVest "O_IR_Grenade";};
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj linkItem "NVGoggles_OPFOR";
		_obj setunitrank "CORPORAL";
	};

	//Recon Scout AT
	case "O_recon_LAT_F": {
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShell";};
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_obj addItemToVest "HandGrenade";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShellRed";};
		for "_i" from 1 to 2 do {_obj addItemToVest "Chemlight_red";};
		for "_i" from 1 to 2 do {_obj addItemToVest "O_IR_Grenade";};
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj linkItem "NVGoggles_OPFOR";
		_obj addBackpack "B_AssaultPack_ocamo";
		for "_i" from 1 to 2 do {_obj addItemToBackpack "RPG32_F";};
		_obj addWeapon "launch_RPG32_F";
		_obj setunitrank "CORPORAL";
	};

	//Recon JTAC
	case "O_recon_JTAC_F": {
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShell";};
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_obj addItemToVest "HandGrenade";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShellRed";};
		for "_i" from 1 to 2 do {_obj addItemToVest "Chemlight_red";};
		for "_i" from 1 to 2 do {_obj addItemToVest "O_IR_Grenade";};
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj addWeapon "Laserdesignator";
		_obj linkItem "NVGoggles_OPFOR";
		_obj setunitrank "CORPORAL";
	};

	//Recon Medic
	case "O_recon_medic_F": {
		_obj addBackpack "B_AssaultPack_blk";
		_obj addItemToBackpack "Medikit";
		for "_i" from 1 to 2 do {_obj addItemToBackpack "FirstAidKit";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShell";};
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_obj addItemToVest "HandGrenade";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShellRed";};
		for "_i" from 1 to 2 do {_obj addItemToVest "Chemlight_red";};
		for "_i" from 1 to 2 do {_obj addItemToVest "O_IR_Grenade";};
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj linkItem "NVGoggles_OPFOR";
		_obj setunitrank "CORPORAL";
	};

	//Recon Demolition Specialist
	case "O_recon_exp_F": {
		_obj addBackpack "B_AssaultPack_blk";
		for "_i" from 1 to 4 do {_obj addItemToBackpack "DemoCharge_Remote_Mag";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShell";};
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_obj addItemToVest "HandGrenade";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShellRed";};
		for "_i" from 1 to 2 do {_obj addItemToVest "Chemlight_red";};
		for "_i" from 1 to 2 do {_obj addItemToVest "O_IR_Grenade";};
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj linkItem "NVGoggles_OPFOR";
		_obj setunitrank "CORPORAL";
	};

	//Combat Medic
	case "O_medic_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addBackpack "B_AssaultPack_blk";
		_obj addItemToBackpack "Medikit";
		for "_i" from 1 to 2 do {_obj addItemToBackpack "FirstAidKit";};
		_obj addWeapon "arifle_MXM_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "CORPORAL";
	};

	//Demolition Specialist
	case "O_soldier_exp_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addBackpack "B_AssaultPack_blk";
		for "_i" from 1 to 4 do {_obj addItemToBackpack "DemoCharge_Remote_Mag";};
		_obj addWeapon "arifle_MXM_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "CORPORAL";
	};

	//Engineer
	case "O_engineer_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj addBackpack "B_AssaultPack_blk";
		_obj addItemToBackpack "ToolKit";
		_obj addItemToBackpack "MineDetector";
		_obj setunitrank "CORPORAL";
	};

	//UAV Operator
	case "O_soldier_UAV_F": {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj addBackpack "O_UAV_01_backpack_F";
		_obj linkItem "O_UavTerminal";
		_obj setunitrank "CORPORAL";
	};

	//Sniper
	case "O_sniper_F": {
		_obj forceAddUniform "U_O_GhillieSuit";
		for "_i" from 1 to 3 do {_obj addItemToUniform "11Rnd_45ACP_Mag";};
		for "_i" from 1 to 8 do {_obj addItemToVest "10Rnd_93x64_DMR_05_Mag";};
		_obj addWeapon "srifle_DMR_05_tan_f";
		_obj addPrimaryWeaponItem "optic_LRPS";
		_obj addPrimaryWeaponItem "bipod_02_F_tan";
		_obj addWeapon "hgun_Pistol_heavy_01_F";
		_obj setunitrank "PRIVATE";
	};

	//Spotter
	case "O_spotter_F": {
		_obj forceAddUniform "U_O_GhillieSuit";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShell";};
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Arco";
		_obj addWeapon "Rangefinder";
		_obj setunitrank "CORPORAL";
	};

	//Guerilla Ammo Bearer
	case "O_soldierU_A_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Assistant Autorifleman
	case "O_soldierU_AAR_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Assistant Anti-Air
	case "O_soldierU_AAA_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Assistant Anti-Tank
	case "O_soldierU_AAT_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Autorifleman
	case "O_soldierU_AR_F": {
		_obj forceAddUniform "U_B_CombatUniform_mcam_tshirt";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 4 do {_obj addItemToVest "100Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MX_SW_Black_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj addPrimaryWeaponItem "bipod_01_F_blk";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Medic
	case "O_soldierU_medic_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		_obj addBackpack "B_AssaultPack_mcamo";
		_obj addItemToBackpack "Medikit";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		for "_i" from 1 to 2 do {_obj addItemToVest "Chemlight_yellow";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShellYellow";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Engineer
	case "O_engineer_U_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Explosive Specialist
	case "O_soldierU_exp_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Grenadier
	case "O_SoldierU_GL_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Light Machine Gunner
	case "O_Urban_HeavyGunner_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 2 do {_obj addItemToVest "150Rnd_93x64_Mag";};
		_obj addWeapon "MMG_01_tan_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj addPrimaryWeaponItem "bipod_01_F_blk";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Marksman
	case "O_soldierU_M_F": {
		_obj forceAddUniform "U_B_FullGhillie_ard";
		_obj addVest "V_Chestrig_khk";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		_obj addWeapon "arifle_MXC_Black_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Anti-Air
	case "O_soldierU_AA_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Anti-Tank
	case "O_soldierU_AT_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addBackpack "B_AssaultPack_mcamo";
		for "_i" from 1 to 2 do {_obj addItemToBackpack "NLAW_F";};
		_obj addWeapon "launch_NLAW_F";
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Repair Specialist
	case "O_soldierU_repair_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		_obj addBackpack "B_AssaultPack_mcamo";
		_obj addItemToBackpack "ToolKit";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Rifleman
	case "O_soldierU_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla AT Rifleman
	case "O_soldierU_LAT_F": {
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		_obj addBackpack "B_AssaultPack_mcamo";
		for "_i" from 1 to 2 do {_obj addItemToBackpack "RPG32_F";};
		_obj addWeapon "launch_RPG32_F";
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Sharpshooter
	case "O_Urban_Sharpshooter_F" :{
		_obj forceAddUniform "U_B_FullGhillie_ard";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_Booniehat_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "10Rnd_93x64_DMR_05_Mag";};
		_obj addWeapon "srifle_DMR_05_blk_F";
		_obj addPrimaryWeaponItem "optic_SOS";
		_obj setunitrank "PRIVATE";
	};

	//Guerilla Squad Leader
	case "O_SoldierU_SL_F": {
		_obj forceAddUniform "U_B_CombatUniform_mcam_tshirt";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_MilCap_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_obj addItemToVest "Chemlight_yellow";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShellYellow";};
		_obj addWeapon "arifle_MXC_Black_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "SERGEANT";
	};

	//Guerilla Team Leader
	case "O_soldierU_TL_F" :{
		_obj forceAddUniform "U_I_G_Story_Protagonist_F";
		_obj addVest "V_Chestrig_khk";
		_obj addHeadgear "H_MilCap_mcamo";
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_green";};
		for "_i" from 1 to 2 do {_obj addItemToVest "Chemlight_yellow";};
		for "_i" from 1 to 2 do {_obj addItemToVest "SmokeShellYellow";};
		_obj addWeapon "arifle_Katiba_C_F";
		_obj addPrimaryWeaponItem "optic_ACO";
		_obj setunitrank "CORPORAL";
	};

	//Basic
	default {
		for "_i" from 1 to 8 do {_obj addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_obj addItemToVest "SmokeShell";
		_obj addWeapon "arifle_MX_F";
		_obj addPrimaryWeaponItem "optic_Holosight";
		_obj setunitrank "PRIVATE";
	};
};