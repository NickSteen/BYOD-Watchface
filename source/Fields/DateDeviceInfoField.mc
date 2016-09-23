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

class DateDeviceInfoField extends Field
{
    function initialize(_settings)
    {
        settings = _settings;
    }

    function draw(loc)
    {
        var paddingX = 0;
        var paddingY = 0;
        var stats = Sys.getSystemStats();
        var sets = Sys.getDeviceSettings();
        var batPct = stats.battery.format("%.0f");
        var date = Calendar.info(Time.now(), Time.FORMAT_LONG);
        var dayOfWeekStr = date.day_of_week.toUpper();
        if(dayOfWeekStr.length()>3)
        {
            dayOfWeekStr = dayOfWeekStr.substring(0, 3);
        }

        // Draw date
        settings.dc.setColor(settings.intermediateColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/3*2/2, settings.fieldXY[loc][1]+paddingY-1, Gfx.FONT_XTINY, dayOfWeekStr, Gfx.TEXT_JUSTIFY_CENTER);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/3*2/2, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+6, Gfx.FONT_XTINY, date.month.toUpper(), Gfx.TEXT_JUSTIFY_CENTER);
        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/3*2/2, settings.fieldXY[loc][1]+(settings.fieldHeight-settings.dc.getTextDimensions(date.day.toString(), Gfx.FONT_NUMBER_HOT)[1])/2, Gfx.FONT_NUMBER_HOT, date.day, Gfx.TEXT_JUSTIFY_CENTER);

        // Draw battery and notifications
        //dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        //dc.drawText(fieldXY[0]+fieldWidth/6*4+5, fieldXY[1]+paddingY+17, Gfx.FONT_SMALL, sets.alarmCount, Gfx.TEXT_JUSTIFY_CENTER);
        //dc.drawText(fieldXY[0]+fieldWidth/6*4+5, fieldXY[1]+paddingY+fieldHeight/3*2+3, Gfx.FONT_SMALL, sets.notificationCount, Gfx.TEXT_JUSTIFY_CENTER);

        // Draw icons
        /*
        g = Step goal
        c = Calories burned
        d = Covered distance
        b = Battery / B = Large battery
        n = Notifications / N = Large notifications
        a = Alarms
        */
        //symbols
        if(sets.phoneConnected)
        {
        	if(settings.iconsColored)
        	{
            	settings.dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
            }
            else
            {
            	settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
            }
        }
        else
        {
            settings.dc.setColor(settings.intermediateColor, Gfx.COLOR_TRANSPARENT);
        }
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/6*4+9, settings.fieldXY[loc][1]+paddingY-1, symbols, "I", Gfx.TEXT_JUSTIFY_CENTER); //b

        if(sets.alarmCount>0)
        {
        	if(settings.iconsColored)
        	{
            	settings.dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
            }
            else
            {
	            settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
            }
        }
        else
        {
            settings.dc.setColor(settings.intermediateColor, Gfx.COLOR_TRANSPARENT);
        }
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/6*4+9, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/4-2, symbols, "H", Gfx.TEXT_JUSTIFY_CENTER); //b

        if(sets.notificationCount>0)
        {
        	if(settings.iconsColored)
        	{
            	settings.dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
            }
            else
            {
	            settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
            }
        }
        else
        {
            settings.dc.setColor(settings.intermediateColor, Gfx.COLOR_TRANSPARENT);
        }
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/6*4+9, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/2-5, symbols, "k", Gfx.TEXT_JUSTIFY_CENTER);

        /*if(stats.battery>=90)
        {
            //dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(fieldXY[0]+fieldWidth/6*4+5, fieldXY[1]+paddingY+fieldHeight/3*2+1, symbols, "J", Gfx.TEXT_JUSTIFY_CENTER);
        }
        else if(stats.battery>=75)
        {
            //dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(fieldXY[0]+fieldWidth/6*4+5, fieldXY[1]+paddingY+fieldHeight/3*2+1, symbols, "K", Gfx.TEXT_JUSTIFY_CENTER);
        }
        else if(stats.battery>=50)
        {
            //dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(fieldXY[0]+fieldWidth/6*4+5, fieldXY[1]+paddingY+fieldHeight/3*2+1, symbols, "L", Gfx.TEXT_JUSTIFY_CENTER);
        }
        else if(stats.battery>=20)
        {
            //dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(fieldXY[0]+fieldWidth/6*4+5, fieldXY[1]+paddingY+fieldHeight/3*2+1, symbols, "M", Gfx.TEXT_JUSTIFY_CENTER);
        }
        else
        {
            //dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(fieldXY[0]+fieldWidth/6*4+5, fieldXY[1]+paddingY+fieldHeight/3*2+1, symbols, "N", Gfx.TEXT_JUSTIFY_CENTER);
        }*/
        if(stats.battery<10)
        {
            settings.dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
        }
        else
        {
            settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        }
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/6*4+9, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+1, symbols, "N", Gfx.TEXT_JUSTIFY_CENTER);
        settings.dc.fillRectangle(settings.fieldXY[loc][0]+settings.fieldWidth/3*2-1+4, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+10, stats.battery*11/100, 7);
    }
}