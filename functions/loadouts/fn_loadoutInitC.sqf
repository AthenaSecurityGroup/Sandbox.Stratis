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

removeuniform _obj;
removeallweapons _obj;

switch (_type) do {
	case "C_man_p_beggar_F": {
	_obj forceAddUniform "U_C_Poor_1"};

	case "C_man_1" :{
	_obj forceAddUniform "U_Competitor"};

	case "C_man_polo_1_F" :{
	_obj forceAddUniform "U_C_Poloshirt_blue"};

	case "C_man_polo_2_F" :{
	_obj forceAddUniform "U_C_Poloshirt_burgundy"};

	case "C_man_polo_3_F" :{
	_obj forceAddUniform "U_C_Poloshirt_redwhite"};

	case "C_man_polo_4_F" :{
	_obj forceAddUniform "U_C_Poloshirt_salmon"};

	case "C_man_polo_5_F" :{
	_obj forceAddUniform "U_C_Poloshirt_stripped"};

	case "C_man_polo_6_F" :{
	_obj forceAddUniform "U_C_Poloshirt_tricolour"};

	case "C_man_shorts_1_F" :{
	_obj forceAddUniform "U_BG_Guerilla2_1"};

	case "C_man_1_1_F" :{
	_obj forceAddUniform "U_BG_Guerilla2_2"};

	case "C_man_1_2_F" :{
	_obj forceAddUniform "U_BG_Guerilla2_3"};

	case "C_man_1_3_F" :{
	_obj forceAddUniform "U_BG_Guerilla3_1"};

	case "C_man_p_fugitive_F" :{
	_obj forceAddUniform "U_I_G_resistanceLeader_F"};

	case "C_man_p_shorts_1_F" :{
	_obj forceAddUniform "U_I_G_Story_Protagonist_F"};

	case "C_man_hunter_1_F" :{
	_obj forceAddUniform "U_C_HunterBody_grn"};

	case "C_journalist_F" :{
	removeVest _obj;
	_obj forceAddUniform "U_C_Journalist"};

	case "C_Marshal_F" :{
	removeGoggles _obj;
	removeHeadgear _obj;
	_obj forceAddUniform "U_Marshal"};

	case "C_man_pilot_F" :{
	removeBackpack _obj;
	_obj forceAddUniform "U_Rangemaster"};

	case "C_scientist_F" :{
	_obj forceAddUniform "U_C_Scientist"};

	case "C_man_shorts_2_F" :{
	_obj forceAddUniform "U_NikosAgedBody"};

	case "C_man_shorts_3_F" :{
	_obj forceAddUniform "U_NikosBody"};

	case "C_man_shorts_4_F" :{
	_obj forceAddUniform "U_OrestesBody"};

	case "C_man_w_worker_F" :{
	_obj forceAddUniform "U_C_WorkerCoveralls"};
};