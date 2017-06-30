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
        var stepsBackColor = settings.foreColor;
        var stepsForeColor = settings.hourStepsColor;

        var actInfo = Act.getInfo();
        var goalPerc = (actInfo.steps.toFloat() / actInfo.stepGoal.toFloat()) * 100;
        var displayGoalPerc = goalPerc;
        
        if(settings.stepsAfterFull) {
        //hourStepsColorFull
            if (goalPerc > 200) {
                displayGoalPerc=100;
                stepsBackColor = settings.hourStepsColor;
                stepsForeColor = settings.hourStepsColorFull;
                
             } else if (goalPerc > 100) {
                displayGoalPerc=goalPerc-100;
                stepsBackColor = settings.hourStepsColor;
                stepsForeColor = settings.hourStepsColorFull;
            }
        } else {
            if (goalPerc > 100) {
                displayGoalPerc = 100;
            }
        }
        
        var startY = settings.fieldXY[loc][1] + paddingY+1;
        //draw filled rectangle to represent text’s color (add 1 pixel for rounding errs (Y))
        settings.dc.setColor(stepsBackColor, stepsBackColor);
        settings.dc.fillRectangle(settings.fieldXY[loc][0]+paddingX, startY, 2*settings.fieldWidth-spaceWidth, 2*settings.fieldHeight-spaceHeight);

        // Percentage of steps calculated in pixels of the char that needs to be colored:
        var charPerc = Math.round((charHeight.toFloat()/100)* displayGoalPerc.toFloat());
        
        if(DEBUG) {
            System.println( "-----------------------------------");
            System.println( "goalPerc........= " + goalPerc);
            System.println( "displayGoalPerc.= " + displayGoalPerc);
            System.println( "charHeight......= " + charHeight);
            System.println( "charWidth.......= " + charWidth);
            System.println( "charPerc.(px)...= " + charPerc.toNumber());
            System.println( "-----------------------------------");
        }
        
        var effectY = startY + ( charHeight - charPerc); //((charHeight+paddingY)-charPerc); // (add 1 pixel for rounding errs (Y))
        var effectHeight = charPerc;
        
        //draw filled rectangle to represent water level 
        settings.dc.setColor(stepsForeColor, stepsForeColor);
        settings.dc.fillRectangle(settings.fieldXY[loc][0]+paddingX, effectY+1, 2*settings.fieldWidth-spaceWidth, effectHeight-1);
        
        settings.dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        settings.dc.drawText(settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+paddingY, NumberThaiXtremeHot, hour.format("%02.f"), Gfx.TEXT_JUSTIFY_LEFT);        
    }
}