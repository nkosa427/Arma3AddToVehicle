
_vehFull = 0;
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

_vehFull;

