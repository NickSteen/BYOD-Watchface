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

class StepsField extends Field
{
    function initialize(_settings)
    {
        settings = _settings;
    }

    function draw(loc)
    {
        var paddingX = (settings.fieldWidth-50)/2;
        var paddingY = 7;
        var actInfo = Act.getInfo();

        // Background
        settings.dc.setColor(settings.intermediateColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawArc((settings.fieldXY[loc][0]+settings.fieldWidth/2), settings.fieldXY[loc][1]+30, 25, Gfx.ARC_CLOCKWISE, 248, 292);
        settings.dc.drawArc((settings.fieldXY[loc][0]+settings.fieldWidth/2), settings.fieldXY[loc][1]+30, 21, Gfx.ARC_CLOCKWISE, 248, 292);

        // Progress
        var percentageSteps = 100*actInfo.steps/actInfo.stepGoal>100?100:100*actInfo.steps/actInfo.stepGoal;
        if(settings.iconsColored)
        {
	        if(percentageSteps>=100)
	        {
	            settings.dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
	        }
	        else
	        {
	            settings.dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
	        }
        }
        else
        {
        	settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        }

        if(percentageSteps>1)
        {
            var stepsToDegree = (610-(320*(percentageSteps)/100))%360;
            settings.dc.drawArc((settings.fieldXY[loc][0]+settings.fieldWidth/2), settings.fieldXY[loc][1]+30, 25, Gfx.ARC_CLOCKWISE, 248, stepsToDegree+2);
            settings.dc.drawArc((settings.fieldXY[loc][0]+settings.fieldWidth/2), settings.fieldXY[loc][1]+30, 24, Gfx.ARC_CLOCKWISE, 249, stepsToDegree+1);
            settings.dc.drawArc((settings.fieldXY[loc][0]+settings.fieldWidth/2), settings.fieldXY[loc][1]+30, 23, Gfx.ARC_CLOCKWISE, 250, stepsToDegree);
            settings.dc.drawArc((settings.fieldXY[loc][0]+settings.fieldWidth/2), settings.fieldXY[loc][1]+30, 22, Gfx.ARC_CLOCKWISE, 250, stepsToDegree);
            settings.dc.drawArc((settings.fieldXY[loc][0]+settings.fieldWidth/2), settings.fieldXY[loc][1]+30, 21, Gfx.ARC_CLOCKWISE, 249, stepsToDegree+1);
            settings.dc.drawArc((settings.fieldXY[loc][0]+settings.fieldWidth/2), settings.fieldXY[loc][1]+30, 21, Gfx.ARC_CLOCKWISE, 248, stepsToDegree+2);
        }

        // Steps
        settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
        settings.dc.drawText((settings.fieldXY[loc][0]+settings.fieldWidth/2), settings.fieldXY[loc][1]+20, Gfx.FONT_TINY, Act.getInfo().steps, Gfx.TEXT_JUSTIFY_CENTER);
        
        // Move bar
        var moveProgress = actInfo.moveBarLevel==0?50:actInfo.moveBarLevel==1?25:actInfo.moveBarLevel==2?19:actInfo.moveBarLevel==3?13:actInfo.moveBarLevel==4?7:0;

        settings.dc.setColor(settings.intermediateColor, Gfx.COLOR_TRANSPARENT);
        var coordsMove = [  [settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+settings.fieldHeight-paddingY-6],
                            [settings.fieldXY[loc][0]+paddingX+47, settings.fieldXY[loc][1]+settings.fieldHeight-paddingY-6],
                            [settings.fieldXY[loc][0]+paddingX+50, settings.fieldXY[loc][1]+settings.fieldHeight-paddingY-3],
                            [settings.fieldXY[loc][0]+paddingX+47, settings.fieldXY[loc][1]+settings.fieldHeight-paddingY],
                            [settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+settings.fieldHeight-paddingY]
                        ];
        //dc.fillPolygon(coordsMove);
        drawPolygon(settings.dc, coordsMove);

        if(actInfo.moveBarLevel!=0)
        {
            var coordsMoveProgress = [  [settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+settings.fieldHeight-paddingY-6],
                                        [settings.fieldXY[loc][0]+paddingX+48-moveProgress, settings.fieldXY[loc][1]+settings.fieldHeight-paddingY-6],
                                        [settings.fieldXY[loc][0]+paddingX+50-moveProgress, settings.fieldXY[loc][1]+settings.fieldHeight-paddingY-3],
                                        [settings.fieldXY[loc][0]+paddingX+47-moveProgress-2, settings.fieldXY[loc][1]+settings.fieldHeight-paddingY+1],
                                        [settings.fieldXY[loc][0]+paddingX, settings.fieldXY[loc][1]+settings.fieldHeight-paddingY+1]
                                     ];
                                     
            if(settings.iconsColored)
            {
            	settings.dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
            }
            else
            {
            	settings.dc.setColor(settings.foreColor, Gfx.COLOR_TRANSPARENT);
            }
            settings.dc.fillPolygon(coordsMoveProgress);
        }
    }

    function drawPolygon(dc, coord)
    {
        for(var i=0; i<coord.size()-1; i++)
        {
            dc.drawLine(coord[i][0], coord[i][1], coord[i+1][0], coord[i+1][1]);
        }
        dc.drawLine(coord[coord.size()-1][0], coord[coord.size()-1][1], coord[0][0], coord[0][1]);
    }
}