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

class LargeAnalogField extends Field
{
    function initialize(_settings)
    {
        settings = _settings;
    }

    function draw(loc)
    {
        var paddingX = 1;
        var paddingY = -1;
        var time = Sys.getClockTime();

        var boundary = settings.fieldWidth>settings.fieldHeight?2*settings.fieldHeight:2*settings.fieldWidth;

        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        for(var i = 0.0; i<Math.PI*2; i+=Math.PI*2/12)
        {
            settings.dc.fillRectangle(settings.fieldXY[loc][0]+2*settings.fieldWidth/2+paddingX+(boundary/2.1)*Math.sin(i), settings.fieldXY[loc][1]+2*settings.fieldHeight/2+paddingY+(boundary/2.1)*Math.cos(i), 2, 2);
        }
        for(var i = 0.0; i<Math.PI*2; i+=Math.PI*2/4)
        {
            settings.dc.fillRectangle(settings.fieldXY[loc][0]+2*settings.fieldWidth/2+paddingX+(boundary/2.1)*Math.sin(i)-2, settings.fieldXY[loc][1]+2*settings.fieldHeight/2+paddingY+(boundary/2.1)*Math.cos(i)-2, 4, 4);
        }

        var hourWidth = 4;
        var minuteWidth = 2;

        // Draw the hour. Convert it to minutes and compute the angle.
        var hourHand = (((time.hour % 12) * 60) + time.min);
        hourHand = hourHand / (12 * 60.0);
        hourHand = hourHand * Math.PI * 2;
        drawHand(settings.dc, hourHand, 2*settings.fieldWidth/5, hourWidth, 2*settings.fieldWidth, 2*settings.fieldHeight, settings.fieldXY[loc]);
        // Draw the minute
        var minuteHand = (time.min / 60.0) * Math.PI * 2;
        drawHand(settings.dc, minuteHand, 2*settings.fieldWidth/8*3, minuteWidth, 2*settings.fieldWidth, 2*settings.fieldHeight, settings.fieldXY[loc]);
    }

    function drawHand(dc, angle, length, width, fieldWidth, fieldHeight, fieldXY)
    {
        // Map out the coordinates of the watch hand
        var coords = [  [-(width / 2), 1],
                        [-(width / 2), -length],
                        [width / 2, -length],
                        [width / 2, 1]
                     ];
        var result = new [4];
        var centerX = fieldXY[0]+fieldWidth/2;
        var centerY = fieldXY[1]+fieldHeight/2;
        var cos = Math.cos(angle);
        var sin = Math.sin(angle);

        // Transform the coordinates
        for (var i = 0; i < 4; i += 1)
        {
            var x = (coords[i][0] * cos) - (coords[i][1] * sin);
            var y = (coords[i][0] * sin) + (coords[i][1] * cos);
            result[i] = [centerX + x, centerY + y];
        }

        // Draw the polygon
        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.fillPolygon(result);
    }
}