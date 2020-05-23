_items = [];
_weapons = [];
_vestArray = [];
_uniformArray = [];
_backpacks = [];
_backpackType = [];
_vehFull = 0;
fnc_transferWeapons = compile preprocessFile "fn_transferWeapons.sqf";
fnc_transferGear = compile preprocessFile "fn_transferGear.sqf";

_veh = (_this select 0);
_trg = cursorTarget;

if(_trg isKindOf "Man") then {

	/////////////////////////////Weapons and Magazines////////////////////////////////////
	_weapons = magazines _trg;
    _weapons append weapons _trg;
	_val = [_veh, _weapons] call fnc_transferWeapons;
	
	if (_val > 0) then {
		_vehFull = 1;
	};
	
	systemChat str(_vehFull);
	
/////////////////////////////////Uniform and Uniform Contents/////////////////////////////
	_uniformArray = (getItemCargo(uniformContainer _trg));
	_numItems = count (_uniformArray select 0);
	_uniformItems = [];
	
	for "_i" from 0 to _numItems do {
		for "_j" from 1 to ((_uniformArray select 1) select _i) do{
			_uniformItems append [((_uniformArray select 0) select _i)];
		};
	};
	
	if (!((uniform _trg) isEqualTo "")) then {
		_val = [_veh, _uniformItems, 0] call fnc_transferGear;
		if (_val > 0) then {
			_vehFull = 1;
		};
	};
	
	
	//_items append [uniform _trg];
	//removeUniform _trg;
	
/////////////////////////////////Vest and Vest Contents//////////////////////////////////
	_vestArray = (getItemCargo(vestContainer _trg));
	_numItems = count (_vestArray select 0);
	_vestItems = [];
	
	for "_i" from 0 to _numItems do {
		for "_j" from 1 to ((_vestArray select 1) select _i) do{
			_vestItems append [((_vestArray select 0) select _i)];
		};
	};
	
	if (!((vest _trg) isEqualTo "")) then {
		val = [_veh, _vestItems, 1] call fnc_transferGear;
		if (_val > 0) then {
			_vehFull = 1;
		};
	};
	
	//_items append [vest _trg];	
	//removeVest _trg;
	
///////////////////////////////Backpack and Backpack Contents//////////////////////////	
	_items append (backpackItems _trg);
	_backpackType append [(backpack _trg)];
	
	//removeBackpack _trg;	
    //removeAllWeapons _trg;
	
}else{
	_items = magazineCargo _trg;
	_items append weaponCargo _trg;
	_backpackType append backpackCargo _trg;
	_backpacks = everyBackpack _trg;
	
	//clearWeaponCargoGlobal _trg;
    //clearMagazineCargoGlobal _trg;
    //clearBackpackCargoGlobal _trg;
};	

//////////////////////////////Add backpack items to items array///////////////////////////

{
	_items append itemCargo _x;
	_items append magazineCargo _x;
	_items append weaponCargo _x;
}forEach _backpacks;

//////////////////////////////Adding items to vehicle////////////////////////////////////

_vehFull = 0;
/*
{
	if (_veh canAdd _x) then {
		_veh addItemCargoGlobal [_x, 1];
	} else {
		_vehFull = 1;
	};
	//systemChat str(_x);
}forEach _items;

{
	if (_veh canAdd _x) then {
		_veh addBackpackCargoGlobal [_x, 1];
	} else {
		_vehFull = 1;
	};
}forEach _backpackType;

if (_vehFull isEqualTo 1) then {
	hint "Vehicle is full";
};
*/

//hint format ["Added %1", ];


