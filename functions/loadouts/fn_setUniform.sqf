/*

	Sets the players uniform to the ASG custom uniform.
	// _unit SetObjectTextureGlobal [0,"mpmissions\__CUR_MP.Altis\textures\uniform\uniform.paa"];

 */

private ["_unit"];

_unit = _this select 0;
_unit setObjectTexture [0,"textures\uniform\uniform.paa"];
_unit setObjectMaterial [0, "a3\characters_f_beta\indep\data\ia_soldier_01_clothing.rvmat"];