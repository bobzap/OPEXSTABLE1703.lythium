private _identity = param [0, "", [""]];
private _message = param [1, "", [""]];

[OPEX_friendly_side1, _identity] commandChat (localize _message);