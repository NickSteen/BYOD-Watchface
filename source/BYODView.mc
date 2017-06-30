using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;

var symbols;
var NumberThaiXtremeHot;
var settings;

var counter;
var DEBUG;

class BYODView extends Ui.WatchFace {

    function initialize() {
        WatchFace.initialize();
        settings = new Settings();
        counter = 0;
        DEBUG = false;
    }

    // Load your resources here
    function onLayout(dc) {
        getDisplayOrientation(dc);
        settings.calculateFieldXY();
        settings.dc = dc;
        symbols = Ui.loadResource(Rez.Fonts.id_symbols);
        NumberThaiXtremeHot = Ui.loadResource(Rez.Fonts.id_NumberThaiXtremeHot);
        getLocation();
        onSettingsChanged();
    }
    
    function getDisplayOrientation(dc) {
        settings.displayOrientation = dc.getWidth()>dc.getHeight();
        if(settings.displayOrientation == 1)
        {
            settings.fieldWidth = dc.getWidth()/3;
            settings.fieldHeight = dc.getHeight()/2;
        }
        else
        {
            settings.fieldWidth = dc.getWidth()/2;
            settings.fieldHeight = dc.getHeight()/3;
        }
    }
    
    function onSettingsChanged()
    {
        settings.setField(0, settings.getNumberProperty("PROP_FIELD_0", settings.FIELD_HOUR_LARGE_STEPS));
        settings.setField(1, settings.getNumberProperty("PROP_FIELD_1", settings.FIELD_EMPTY));
        settings.setField(2, settings.getNumberProperty("PROP_FIELD_2", settings.FIELD_DATE));
        settings.setField(3, settings.getNumberProperty("PROP_FIELD_3", settings.FIELD_EMPTY));
        settings.setField(4, settings.getNumberProperty("PROP_FIELD_4", settings.FIELD_EMPTY));
        settings.setField(5, settings.getNumberProperty("PROP_FIELD_5", settings.FIELD_MIN));
        
        if(DEBUG) {
            Sys.println("FIELDS SET");
        }
        
        settings.foreColor = settings.getNumberProperty("ForegroundColor", Gfx.COLOR_WHITE);
        settings.backColor = settings.getNumberProperty("BackgroundColor", Gfx.COLOR_BLACK);
        settings.intermediateColor = settings.getNumberProperty("IntermediateColor", Gfx.COLOR_ORANGE);
        settings.hourStepsColor = settings.getNumberProperty("HourStepsColor", Gfx.COLOR_BLUE);
        settings.hourStepsColorFull = settings.getNumberProperty("HourStepsColorFull", Gfx.COLOR_GREEN);
        
        if(DEBUG) {
            Sys.println(Lang.format("COLORS SET: $1$ - $2$", [settings.foreColor, settings.backColor]));
        }
        
        settings.iconsColored = settings.getBooleanProperty("PROP_ICONS_COLOR", true);
        settings.stepsAfterFull = settings.getBooleanProperty("HourStepsColorFullBool", true);
        
        if(DEBUG) {
            Sys.println("ICONS COLORED");
        }
        
        getLocation();
    }

    // Update the view
    function onUpdate(dc) {
        dc.setColor(settings.backColor, settings.foreColor);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
        
        getLocation();
        
        onSettingsChanged();
        
        settings.dc = dc;
        
        for(var i=0; i<settings.fieldLayout.size(); i++)
        {
            settings.fieldLayout[i].draw(i);
        }
        
        if(DEBUG) {
            counter = counter+1;
            Sys.println(Lang.format("$1$ FIELDS DRAWN", [counter]));
        }
    }
    
    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        getLocation();
        
        symbols = Ui.loadResource(Rez.Fonts.id_symbols);
        NumberThaiXtremeHot = Ui.loadResource(Rez.Fonts.id_NumberThaiXtremeHot);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
        symbols = null;
        NumberThaiXtremeHot = null;
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
        settings.isAwake = true;
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
        settings.isAwake = false;
        Ui.requestUpdate();
    }
    
    function getLocation() {
        var actInfo = Activity.getActivityInfo();
        if(actInfo != null)
        {
            var deg = actInfo.currentLocation;
            if(deg != null)
            {
                var degArray = deg.toDegrees();
                settings.location = degArray;
            }
        }
    }
}
