using Toybox.Graphics as Gfx;
using Toybox.Lang as Lang;
using Toybox.Math as Math;
using Toybox.System as Sys;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Calendar;
using Toybox.WatchUi as Ui;
using Toybox.ActivityMonitor as Act;
using Toybox.Application as App;
using Toybox.Communications as Comm;
using Toybox.Activity as Activity;

class Settings
{
	const FIELD_EMPTY			= 0;
	const FIELD_HOUR 			= 1;
	const FIELD_MIN 			= 2;
	const FIELD_HOUR_LARGE 		= 3;
	const FIELD_MIN_LARGE 		= 4;
	const FIELD_ANA 			= 5;
	const FIELD_ANA_LARGE 		= 6;
	const FIELD_ANA_INFO_LARGE 	= 7;
	const FIELD_STEPS 			= 8;
	const FIELD_STEPS_INFO 		= 9;
	const FIELD_DATE 			= 10;
	const FIELD_DEV_INFO		= 11;
	const FIELD_DATE_DEV_INFO	= 12;
	const FIELD_BATT 			= 13;
	const FIELD_SUN 			= 14;
	
	/*
	These are the settings used throughout the entire watchface app.
	Using this settings class wraps the properties and ensure a variable is not loaded more than once.
	Comments represent: type - default
	*/
	var location;		// [lat, long] - [50.848738, 4.732230]
	var foreColor;		// Color - 0xFFFFFF
	var backColor;		// Color - 0x000000
	var intermediateColor;		// Color - 0xCCCCCC
	var iconsColored;	// Boolean - TRUE
	var displayOrientation; // Number - 1 (0=undefined, 1=landscape, 2=portrait)
	var fieldWidth;		// Number - 68
	var fieldHeight;	// Number - 74
	var fieldLayout;	// [0, 1, 2, 3, 4, 5] - []
	var isAwake;		// Boolean - FALSE
	var fieldXY; // [[X,Y], [X,Y], [X,Y], [X,Y], [X,Y], [X,Y]] - default is calculated based on display size
	var dc;
	
    function initialize() {
    	location = [getFloatProperty("LocationLatitude", 50.848738), getNumberProperty("LocationLongitude", 4.732230)];
    	foreColor = getNumberProperty("ForegroundColor", 0xFFFFFF);
    	backColor = getNumberProperty("BackgroundColor", 0x000000);
    	intermediateColor = getNumberProperty("IntermediateColor", 0xFFFFFF);
    	iconsColored = getBooleanProperty("IconsColored", true);
    	displayOrientation = 1;
    	isAwake = false;
    	fieldLayout = [0, 0, 0, 0, 0, 0];
    }
    
    function calculateFieldXY() {
    	fieldXY = new[6];
    	
    	for(var i=0; i<6; i++) {
    		fieldXY[i] = [0, 0];
    		if(displayOrientation == 1)
	        {
	        	Sys.println(fieldXY);
	        	Sys.println(fieldXY[i]);
	        	Sys.println(i);
	        	Sys.println(fieldWidth);
	            fieldXY[i][0] = (i%3)*fieldWidth;
	            fieldXY[i][1] = (i>2?1:0)*fieldHeight;
	        }
	        else
	        {
	            fieldXY[i][0] = (i>2?1:0)*fieldWidth;
	            fieldXY[i][1] = (i%3)*fieldHeight;
	        }
    	}
    }
    
    function setField(fieldNr, fieldId) {
    	if      (fieldId == FIELD_HOUR)             { fieldLayout[fieldNr] = new HourField(self); }
        else if (fieldId == FIELD_MIN)              { fieldLayout[fieldNr] = new MinuteField(self); }
        else if (fieldId == FIELD_HOUR_LARGE)       { fieldLayout[fieldNr] = new LargeHourField(self); }
        else if (fieldId == FIELD_MIN_LARGE)        { fieldLayout[fieldNr] = new LargeMinuteField(self); }
        else if (fieldId == FIELD_ANA)              { fieldLayout[fieldNr] = new AnalogField(self); }
        else if (fieldId == FIELD_ANA_LARGE)        { fieldLayout[fieldNr] = new LargeAnalogField(self); }
        else if (fieldId == FIELD_ANA_INFO_LARGE)   { fieldLayout[fieldNr] = new LargeAnalogInfoField(self); }
        else if (fieldId == FIELD_STEPS)            { fieldLayout[fieldNr] = new StepsField(self); }
        else if (fieldId == FIELD_STEPS_INFO)       { fieldLayout[fieldNr] = new StepsInfoField(self); }
        else if (fieldId == FIELD_DATE)             { fieldLayout[fieldNr] = new DateField(self); }
        else if (fieldId == FIELD_DEV_INFO)         { fieldLayout[fieldNr] = new DeviceInfoField(self); }
        else if (fieldId == FIELD_DATE_DEV_INFO)    { fieldLayout[fieldNr] = new DateDeviceInfoField(self); }
        else if (fieldId == FIELD_BATT)             { fieldLayout[fieldNr] = new BatteryGaugeField(self); }
        else if (fieldId == FIELD_SUN)              { fieldLayout[fieldNr] = new SunRiseSunSetField(self); }
        else                                        { fieldLayout[fieldNr] = new EmptyField(self); }
    }
    
    function setProperty(name, val) {
        App.getApp().setProperty(name, val);
    }

    function getProperty(name, initial) {
        var val = App.getApp().getProperty(name);
        if (val != null) {
            return val;
        }

        return initial;
    }

    function deleteProperty(name) {
        App.getApp().deleteProperty(name);
    }

    function clearProperties() {
        App.getApp().clearProperties();
    }

    function getStringProperty(key, initial) {
        var value = App.getApp().getProperty(key);
        if (value != null) {

            if (value instanceof Lang.String) {
                return value;
            }
            else if (value instanceof Lang.Double ||
                     value instanceof Lang.Float ||
                     value instanceof Lang.Long ||
                     value instanceof Lang.Number) {
                return value.toString();
            }
        }

        return initial;
    }

    function setStringProperty(key, value) {
        //assert(value instanceof Lang.String);
        App.getApp().setProperty(key, value);
    }

    function getBooleanProperty(key, initial) {
        var value = App.getApp().getProperty(key);
        if (value != null) {

            if (value instanceof Lang.Boolean) {
                return value;
            }
            else if (value instanceof Lang.Double ||
                     value instanceof Lang.Float ||
                     value instanceof Lang.Long ||
                     value instanceof Lang.Number ||
                     value instanceof Lang.String) {
                return value.toNumber() != 0;
            }
        }

        return initial;
    }

    function setBooleanProperty(key, value) {
        //assert(value instanceof Lang.Boolean);
        App.getApp().setProperty(key, value);
    }

    function getNumberProperty(key, initial) {
        var value = App.getApp().getProperty(key);
        if (value != null) {

            if (value instanceof Lang.Number) {
                return value;
            }
            else if (value instanceof Lang.Boolean) {
                return value ? 1 : 0;
            }
            else if (value instanceof Lang.Double ||
                     value instanceof Lang.Float ||
                     value instanceof Lang.Long ||
                     value instanceof Lang.String) {
                return value.toNumber();
            }
        }

        return initial;
    }

    function setNumberProperty(key, value) {
        //assert(value instanceof Lang.Number);
        App.getApp().setProperty(key, value);
    }

    function getFloatProperty(key, initial) {
        var value = App.getApp().getProperty(key);
        if (value != null) {

            if (value instanceof Lang.Float) {
                return value;
            }
            else if (value instanceof Lang.String) {
                return value.toFloat();
            }
            else if (value instanceof Lang.Boolean) {
                return value ? 1.0f : 0.0f;
            }
            else if (value instanceof Lang.Double ||
                     value instanceof Lang.Long ||
                     value instanceof Lang.Number) {
                return value.toFloat();
            }
        }

        return initial;
    }

    function setFloatProperty(key, value) {
        //assert(value instanceof Lang.Float);
        App.getApp().setProperty(key, value);
    }
}