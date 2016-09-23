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

class LargeAnalogInfoField extends Field
{
	var largeAnalogClock;
	
    function initialize(_settings)
    {
        settings = _settings;
        largeAnalogClock = new LargeAnalogField(_settings);
    }

    function draw(loc)
    {
    	var actInfo = Act.getInfo();
    	var stats = Sys.getSystemStats();
    
    	settings.dc.setColor(settings.intermediateColor, Gfx.COLOR_TRANSPARENT);
    	settings.dc.drawText(settings.fieldWidth/2, settings.fieldHeight*3/4, Gfx.FONT_XTINY, "STEPS", Gfx.TEXT_JUSTIFY_CENTER);
    	settings.dc.drawText(settings.fieldWidth+settings.fieldWidth/2, settings.fieldHeight*3/4, Gfx.FONT_XTINY, "GOAL", Gfx.TEXT_JUSTIFY_CENTER);
    	settings.dc.drawText(settings.fieldWidth, settings.fieldHeight*5/4, Gfx.FONT_XTINY, "BATT", Gfx.TEXT_JUSTIFY_CENTER);
    	
    	settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
    	settings.dc.drawText(settings.fieldWidth/2, settings.fieldHeight*3/4+15, Gfx.FONT_SMALL, actInfo.steps, Gfx.TEXT_JUSTIFY_CENTER);
    	settings.dc.drawText(settings.fieldWidth+settings.fieldWidth/2, settings.fieldHeight*3/4+15, Gfx.FONT_SMALL, actInfo.stepGoal, Gfx.TEXT_JUSTIFY_CENTER);
    	settings.dc.drawText(settings.fieldWidth, settings.fieldHeight*5/4+15, Gfx.FONT_SMALL, stats.battery.format("%.0f"), Gfx.TEXT_JUSTIFY_CENTER);
    	
    	largeAnalogClock.draw(loc);
    }
}