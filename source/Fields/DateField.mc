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

class DateField extends Field
{
    function initialize(_settings)
    {
        settings = _settings;
    }

    function draw(loc)
    {
        var paddingX = 0;
        var paddingY = 0;
        var date = Calendar.info(Time.now(), Time.FORMAT_LONG);

        settings.dc.setColor(settings.intermediateColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/2, settings.fieldXY[loc][1]+paddingY, Gfx.FONT_SMALL, date.day_of_week.toUpper(), Gfx.TEXT_JUSTIFY_CENTER);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/2, settings.fieldXY[loc][1]+paddingY+settings.fieldHeight/3*2+3, Gfx.FONT_SMALL, date.month.toUpper(), Gfx.TEXT_JUSTIFY_CENTER);
        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawText(settings.fieldXY[loc][0]+settings.fieldWidth/2, settings.fieldXY[loc][1]+paddingY+17, Gfx.FONT_NUMBER_HOT, date.day, Gfx.TEXT_JUSTIFY_CENTER);
    }
}