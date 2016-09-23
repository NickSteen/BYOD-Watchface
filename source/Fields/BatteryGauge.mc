using Toybox.System as Sys;
using Toybox.Math as Math;
using Toybox.Lang as Lang;

class BatteryGauge
{
    var hourDrop; //% drop in the last hour
    var hourUpdate; // Has it already updated this hour?
    var hourCount; // How many hours have been measured? The larger the better the estimation will be
    var lastHourBatPct; // Store last percentage

    function initialize()
    {
        hourDrop = 0.4;
        hourCount = 1;
        hourUpdate = false;
        lastHourBatPct = Sys.getSystemStats().battery;
    }

    function update()
    {
        // Check if on hour
        // if hour, get battery+do job
        if(Sys.getClockTime().min == 0 && !hourUpdate && hourCount <= 8760)
        {
            hourUpdate = true;
            var batDiff = lastHourBatPct-Sys.getSystemStats().battery;
            if(batDiff > 0)
            {
                hourDrop += batDiff;
                hourCount++;
            }

            lastHourBatPct = Sys.getSystemStats().battery; 
        }
        else if(Sys.getClockTime().min != 0)
        {
            hourUpdate = false;
        }
    }

    function getBatteryDrop()
    {
        // Return float in %/h
        return hourDrop/hourCount;
    }

    function getBatteryDropString()
    {
        // Return string in format: ..%/h
        return getBatteryDrop().format("%.1f") + "%/h";
    }

    function getBatterySpanString()
    {
        // Return string in format: ..d..h..m
        var batPct = Sys.getSystemStats().battery;
        var dropRate = getBatteryDrop();

        var hoursLeft = batPct/dropRate;
        var days = Math.floor(hoursLeft/24);
        var hours = Math.floor(hoursLeft-days*24);
        var mins = Math.floor((hoursLeft-days*24-hours)*60);
        var hoursLeftStr = "";
        if(days>0)
        {
            hoursLeftStr = Lang.format("$1$d$2$h", [days.format("%.0f"), hours.format("%.0f")]);
        }
        else if(hours>0)
        {
            hoursLeftStr = Lang.format("$1$h$2$m", [hours.format("%.0f"), mins.format("%.0f")]);
        }
        else
        {
            hoursLeftStr = Lang.format("$1$m", [mins.format("%.0f")]);
        }

        return hoursLeftStr;
    }
}