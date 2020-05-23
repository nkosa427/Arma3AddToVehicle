_items = [];
_backpacks = [];
_backpackType = [];

_veh = (_this select 0);
_trg = cursorTarget;

if(_trg isKindOf "Man") then {

	/////////////////////////////Weapons and Magazines////////////////////////////////////
	_items = magazines _trg;
    _items append weapons _trg;
	
	/////////////////////////////Uniform and Uniform Contents
	_uniformItems = (getItemCargo(uniformContainer _trg));
	_numItems = count (_uniformItems select 0);
	
	for "_i" from 0 to _numItems do {
		for "_j" from 1 to ((_uniformItems select 1) select _i) do{
			_items append [((_uniformItems select 0) select _i)];
		};
	};
	
	_items append [uniform _trg];
	removeUniform _trg;
	
	////////////////////////////Vest and Vest Contents//////////////////////////////////
	_vestItems = (getItemCargo(vestContainer _trg));
	_numItems = count (_vestItems select 0);
	
	for "_i" from 0 to _numItems do {
		for "_j" from 1 to ((_vestItems select 1) select _i) do{
			_items append [((_vestItems select 0) select _i)];
		};
	};
	
	_items append [vest _trg];	
	removeVest _trg;
	
	////////////////////////////Backpack and Backpack Contents//////////////////////////	
	_items append (backpackItems _trg);
	_backpackType append [(backpack _trg)];
	removeBackpack _trg;
		
    removeAllWeapons _trg;
	
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

//hint format ["Added %1", ];


