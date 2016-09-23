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

class SunRiseSunSetField extends Field
{
    var sunRiseSet;

    function initialize(_settings)
    {
        settings = _settings;
        sunRiseSet = new SunRiseSunSet();
    }

    function draw(loc)
    {
        var paddingX = (settings.fieldWidth-50)/2;
        var paddingY = 0;

        var sunRise = sunRiseSet.computeSunrise(true)/1000/60/60;
        var sunSet = sunRiseSet.computeSunrise(false)/1000/60/60;

        var sunRiseStr = Lang.format("$1$:$2$", [Math.floor(sunRise).format("%02.0f"), Math.floor((sunRise-Math.floor(sunRise))*60).format("%02.0f")]);
        var sunSetStr = Lang.format("$1$:$2$", [Math.floor(sunSet).format("%02.0f"), Math.floor((sunSet-Math.floor(sunSet))*60).format("%02.0f")]);

        // Draw text
        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        //dc.drawText(fieldXY[0]+fieldWidth-paddingX-dc.getTextWidthInPixels(batPct+"%", Gfx.FONT_SMALL), fieldXY[1]+paddingY, Gfx.FONT_SMALL, batPct+"%", Gfx.TEXT_JUSTIFY_LEFT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth-paddingX-settings.dc.getTextWidthInPixels(sunRiseStr, Gfx.FONT_SMALL), settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3+1, Gfx.FONT_SMALL, sunRiseStr, Gfx.TEXT_JUSTIFY_LEFT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth-paddingX-settings.dc.getTextWidthInPixels(sunSetStr, Gfx.FONT_SMALL), settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+2, Gfx.FONT_SMALL, sunSetStr, Gfx.TEXT_JUSTIFY_LEFT);
        
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
        */
        if(settings.iconsColored)
    	{
        	settings.dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
        }
        else
        {
        	settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        }
        //dc.drawText(fieldXY[0]+fieldWidth/2, fieldXY[1]+paddingY, symbols, "y", Gfx.TEXT_JUSTIFY_CENTER); //s, a
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/2, settings.fieldXY[loc][1]+paddingY, symbols, "|", Gfx.TEXT_JUSTIFY_CENTER); //s, a
        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/2, settings.fieldXY[loc][1]+paddingY, symbols, "}", Gfx.TEXT_JUSTIFY_CENTER); //s, a
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3+1, symbols, "z", Gfx.TEXT_JUSTIFY_LEFT); //^, s
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+2, symbols, "{", Gfx.TEXT_JUSTIFY_LEFT); //v, r
    }
}