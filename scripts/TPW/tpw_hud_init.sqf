0 = [
		[1,100], // Min/max range of goggles
		[1,1,1], // HUD colour
		[1,1,1], // Friendly colour
		[1,1,1], // Enemy units colour
		[1,1,1], // Civ colour
		[1,1,1], // Squad and marker colour
		0.9, 			// Initial HUD brightness
		[1,0.52,0.5,1], // ASL where 1 = active ( 0 = inactive), 0.4 = X position, 0.4 = Y position, 1 = text size
		[1,0.63,0.5,1], // AZT
		[1,0.40,0.5,1], // GRD
		[1,0.63,0.6,1], // LMT
		[1,0.52,0.6,1], // WND
		[1,0.52,0.4,1], // HLT
		[1,0.40,0.6,1], // RNG
		[1,0.63,0.4,1], // HBT
		[1,0.40,0.4,1], // PRX
		[1,0.25,0.1,0.5], // UNITS where 1 = active ( 0 = inactive), 1 = icon max size, 0.25 = icon min size, 0.5 = text size ( 1 = same size as HUD text)
		[0.37,0.22], 	  //HUD offset [x,y] -1 to 1
		0.5, // HUD scale. > 1 = larger
		1, // Text scale. > 1 = larger
		1, // HUD distance degradation. 0 = no degradation
		0, // No HUD in 3rd person. 1 = HUD in 3rd person
		0, // Add TAC glasses to player's uniform if not present. 0 = don't add
		[24,23,30,29,24,23,30,29,22,20], // ICONS [unit,hidden unit,vehicle,hidden vehicle,enemy unit,hidden enemy unit,enemy vehicle,hidden enemy vehicle,marker,predictor]
		2.5, // Detection range multiplication factor for vehicles (1.5 = 750m max detection range for vehicles vs 500m for units)
		0 // Audible warning when enemies detected
	] execVM "scripts\TPW\tpw_hud.sqf";