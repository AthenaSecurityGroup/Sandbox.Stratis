if (earPlugIn) then {
	.1 fadeSound 1;
	earPlugIn = false;
} else {
	1 fadeSound .04;
	earPlugIn = true;
};
