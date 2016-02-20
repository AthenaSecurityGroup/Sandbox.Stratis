private ["_deployedBases", "_baseIndices", "_basesWithHelipads", "_intersection", "_pos"];
_deployedBases = baseData select {_x select 0};

if (count _deployedBases == 0) exitWith {position respawnIsland};

// TODO: embedded data in base data structures.
_baseIndices = [7, 10, 9];
_basesWithHelipads = [
	baseData select (_baseIndices select 0), // TOC
	baseData select (_baseIndices select 1), // MOB
	baseData select (_baseIndices select 2) // FOB
];

_intersection = _deployedBases arrayIntersect _basesWithHelipads;

if (count _intersection == 0) then {
	_pos = position respawnIsland;
} else {
	_pos = getMarkerPos (_intersection select 0 select 4 select 2); // Marker name
};
_pos;