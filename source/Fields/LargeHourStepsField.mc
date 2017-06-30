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

class LargeHourStepsField extends Field
{
    function initialize(_settings)
    {
        settings = _settings;
    }

    function draw(loc)
    {
        var hour = Sys.getClockTime().hour;
        if(!Sys.getDeviceSettings().is24Hour)
        {
            hour = hour%12;
        }
        
        // Actual height of the characters
        var charWidth = settings.dc.getTextDimensions(hour.format("%02.f"), NumberThaiXtremeHot)[0]; 
        var charHeight = settings.dc.getTextDimensions(hour.format("%02.f"), NumberThaiXtremeHot)[1];
        
        // total space left in field after adding char 
        var spaceWidth = (2*settings.fieldWidth)-charWidth;
        var spaceHeight = (2*settings.fieldHeight)-charHeight;
        
        // center the char in the field
        var paddingX = spaceWidth/2;
        var paddingY = spaceHeight/2;

        //draw filled rectangle to represent text’s color (add 1 pixel for rounding errs (Y))
        settings.dc.setColor(settings.foreColor, settings.foreColor);
        settings.dc.fillRectangle(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY+1, 2*settings.fieldWidth-spaceWidth, 2*settings.fieldHeight-spaceHeight);

        var actInfo = Act.getInfo();
        var goalPerc = (actInfo.steps.toFloat() / actInfo.stepGoal.toFloat()) * 100;

        if (goalPerc > 100) {
            goalPerc = 100;
        }

        // Percentage of the char that needs to be colored in pixels:
        //var charPerc = (charHeight / 100) * goalPerc;
        var charPerc = Math.round((charHeight.toFloat()/100)* goalPerc.toFloat());
        if(DEBUG) {
            System.println( "charHeight=" + charHeight);
            System.println( "charWidth=" + charWidth);
            System.println( "charPerc=" + charPerc);
        }
        var startY = settings.fieldXY[loc][1] + paddingY+1;
        var effectY = startY + ( charHeight - charPerc); //((charHeight+paddingY)-charPerc); // (add 1 pixel for rounding errs (Y))
        var effectHeight = charPerc;
        
        //draw filled rectangle to represent water level 
        settings.dc.setColor(settings.hourStepsColor, settings.hourStepsColor);
        settings.dc.fillRectangle(settings.fieldXY[loc][0]+paddingX, effectY, 2*settings.fieldWidth-spaceWidth, effectHeight);
        
        settings.dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        var hourString = hour.format("%02.f");
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY, NumberThaiXtremeHot, hourString, Gfx.TEXT_JUSTIFY_LEFT);        
    }
}