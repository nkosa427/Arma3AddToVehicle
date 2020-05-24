
fnc_getItems = compile preprocessFile "fn_getItems.sqf";

//{
	//systemChat str(itemCargo _x);
	//systemChat str(magazineCargo _x);
	//systemChat str(weaponCargo _x);
//}forEach _containersInCrate;


if (lastVehId isEqualTo "none") then{
	systemChat "No last vehicle";
}else{
	_veh = (lastVehId call BIS_fnc_objectFromNetId);
	if ( (alive _veh) && ((player distance2d (lastVehId call BIS_fnc_objectFromNetId)) < 31) ) then {
		//hint str(player distance2d (lastVehId call BIS_fnc_objectFromNetId));
		[_veh] call fnc_getItems;
		sleep 3;
		hintSilent "";
	}else{
		if(!alive_veh) then{
			hint "Vehicle Destroyed";
			sleep 5;
			hintSilent "";
		}else{
			hint "Vehicle too far";
			sleep 5;
			hintSilent "";
		}	
	};
};	

