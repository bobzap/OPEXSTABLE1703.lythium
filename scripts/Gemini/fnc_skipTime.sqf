private _length = _this select 3 select 0;

// DISPLAYING BLACK SCREEN
titleText ["", "black out", 3];
3 fadeSound 0;
sleep 4;

// SKIPPING TIME
if (isServer) then {skipTime _length};

// DISPLAYING TEXT
titleText [format [localize "STR_aFewHoursLater", _length], "black", 0.00001];
sleep _length;

// HIDING BLACK SCREEN
titleText ["", "black in", 5];
5 fadeSound 1;