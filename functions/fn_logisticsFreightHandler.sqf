/*

	ASG_fnc_logisticsFreightHandler
		Requires logisticsIVTable
		["Category",[List,of,Items],sell,buy]
	
*/
// _cargoBoxes = [cargoBox];

_cargoBoxes = _this select 0;

_freightContents = [_cargoBoxes] call ASG_fnc_createCargoArray;

saleValue = 0;
buyValue = 0;

{
	for "_i" from 1 to 5 step 2 do {
		_class = (_x select _i);
		_amount = (_x select (_i) + 1);
		{
			_ivIndex = [logisticsIVTable, _x] call KK_fnc_findAll;
			if (_ivIndex isEqualTo []) then {
				diag_log "Item not found in Item Value Table";
				_ivIndex = 30
			} else {
				_indAmount = (_amount select _forEachIndex);
				_ivIndex = (_ivIndex select 0 select 0);
				_ivClass = ([logisticsIVTable, [_ivIndex]] call KK_fnc_findAllGetPath select 0);
				_ivSell = (([logisticsIVTable, [_ivIndex]] call KK_fnc_findAllGetPath select 2) * _indAmount);
				_ivBuy = (([logisticsIVTable, [_ivIndex]] call KK_fnc_findAllGetPath select 3) * _indAmount);
				saleValue = saleValue + _ivSell;
				buyValue = buyValue + _ivBuy;
			};
			
		} forEach _class;
	};
} forEach _freightContents;

{
	clearWeaponCargoGlobal _x; 
	clearMagazineCargoGlobal _x;
	clearItemCargoGlobal _x;
	clearBackpackCargoGlobal _x;
} forEach _cargoBoxes;

[saleValue, buyValue];