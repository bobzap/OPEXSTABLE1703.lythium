#include "resource.h"

class VVS_Menu
{
	idd = VVS_Menu_IDD;
	name = "VVS_Menu";
	movingEnabled = false;
	enableSimulation = true;
	onLoad = "[] spawn VVS_fnc_mainDisplay;";
	
	class controlsBackground
	{
		class titleBackground : VVS_RscText
		{
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			x = 0.1;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};
		
		class MainBackground : VVS_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.76};
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.8;
			h = 0.6 - (22 / 250);
		};
		
			/*	
		class Footer : VVS_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.8};
			x = 0.1;
			y = 0.805;
			w = 0.8;
			h = (1 / 25);
		};
		

		class ClearCargoText : VVS_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0};
			text = $STR_vvs_clearCargo;
			sizeEx = 0.04;
			x = 0.105;
			y = 0.805;
			w = 0.8;
			h = (1 / 25);
		};
		
		class CargoCheck : VVS_RscActiveText 
		{
			idc = VVS_CargoCheck;
			text = $STR_no
			action = "[] call VVS_fnc_checkBox";
			sizeEx = 0.04;
// def 2015 09 19>
			colorDisabled[] = {1, 1, 1, 0.3};
// <def 2015 09 19
			x = 0.32; y = 0.805;
			w = 0.275; h = 0.04;
		};
		*/
		
		class Title : VVS_RscTitle
		{
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = $STR_vvs_title;
			x = 0.1;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};
	};
	
	class controls
	{
		class vehicleListNew : VVS_RscListNBox
		{
			idc = VVS_VehicleList;
			text = "";
			sizeEx = 0.04;
			columns[] = {0,0.105,0.5,0.8};
			drawSideArrows = false;
			idcLeft = -1;
			idcRight = -1;
			rowHeight = 0.050;
			x = 0.1; y = 0.26;
			w = 0.8; h = 0.49 (22 / 250);
		};
		
		class FilterList : VVS_RscCombo
		{
			idc = VVS_FilterList;
			colorBackground[] = {0,0,0,0.7};
			onLBSelChanged  = "_this call VVS_fnc_filterList";
			x = 0.244 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = 0.34; h = (1 / 25);
		};
		
		class ButtonClose : VVS_RscButtonMenu 
		{
			idc = -1;
			text = $STR_close;
			onButtonClick = "closeDialog 0;";
			x = 0.1;
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class ButtonSettings : VVS_RscButtonMenu 
		{
			idc = -1;
			text = $STR_vvs_spawn;
			onButtonClick = "[] spawn VVS_fnc_spawnVehicle";
			x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
	};
};