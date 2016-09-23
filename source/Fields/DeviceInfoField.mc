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

class DeviceInfoField extends Field
{
    function initialize(_settings)
    {
        settings = _settings;
    }

    function draw(loc)
    {
        var paddingX = (settings.fieldWidth-50)/2;
        var paddingY = 0;
        var stats = Sys.getSystemStats();
        var sets = Sys.getDeviceSettings();

        var batPct = stats.battery.format("%.0f");

        // Draw text
        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth-paddingX-settings.dc.getTextWidthInPixels(batPct+"%", Gfx.FONT_SMALL), settings.fieldXY[loc][1]+paddingY, Gfx.FONT_SMALL, batPct+"%", Gfx.TEXT_JUSTIFY_LEFT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth-paddingX-settings.dc.getTextWidthInPixels(sets.notificationCount.toString(), Gfx.FONT_SMALL), settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3+1, Gfx.FONT_SMALL, sets.notificationCount.toString(), Gfx.TEXT_JUSTIFY_LEFT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth-paddingX-settings.dc.getTextWidthInPixels(sets.alarmCount.toString(), Gfx.FONT_SMALL), settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+2, Gfx.FONT_SMALL, sets.alarmCount.toString(), Gfx.TEXT_JUSTIFY_LEFT);
        
        // Draw lines
        settings.dc.setColor(settings.intermediateColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawLine(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3-2, settings.fieldXY[loc][0]+settings.fieldWidth-paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3-2);
        settings.dc.drawLine(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2-1, settings.fieldXY[loc][0]+settings.fieldWidth-paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2-1);

        // Draw icons
        /*
        g = Step goal
        c = Calories burned
        d = Covered distance
        b = Battery / B = Large battery
        n = Notifications / N = Large notifications
        a = Alarms
        */
        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY, symbols, "b", Gfx.TEXT_JUSTIFY_LEFT); //b
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3+1, symbols, "k", Gfx.TEXT_JUSTIFY_LEFT); //n
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+2, symbols, "f", Gfx.TEXT_JUSTIFY_LEFT); //a
    }
}