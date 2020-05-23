lastVehID = "none";

player addEventHandler ["GetInMan", { 
	_var = (_this select 2);
	if( (_var isKindOf "Car") || (_var isKindOf "Air") || (_var isKindOf "Ship") ) then {
		lastVehID = (_var call BIS_fnc_netId);
	};
}];

act_car = player addAction [
	"Add to vehicle", 
	"tst.sqf", 
	"",
	1.5,
	false,
	true,
	"",
	'
		_show = false;
		_trg = cursorTarget;
		if( (_trg isKindOf "Man" && (!alive _trg)) || (_trg isKindOf "WeaponHolderSimulated") || (_trg isKindOf "WeaponHolder") ) then{
			_show = true;
		};
		_show
	'
];

