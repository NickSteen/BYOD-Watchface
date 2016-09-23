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

class StepsInfoField extends Field
{
    function initialize(_settings)
    {
        settings = _settings;
    }

    function draw(loc)
    {
    	Sys.println("INIT");
        var paddingX = (settings.fieldWidth-50)/2;
        var paddingY = 0;
        var actInfo = Act.getInfo();
        var distWalked = (actInfo.distance/100000.0).format("%.2f");
		Sys.println("DRAW TEXT");
        // Draw text
        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth-paddingX-settings.dc.getTextWidthInPixels(actInfo.stepGoal.toString(), Gfx.FONT_SMALL), settings.fieldXY[loc][1]+paddingY, Gfx.FONT_SMALL, actInfo.stepGoal.toString(), Gfx.TEXT_JUSTIFY_LEFT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth-paddingX-settings.dc.getTextWidthInPixels(actInfo.calories.toString(), Gfx.FONT_SMALL), settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3+1, Gfx.FONT_SMALL, actInfo.calories.toString(), Gfx.TEXT_JUSTIFY_LEFT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth-paddingX-settings.dc.getTextWidthInPixels(distWalked, Gfx.FONT_SMALL), settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+2, Gfx.FONT_SMALL, /*(actInfo.distance/100000.0).toString()*/distWalked, Gfx.TEXT_JUSTIFY_LEFT);
		Sys.println("DRAW LINES");
        // Draw lines
        settings.dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawLine(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3-2, settings.fieldXY[loc][0]+settings.fieldWidth-paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3-2);
        settings.dc.drawLine(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2-1, settings.fieldXY[loc][0]+settings.fieldWidth-paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2-1);
		
        // Draw icons
        /*
        g = Step goal
        c = Calories burned
        d = Covered distance
        b = Battery
        n = Notifications
        a = Alarms
        */
		Sys.println("DRAW ICONS");
        //var typicons22Fnt = Ui.loadResource(Rez.Fonts.typicons22);
        if(settings.iconsColored)
        {
	        if(actInfo.steps > actInfo.stepGoal)
	        {
	            settings.dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
	        }
	        else
	        {
	            settings.dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
	        }
        }
        else
        {
        	settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        }
        //dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY, symbols, "A", Gfx.TEXT_JUSTIFY_LEFT); //g, s, r
        if(settings.iconsColored)
        {
        	settings.dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
        }
        else
        {
        	settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        }
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3+1, symbols, "C", Gfx.TEXT_JUSTIFY_LEFT); //c, h
        if(settings.iconsColored)
        {
        	settings.dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
        }
        else
        {
        	settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        }
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+2, symbols, "B", Gfx.TEXT_JUSTIFY_LEFT); //d, j
        Sys.println("DRAW DONE");
    }
}