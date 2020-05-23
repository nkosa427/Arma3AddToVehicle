
_vehFull = 0;
_type = (_this select 2);
_items = (_this select 1);
_veh = (_this select 0);
_trg = cursorTarget;

//systemChat str(_items);
//systemChat str(_veh);

{
	if (_veh canAdd _x) then {
		_veh addItemCargoGlobal [_x, 1];
		_trg removeItem _x;
		
		if (isClass (configFile >> "CFGweapons" >> _x)) then {
			systemChat str(_x);
			_trg removeWeapon _x;
		};
		
	} else {
		_vehFull = 1;
	};
	//systemChat str(_x);
}forEach _items;

if (_vehFull isEqualTo 0) then {
	if (_type isEqualTo 0) then {
		_uniform = (uniform _trg);
		if (_veh canAdd _uniform) then {
			_veh addItemCargoGlobal [_uniform, 1];
			removeUniform _trg;
		}else{
			_vehFull = 1;
		};
		
	}else{
		_vest = (vest _trg);
		if (_veh canAdd _vest) then {
			_veh addItemCargoGlobal [_vest, 1];
			removeVest _trg;
		}else{
			_vehFull = 1;
		};
	};
};

_vehFull;

