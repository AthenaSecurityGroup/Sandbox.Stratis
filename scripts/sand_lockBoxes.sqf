//First Platoon
["S11",["A11","A11A","A11B","A113","A114","A116","A117","A15","A16","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S12",["A12","A12A","A12B","A123","A124","A126","A127","A15","A16","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S13",["A13","A13A","A13B","A133","A134","A136","A137","A15","A16","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S14",["A11","A12","A13","A15","A16","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S15",["A11","A12","A13","A15","A16","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S16",["A1M","A1R","A15","A16","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
 
//Second Platoon
["S21",["A21","A21A","A21B","A213","A214","A216","A217","A25","A26","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S22",["A22","A22A","A22B","A223","A224","A226","A227","A25","A26","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S23",["A23","A23A","A23B","A233","A234","A236","A237","A25","A26","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S24",["A21","A22","A23","A25","A26","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S25",["A21","A22","A23","A25","A26","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S26",["A2M","A2R","A25","A26","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
 
//Third Platoon
["S31",["A31","A31A","A31B","A313","A314","A316","A317","A35","A36","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S32",["A32","A32A","A32B","A323","A324","A326","A327","A35","A36","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S33",["A33","A33A","A33B","A333","A334","A336","A337","A35","A36","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S34",["A31","A32","A33","A35","A36","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S35",["A31","A32","A33","A35","A36","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S36",["A3M","A3R","A35","A36","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
 
//Weapons
["S41",["A4","A4B","A4C","A44","A45","A46","A47","A48","A49","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S42",["A4","A4B","A4C","A44","A45","A46","A47","A48","A49","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
["S43",["A4","A4B","A4C","A44","A45","A46","A47","A48","A49","A5","A6","A6O","A7"]] call MOSES_fnc_accessInfo;
 
//Headquarters
["S61",["A5","A6","A6M","A6O","A6R","A7"]] call MOSES_fnc_accessInfo;
["S62",["A5","A6","A6M","A6O","A6R","A7"]] call MOSES_fnc_accessInfo;
 
//Auxiliaries
["SB1",["B11","B11B","B113","B114","B115","B116","B21","B21B","B213","B214","B215","B216","B1R","B15","B16","B164","B165","B166","C11","C12","C13","C21","C22","C23","C31","C32","C33","D11","D12","D13","D21","D22","D23","D31","D32","D33","E2","E3","E4","E5","E6","E7","R3","R5","R6","R7"]] call MOSES_fnc_accessInfo;
["SB2",["B11","B11B","B113","B114","B115","B116","B21","B21B","B213","B214","B215","B216","B1R","B15","B16","B164","B165","B166","C11","C12","C13","C21","C22","C23","C31","C32","C33","D11","D12","D13","D21","D22","D23","D31","D32","D33","E2","E3","E4","E5","E6","E7","R3","R5","R6","R7"]] call MOSES_fnc_accessInfo;
["SB3",["B11","B11B","B113","B114","B115","B116","B21","B21B","B213","B214","B215","B216","B1R","B15","B16","B164","B165","B166","C11","C12","C13","C21","C22","C23","C31","C32","C33","D11","D12","D13","D21","D22","D23","D31","D32","D33","E2","E3","E4","E5","E6","E7","R3","R5","R6","R7"]] call MOSES_fnc_accessInfo;
["SB4",["B11","B11B","B113","B114","B115","B116","B21","B21B","B213","B214","B215","B216","B1R","B15","B16","B164","B165","B166","C11","C12","C13","C21","C22","C23","C31","C32","C33","D11","D12","D13","D21","D22","D23","D31","D32","D33","E2","E3","E4","E5","E6","E7","R3","R5","R6","R7"]] call MOSES_fnc_accessInfo;

player addEventHandler ["InventoryOpened",{
    {
        if !(_x call MOSES_fnc_accessInfo) exitWith {
            hintSilent "You do not have access to this group box";
            TRUE
        };
        FALSE
    } forEach ([_this select 1] + (player nearSupplies 1.5))
}];