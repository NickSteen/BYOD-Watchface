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

class BatteryGaugeField extends Field
{
    var battGauge;

    function initialize(_settings)
    {
        settings = _settings;
        battGauge = new BatteryGauge();
    }

    function draw(loc)
    {
        battGauge.update();

        var paddingX = (settings.fieldWidth-50)/2;
        var paddingY = 0;
        var stats = Sys.getSystemStats();
        var sets = Sys.getDeviceSettings();

        var batPct = stats.battery.format("%.0f");

        // Draw text
        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth-paddingX-settings.dc.getTextWidthInPixels(batPct+"%", Gfx.FONT_SMALL), settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3+1, Gfx.FONT_SMALL, batPct+"%", Gfx.TEXT_JUSTIFY_LEFT);
        //dc.drawText(fieldXY[0]+fieldWidth-paddingX-dc.getTextWidthInPixels(battGauge.getBatteryDropString(), Gfx.FONT_SMALL), fieldXY[1]+paddingY+fieldHeight/3+1, Gfx.FONT_SMALL, /*battGauge.getBatteryDropString()*/, Gfx.TEXT_JUSTIFY_LEFT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth-paddingX-settings.dc.getTextWidthInPixels(battGauge.getBatterySpanString(), Gfx.FONT_SMALL), settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+2, Gfx.FONT_SMALL, battGauge.getBatterySpanString(), Gfx.TEXT_JUSTIFY_LEFT);
        
        // Draw lines
        settings.dc.setColor(settings.intermediateColor, Gfx.COLOR_TRANSPARENT);
        //dc.drawLine(fieldXY[0]+paddingX, fieldXY[1]+paddingY+fieldHeight/3-2, fieldXY[0]+fieldWidth-paddingX, fieldXY[1]+paddingY+fieldHeight/3-2);
        settings.dc.drawLine(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2-1, settings.fieldXY[loc][0]+settings.fieldWidth-paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2-1);

        // Draw icons
        /*
        g = Step goal
        c = Calories burned
        d = Covered distance
        b = Battery / B = Large battery
        n = Notifications / N = Large notifications
        a = Alarms
        s = sunrise-sunset
        ^ = arrow up
        v = arrow down
        w = work
        h = home
        i = ideal (best) time to leave
        1 = <=20%, 2 = >20% <=40%, 3 = >40% <=60%, 4 = >60% <=80%, 5 = >80%
        */
        var btPctIcon = (Math.ceil(stats.battery/20)).format("%.0f");
        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        //dc.drawText(fieldXY[0]+fieldWidth/2, fieldXY[1]+paddingY, Gfx.FONT_SMALL, btPctIcon, Gfx.TEXT_JUSTIFY_CENTER);
        //dc.drawText(fieldXY[0]+fieldWidth/2, fieldXY[1]+paddingY, symbols, "D", Gfx.TEXT_JUSTIFY_CENTER);
        if(settings.iconsColored)
    	{
        	settings.dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
        }
        else
        {
        	settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        }
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3+1, symbols, "E", Gfx.TEXT_JUSTIFY_LEFT);
        if(settings.iconsColored)
    	{
        	settings.dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
        }
        else
        {
        	settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        }
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+2, symbols, "G", Gfx.TEXT_JUSTIFY_LEFT);

        /*if(stats.battery<10)
        {
            dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        }
        else
        {
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        }
        dc.fillRectangle(fieldXY[0]+paddingX+3, fieldXY[1]+6, stats.battery*39/100, 11);*/

        if(stats.battery<10)
        {
            settings.dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
        }
        else
        {
            settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        }
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/2, settings.fieldXY[loc][1]+paddingY, symbols, "D", Gfx.TEXT_JUSTIFY_CENTER);
        settings.dc.fillRectangle(settings.fieldXY[loc][0]+paddingX+3, settings.fieldXY[loc][1]+6, stats.battery*39/100, 11);
    }
}