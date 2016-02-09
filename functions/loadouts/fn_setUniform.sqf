/*

	Sets the players uniform to the ASG custom uniform.
	// _unit SetObjectTextureGlobal [0,"mpmissions\__CUR_MP.Altis\textures\uniform\uniform.paa"];

 */
private ["_unit", "_global", "_tex", "_mat"];

_tex = "textures\uniform\uniform.paa";
_mat = "a3\characters_f_beta\indep\data\ia_soldier_01_clothing.rvmat";
_unit = param [0, objNull, [objNull]];
_global = param [1, false, [false]];

if (_global) then {
	_unit setObjectTextureGlobal [0, _tex];
	_unit setObjectMaterialGlobal [0, _mat];
} else {
	_unit setObjectTexture [0, _tex];
	_unit setObjectMaterial [0, _mat];
};