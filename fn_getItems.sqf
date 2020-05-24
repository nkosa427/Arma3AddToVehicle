_items = [];
_weapons = [];
_vestArray = [];
_uniformArray = [];
_backpackItems = [];
_backpacks = [];
_backpackType = [];
_vehFull = 0;
fnc_transferGear = compile preprocessFile "fn_transferGear.sqf";

_veh = (_this select 0);
_trg = cursorTarget;

[0.01] spawn{ 
	_progressPoint = param [0,0,[0]];
	_text = param [1,"",[""]];
	_taskFailed = {
		"SG_CirclePBLayer" cutFadeOut 0.2;
	};
};
disableSerialization;

if(_trg isKindOf "Man") then {

//////////////////////////////////Weapons and Magazines////////////////////////////////////
	_weapons = magazines _trg;
    _weapons append weapons _trg;
	_val = [_veh, _weapons, 3] call fnc_transferGear;
	
	if (_val > 0) then {
		_vehFull = 1;
	};
	
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
		_val = [_veh, _vestItems, 1] call fnc_transferGear;
		if (_val > 0) then {
			_vehFull = 1;
		};
	};
	
///////////////////////////////Backpack and Backpack Contents//////////////////////////	
	_backpackItems append (backpackItems _trg);
	
	if (!((backpack _trg) isEqualTo "")) then {
		_val = [_veh, _backpackItems, 2] call fnc_transferGear;
		if (_val > 0) then {
			_vehFull = 1;
		};
	};

///////////////////////////////Headgear and Assigned Items//////////////////////////////////////////////////
	_headgear = headgear _trg;
	if !(_headgear isEqualTo "") then {
		if(_veh canAdd _headgear) then {
			//_veh addItemCargoGlobal [_headgear, 1];
			_trg unassignItem _headgear;
		}else{
			_vehFull = 1;
		};	
	};
	
	_assignedItems = (assignedItems _trg);
	_items append _assignedItems;
	
	{
		_trg unassignItem _x;
	}forEach _assignedItems;
	
}else{											////////////////Ground items
	_items = magazineCargo _trg;
	_items append weaponCargo _trg;
	_backpackType append backpackCargo _trg;
	_backpacks = everyBackpack _trg;
	
};	

{	//Add backpack items to items array
	_items append itemCargo _x;
	_items append magazineCargo _x;
	_items append weaponCargo _x;
}forEach _backpacks;

//////////////////////////////Adding items on ground to vehicle////////////////////////////////////

_val = [_veh, _items, 3] call fnc_transferGear;
	
if (_val > 0) then {
	_vehFull = 1;
};

{
	if (_veh canAdd _x) then {
		_veh addBackpackCargoGlobal [_x, 1];
	} else {
		_vehFull = 1;
	};
}forEach _backpackType;

if (_vehFull isEqualTo 0) then {
	 clearBackpackCargoGlobal _trg;
};

if (_vehFull isEqualTo 1) then {
	hint "Vehicle is full";
};


//hint format ["Added %1", ];


