// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C
#define ST_GROUP_BOX       96
#define ST_GROUP_BOX2      112
#define ST_ROUNDED_CORNER  ST_GROUP_BOX + ST_CENTER
#define ST_ROUNDED_CORNER2 ST_GROUP_BOX2 + ST_CENTER

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4


////////////////
//Base Classes//
////////////////

class RscText
{
    access = 0;
    idc = -1;
    type = CT_STATIC;
    style = ST_MULTI;
    linespacing = 1;
    colorText[] = {1,1,1,1};
    text = "";
    shadow = 0;
    font = "puristaMedium";
    SizeEx = 0.0400;
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;

};

class RscPicture
{
    access = 0;
    idc = -1;
    type = CT_STATIC;
    style = ST_PICTURE;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    font = "puristaMedium";
    sizeEx = 0;
    lineSpacing = 0;
    text = "";
    fixedWidth = 0;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.15;
};

class RscButton
{

	access = 0;
    type = CT_BUTTON;
    text = "";
	color[] = {1,0,0,1};
    colorText[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.85};
    colorBackground[] = {0,0,0,1};
    colorBackgroundDisabled[] = {0,0,0,0};
    colorBackgroundActive[] = {1,1,1,0.85};
    colorFocused[] = {1,1,1,1};
    colorShadow[] = {0.023529,0,0.0313725,1};
    colorBorder[] = {0.023529,0,0.0313725,1};
	soundEnter[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEnter", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundPush", 0.0, 0};
	soundClick[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundClick", 0.07, 1};
	soundEscape[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEscape", 0.09, 1};
	onMouseEnter = "(_this select 0) ctrlSetTextColor [0, 0, 0, 1]";
	onMouseExit = "(_this select 0) ctrlSetTextColor [1, 1, 1, 1]";
    style = 2;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 0;
    font = "puristaMedium";
    sizeEx = 0.03921;
    offsetX = 0.002;
    offsetY = 0.002;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
};

class RscFrame
{
    type = CT_STATIC;
    idc = -1;
    style = ST_HUD_BACKGROUND;
    shadow = 2;
    colorBackground[] = {1,1,1,1};
    colorText[] = {1,1,1,0.9};
    font = "puristaMedium";
    sizeEx = 0.03;
    text = "";
};

class BOX
{
   type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    shadow = 2;
    colorText[] = {1,1,1,1};
    font = "puristaMedium";
    sizeEx = 0.02;
    colorBackground[] = { 0.2,0.2,0.2, 0.9 };
    text = "";

};

class RscCombo {
idc = -1;
type = 4;
style = 1;
x = 0;
y = 0;
w = 0.3;
h = 0.035;

arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";
wholeHeight = 0.45;
color[] = {0, 0, 0, 0.6};
colorDisabled[] = {};
colorActive[] = {0, 0, 0, 1};
font = "puristaMedium";
sizeEx = 0.031;
soundSelect[] = {"\ca\ui\data\sound\new1", 0.09, 1};
soundExpand[] = {"\ca\ui\data\sound\new1", 0.09, 1};
soundCollapse[] = {"\ca\ui\data\sound\new1", 0.09, 1};
maxHistoryDelay = 1.0;

class ComboScrollBar {
color[] = {0, 0, 0, 1};
colorDisabled[] = {};
colorActive[] = {1, 1, 1, 1};
thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
border = "\ca\ui\data\ui_border_scroll_ca.paa";
};
};

class RscListbox
	{
		access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
		idc = CT_LISTBOX; // Control identification (without it, the control won't be displayed)
		type = CT_LISTBOX; // Type is 5
		style = ST_LEFT + LB_TEXTURES; // Style
		default = 0; // Control selected by default (only one within a display can be used)
		blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
		colorBackground[] = {0.2,0.2,0.2,1}; // Fill color
		colorSelectBackground[] = {1,1,1,1}; // Selected item fill color
		colorSelectBackground2[] = {1,1,1,1}; // Selected item fill color (oscillates between this and colorSelectBackground)
		sizeEx = 0.0422; // Text size
		font = "puristaMedium"; // Font from CfgFontFamilies
		shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
		colorText[] = {1,1,1,1}; // Text and frame color
		colorDisabled[] = {1,1,1,0.5}; // Disabled text color
		colorSelect[] = {0,0,0,1}; // Text selection color
		colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
		colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)
		pictureColor[] = {1,0.5,0,1}; // Picture color
		pictureColorSelect[] = {1,1,1,1}; // Selected picture color
		pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color
		tooltip = ""; // Tooltip text
		tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
		tooltipColorText[] = {1,1,1,1}; // Tooltip text color
		tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color
		colorScrollbar[] = {0.4,0.11,0,1};
		period = 0; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected
		rowHeight = 0.03; // Row height
		itemSpacing = 0; // Height of empty space between items
		maxHistoryDelay = 1; // Time since last keyboard type search to reset it
		canDrag = 1; // 1 (true) to allow item dragging
		soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected
		// Scrollbar configuration (applied only when LB_TEXTURES style is used)
		class ListScrollBar //In older games this class is "ScrollBar"
			{
				width = 0; // width of ListScrollBar
				height = 0; // height of ListScrollBar
				scrollSpeed = 0.01; // scroll speed of ListScrollBar
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)
				color[] = {1,1,1,1}; // Scrollbar color
			};
	};

class RscXListNBox
		{
			access = 0;
			idc = CT_XLISTBOX;
			type = CT_XLISTBOX;
			style = SL_HORZ + ST_CENTER + LB_TEXTURES;
			default = 0;
			blinkingPeriod = 0;
			x = 12 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
			y = 17 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			color[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			font = "PuristaMedium";
			shadow = 0;
			colorText[] = {1,1,1,1}; // Text color
			colorSelect[] = {1,1,1,1}; // Selected text color
			colorDisabled[] = {1,1,1,0.5}; // Disabled text color
			tooltip = ""; // Tooltip text
			tooltipColorShade[] = {0,0,0,0}; // Tooltip background color
			tooltipColorText[] = {1,1,1,0}; // Tooltip text color
			tooltipColorBox[] = {1,1,1,0}; // Tooltip frame color
			arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa"; // Arrow
			arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa"; // Arrow when clicked on
			border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa"; // Fill texture
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
		};

class RscListNBox
	{
		access = 0; // allow alterations / additions to, but not erasure of, tokennames in this class.
					 // this equally affects child classes. they cannot be removed, nor can their tokenNames be erased, only altered
					 // to completely remove or alter a child class (in this case scrollbar), this parent class must be inherited
					 // then again, perhaps irrelevant, perhaps it's simply being a root class that causes all this
		/*
		** standard stuff
		*/
		type = CT_LISTNBOX;// 102;
		style = ST_STATIC;
		w = 0.4;   h = 0.4;
		font = "puristaMedium";
		sizeEx = 0.04;
		colorText[] = {1, 1, 1, 1};
		colorBackground[] = {0,0,0,1};
		/*
		** type specific
		*/
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
		columns[] = {0.3, 0.6, 0.7};
		color[] = {1, 1, 1, 1};
		colorScrollbar[] = {0.95, 0.95, 0.95, 1};
		colorSelect[] = {1, 1, 1, 1};
		colorSelect2[] = {1, 1, 1, 1};
		colorSelectBackground[] = {0, 0, 0, 1};
		colorSelectBackground2[] = {0, 0, 0, 1};
		colorDisabled[] = {1,0,0,0.5};
		drawSideArrows = 0;
		idcLeft = -1;
		idcRight = -1;
		maxHistoryDelay = 1;
		rowHeight = 0;
		soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected
		period = 0;
		shadow = 0;
		class listScrollBar
			{
				arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
				arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
				border = "#(argb,8,8,3)color(1,1,1,1)";
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(1,1,1,1)";
			};
	};