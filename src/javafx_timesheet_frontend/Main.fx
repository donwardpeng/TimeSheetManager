/*
 * fx
 *
 * Created on Jun 11, 2009, 3:09:26 PM
 */
//This is another test.


package javafx_timesheet_frontend;

import java.util.*;
import javafx.scene.text.Font;
import javafx.animation.Interpolator;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.effect.Reflection;
import javafx.scene.layout.HBox;
import javafx.scene.paint.Color;
import javafx.scene.paint.Stop;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import javafx.scene.input.MouseEvent;
import javafx.scene.effect.DropShadow;
import javafx.scene.control.Label;
import javafx.scene.effect.GaussianBlur;
import javafx.scene.effect.Glow;
import javafx.scene.effect.PerspectiveTransform;

import javafx.scene.paint.LinearGradient;

/**
 * @author dward
 */

def maxScale = 2.0;
def multiplier = 120.0;
var imageScale = 5.0;
var currentX = 1.0;
var transX = 1.0;
def normalScale = 1;
def STAGE_WIDTH = 960;
def INITIAL_Y_OFFSET = 60;
def INITIAL_X_OFFSET = 30;

/**
Default String Type for the Application
*/
def DEFAULT_FONT:String = 'Arial';

/**
Table Wrapper variable for the editable TimeTable Control
*/
var timeTable = new TableWrapper();

/**
Table Wrapper variable for the animated TimeTable Control
*/
var timeTableAnimated = new TableWrapper();

/**
Calendar Wrapper variable for the Calendar SwingX Component
*/
var startCal:CalendarNode = CalendarNode{ };

var calVisible = false;
var calScale = 0.0;
var shift_lx = INITIAL_X_OFFSET;
var shift_rx = INITIAL_X_OFFSET + STAGE_WIDTH - 50;
var timeTableScaleX = 1.0;
var timeTableScaleY = 1.0;
var showRealTimeTable = true;

/**
calFadeInTimeLine - defines the animation for
the appearance of the Calendar Control
*/
def calFadeInTimeLine = Timeline {
keyFrames: [
KeyFrame {
time: 0ms
values: [
calScale => 0.0,
]
action: function():Void{
 calVisible = true;
 }
},
KeyFrame {
time: 600ms
values: [
calScale => 2.0 tween Interpolator.EASEBOTH
]
}
]
};

/**
calFadeInTimeLine - defines the animation for
the disappearance of the Calendar Control
*/
def calFadeOutTimeLine =Timeline {
keyFrames: [
KeyFrame {
time: 0ms
values: [
calScale => 2.0
]
},
KeyFrame {
time: 600ms
action: function():Void{
 calVisible = false;
 }
values: [
calScale => 0.0 tween Interpolator.EASEBOTH
]
}
]
};

/**
weekBeforeTimeLine - defines the animation for
when the Week Before button is pressed
*/
def weekBeforeTimeLine =Timeline{
keyFrames: [
KeyFrame{
time: 0ms
values:[
timeTableScaleX => 1.0,
timeTableScaleY => 1.0
 ]
 action:function():Void{
  showRealTimeTable = false;
  }
}
KeyFrame {
time: 150ms
values: [
timeTableScaleX => 0.75 tween Interpolator.EASEBOTH,
timeTableScaleY => 0.75 tween Interpolator.EASEBOTH,
shift_rx => INITIAL_X_OFFSET + STAGE_WIDTH - 75 tween Interpolator.EASEBOTH
]
},
KeyFrame {
time: 500ms
values: [
shift_rx => INITIAL_X_OFFSET tween Interpolator.EASEBOTH,
]
}
KeyFrame {
time: 600ms
values: [
shift_rx => INITIAL_X_OFFSET tween Interpolator.EASEBOTH,
]
action:function():Void{
 EditCalendar.setDateToPreviousWeek();
 EditTable.removeAllRows();
 startCal.calDateString = EditCalendar.getDateForMonthView();
  startCal.loadData();
 }
}

KeyFrame{
time:  950ms
values:[
shift_rx => INITIAL_X_OFFSET + STAGE_WIDTH - 75 tween Interpolator.EASEBOTH
]
}
KeyFrame{
time: 1100ms
values:[
timeTableScaleX => 1.0,
timeTableScaleY => 1.0
]
action:function():Void{
showRealTimeTable = true;
}
}

]
};

/**
weekAfterTimeLine - defines the animation for
when the Week After button is pressed
*/
def weekAfterTimeLine = Timeline{
keyFrames: [
KeyFrame{
time: 0ms
values:[
timeTableScaleX => 1.0,
timeTableScaleY => 1.0
 ]
 action:function():Void{
  showRealTimeTable = false;
  }
}
KeyFrame {
time: 150ms
values: [
timeTableScaleX => 0.75 tween Interpolator.EASEBOTH,
timeTableScaleY => 0.75 tween Interpolator.EASEBOTH,
shift_lx => INITIAL_X_OFFSET tween Interpolator.EASEBOTH
]
},
KeyFrame {
time: 500ms
values: [
shift_lx => INITIAL_X_OFFSET + STAGE_WIDTH - 75 tween Interpolator.EASEBOTH,
]
}
KeyFrame {
time: 600ms
values: [
shift_lx => INITIAL_X_OFFSET + STAGE_WIDTH - 75 tween Interpolator.EASEBOTH,
]
action:function():Void{
 EditCalendar.setDateToNextWeek();
 EditTable.removeAllRows();
 startCal.calDateString = EditCalendar.getDateForMonthView();
 startCal.loadData();
 }
}
KeyFrame{
time:  950ms
values:[
shift_lx => INITIAL_X_OFFSET  tween Interpolator.EASEBOTH
]
}
KeyFrame{
time: 1100ms
values:[
timeTableScaleX => 1.0,
timeTableScaleY => 1.0
]
action:function():Void{
showRealTimeTable = true;
}
}

]
};



/**
Define Button Array for the Menu items
*/
def menuRef:MenuNode = MenuNode{
buttons: [
//Week Before button
ButtonNode{
title: "Week Before"
imageURL:"{__DIR__}icons/previousweek.bmp"
txtColor: Color.WHITE
action:function():Void{
weekBeforeTimeLine.playFromStart();
}
},
//Set Date Button
ButtonNode {
title: "Set Date"
imageURL:"{__DIR__}icons/calendar.bmp"
txtColor: Color.WHITE
action:function():Void{
if (calVisible == false)
{
calScale = 0;
calGroup.toFront();
calGroup.requestFocus();
calFadeInTimeLine.playFromStart();
}
else
calFadeOutTimeLine.playFromStart();
// TODO Add Code to stop other buttons from being active when
//Calendar controls active
}
},
//Week After button
ButtonNode{
title: "Week After"
imageURL:"{__DIR__}icons/nextweek.bmp"
txtColor: Color.WHITE
action:function():Void{
weekAfterTimeLine.playFromStart();
}
},

ButtonNode {
title: "Add Row"
imageURL: "{__DIR__}icons/plus.gif"
txtColor: Color.WHITE
action: function():Void {
timeTable.addRow();
}
}
ButtonNode {
title: "Delete Row"
imageURL: "{__DIR__}icons/minus.gif"
txtColor: Color.WHITE
action: function():Void {
timeTable.deleteRow();
}
},

ButtonNode {
title: "Save"
imageURL: "{__DIR__}icons/save.bmp"
txtColor: Color.WHITE
action: function():Void {
startCal.saveData();}
} 
]
};


/**
* Define the Calendar Group Popup
*/
def calGroup: Group = Group{
translateX: INITIAL_X_OFFSET + 250
translateY: INITIAL_Y_OFFSET + 100
visible: bind calVisible;
scaleX: bind calScale;
scaleY: bind calScale;
def rect:Rectangle = Rectangle {
x: -10, y: - 30
width: bind startCal.width + 20
height: bind startCal.height + 40
fill: Color.BLACK
effect: DropShadow {
offsetX: 5
offsetY: 5
color: Color.GREY
radius: 5
}
};

/**
*Define the close dialog X button
*/
def closeGroup: Group = Group{
onMouseClicked: function( e: MouseEvent ):Void {
calFadeOutTimeLine.playFromStart();
}
content:[
Rectangle{
 x: bind startCal.width - 10
 y: bind startCal.translateY - 20
 width: 10
 height: 10
 fill: Color.BLACK
 }

 Label{
font : Font {
name: DEFAULT_FONT
size : 10

}
text: "X"
textFill: Color.WHITE
translateX: bind startCal.width - 9
translateY: bind startCal.translateY - 22
effect: GaussianBlur {
  radius: .5
}
 }
]};
 /**
 Monthview Label for Calendar Box
 */
def monthviewLabel:Label = Label {
font : Font {
name: DEFAULT_FONT
size : 10

}
text: bind startCal.calDateString
textFill: Color.WHITE


translateX: bind rect.x + 5
translateY: bind rect.y + 10
width: 300
};

content: [
//Outer Black Rectangle
rect,
//Monthview
monthviewLabel,
//Calendar Control
startCal,
//Close Button
closeGroup
]
};

def timeTableBox:HBox = HBox{

spacing:0
effect:Reflection {
fraction: 0.50
topOpacity: 0.8
}
content:[
timeTable
]
};

def timeTableAnimatedBox:HBox = HBox{

spacing:0
effect:Reflection {
fraction: 0.50
topOpacity: 0.8
}
content:[
timeTableAnimated
]
};



def stageRef: Stage =  Stage {
title: "Timesheet Manager"
style: StageStyle.TRANSPARENT
opacity: 1
scene: Scene {
fill: Color.BLACK
content:
Group{
onMouseDragged: function(event) {
stageRef.x += event.dragX;
stageRef.y += event.dragY;
}
content:[

/**
Title Rectangle
*/
Rectangle {
// No need to assign 0 to x and y, because 0 is the default
width: STAGE_WIDTH
height: 45
smooth:false
fill: LinearGradient {
// No need to assign 0 to startX and startY, because 0 is default
endX: 0.0
endY: 1.0
stops: [
Stop {
color: Color.WHITE
offset: 0.0
},
Stop {
color: Color.GREY
offset: 1.0
}
]
}
}

/**
Title Text
*/
Text {
font : Font {
name: DEFAULT_FONT
size : 24
}
fill: Color.BLACK

x: 10, y: 30

content: "Timesheet Application (beta)"
}

/**
Outer Content Rectangle
*/
Rectangle {
// No need to assign 0 to x and y, because 0 is the default
y:43
width: STAGE_WIDTH
height: 457
smooth: false
fill: LinearGradient {
// No need to assign 0 to startX and startY, because 0 is default
endX: 0.0
endY: 1.0
stops: [
Stop {
color: Color.GREY
offset: 0.0
},
Stop {
color: Color.WHITE
offset: 1.0
}
]
}
}

/**
Inner Content Rectangle
*/
Rectangle {
x: 9
y: 54
width: STAGE_WIDTH-18
height: 432
smooth:false
arcWidth: 20
arcHeight: 20
fill: Color.BLACK
stroke: Color.color(0.66, 0.67, 0.69)
},

/**
*Calendar Group for Popup Calendar
*/
calGroup,

/**
*Label for the Currently Selected Week String
*/
Label {
      font : Font {
                name: DEFAULT_FONT
                size : 20

            }

   text: bind startCal.calDateString
   textFill: Color.WHITE
   translateX: INITIAL_X_OFFSET
   translateY: INITIAL_Y_OFFSET + 20
   width: 500
   }
/**
Table Horizontal Box
*/

//Editable Time Table Group
Group{
 visible: bind showRealTimeTable,
 translateX: INITIAL_X_OFFSET
 translateY: INITIAL_Y_OFFSET + 50
 content:[
  timeTableBox
  ]
 }

//Animated Time Table Group
Group{
 visible: bind (not showRealTimeTable)
 scaleX: bind timeTableScaleX,
 scaleY: bind timeTableScaleY,
effect: PerspectiveTransform {
ulx: bind shift_lx, uly: bind INITIAL_Y_OFFSET +  50
llx: bind shift_lx, lly: bind INITIAL_Y_OFFSET + 50 + 200
urx: bind shift_rx , ury: bind INITIAL_Y_OFFSET +  50
lrx: bind shift_rx, lry: bind INITIAL_Y_OFFSET +  50 + 200
},

content:[
timeTableAnimatedBox
]
},

/**
Button Horizontal Box
*/
Group{
translateX: INITIAL_X_OFFSET
translateY: INITIAL_Y_OFFSET + 275
content:[
 //button_Array
 menuRef
 ]
},

//Close button for application
Group{

 var glowLevel = 0
 effect: Glow {
   level: bind glowLevel
  }


onMouseClicked: function( e: MouseEvent ):Void {
   javafx.lang.FX.exit();

}
onMouseEntered:function(e: MouseEvent):Void{
 glowLevel = 1
 }

onMouseExited:function(e: MouseEvent):Void{
 glowLevel = 0
 }
content:[
Rectangle{
 x: STAGE_WIDTH - 35
 y: 15
 width: 20
 height: 20
 arcHeight:5
 arcWidth: 5
 fill: Color.WHITE
 stroke: Color.BLACK
 strokeWidth: 3
 }

 Label{
font : Font {
name: 'Arial BOLD'
size : 18

}
text: "X"
textFill: Color.BLACK
translateX: STAGE_WIDTH - 30
translateY: 15
//effect: GaussianBlur {
//  radius: .5
//}
 }
]}

//Minimze button for application
Group{

 var glowLevel = 0
 effect: Glow {
   level: bind glowLevel
  }


onMouseClicked: function( e: MouseEvent ):Void {
   stageRef.iconified = true;

}
onMouseEntered:function(e: MouseEvent):Void{
 glowLevel = 1
 }

onMouseExited:function(e: MouseEvent):Void{
 glowLevel = 0
 }
content:[
Rectangle{
 x: STAGE_WIDTH - 60
 y: 15
 width: 20
 height: 20
 arcHeight:5
 arcWidth: 5
 fill: Color.WHITE
 stroke: Color.BLACK
 strokeWidth: 3
 }

 Label{
font : Font {
name: 'Arial BOLD'
size : 18

}
text: "_"
textFill: Color.BLACK
translateX: STAGE_WIDTH - 55
translateY: 10
//effect: GaussianBlur {
//  radius: .5
//}
 }
]}

]//end of Stage content
}

/**Include the following line to add Class Loaded in JVM output
* var cl:ClassAnalyzer= ClassAnalyzer{};
*/
}
}