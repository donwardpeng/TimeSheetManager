/*
* ButtonNode.fx
*
* Created on Jul 1, 2009, 2:17:45 PM
*/

package javafx_timesheet_frontend;
/*
*  ButtonNode.fx -
*  A node that functions as an image button
*
*  Developed 2008 by James L. Weaver (jim.weaver at lat-inc.com)
*  to demonstrate how to create custom nodes in JavaFX
*/

import javafx.animation.*;
import javafx.scene.input.*;
import javafx.scene.image.*;
import javafx.scene.paint.*;
import javafx.scene.text.*;
import javafx.scene.CustomNode;
import javafx.scene.shape.Rectangle;
import javafx.scene.Node;
import javafx.scene.Group;

import java.lang.System;
import javafx.scene.effect.Glow;

public class ButtonNode extends CustomNode {
/**
* The title for this button
*/
public var title:String;

/**
* The Image for this button
*/
var btnImage:Image;

/**
* The URL of the image on the button
*/
public var imageURL:String on replace {
btnImage =
Image {
url: imageURL
};
}

/**
* The percent of the original image size to show when mouse isn't
* rolling over it.
* Note: The image will be its original size when it's being
* rolled over.
*/
public var nonRolloverScale:Number = 0.9;

/**
* The opacity of the button when not in a rollover state
*/
public var nonRolloverOpacity:Number = .80;

/**
* This attribute is interpolated by a Timeline, and various
* attributes are bound to it for fade-in behaviors
*/
var fade:Number = 1.0;
/**

/**
* A Timeline to control fading behavior when mouse enters a button
*/
var fadeTimelineIn =
Timeline {
keyFrames: [
KeyFrame {
time: 0ms
values: [
fade => 0.0
]
},
KeyFrame {
time: 600ms
values: [
fade => 1.0 tween Interpolator.LINEAR
]
}
]
};

/**
* A Timeline to control fading behavior when mouse exit a button
*/
var fadeTimelineOut =
Timeline {
keyFrames: [
KeyFrame {
time: 0ms
values: [
fade => 0.0
]
},
KeyFrame {
time: 1000ms
values: [
fade => 1.0 tween Interpolator.LINEAR
]
}
]
};

/* This attribute represents the state of whether the mouse is inside
* or outside the button, and is used to help compute opacity values
* for fade-in and fade-out behavior.
*/
var mouseInside:Boolean;

/**
* The action function attribute that is executed when the
* the button is pressed
*/
public var action:function():Void = implAction;

/**
* implAction implements the MouseClicked action code
*/
function implAction():Void{
System.out.println("Here");
}

/**
* Text color binding variable
*/
public var txtColor:Color;

/**
* Image Scale binding variable
*/
var scale= bind if (mouseInside)
{
fade * (1.0 - nonRolloverScale) + nonRolloverScale;
}
else
{
1.0 - fade * (1.0 - nonRolloverScale);
}

/**
* Image Opacity binding variable
*/
var imgOpacity = bind if (mouseInside)
{
fade * (1.0 - nonRolloverOpacity) + nonRolloverOpacity
}
else
{
1.0 - fade * (1.0 - nonRolloverOpacity)
}

/**
* Text Opacity binding variable
*/
var txtOpacity = bind if (mouseInside) {
fade * 1.0
 }
else {
(1.0 - fade*0.6)
};

/**
* Create the Node
*/
public override function create():Node {
Group {
var textRef:Text;
content: [
Rectangle {
width: bind btnImage.width
height: bind btnImage.height + 20
opacity: 0.0

},
ImageView {

image: btnImage
opacity: bind imgOpacity
scaleX: bind scale
scaleY: bind scale
translateX: bind btnImage.width / 2 - btnImage.width * scale / 2
translateY: bind btnImage.height - btnImage.height * scale

onMouseEntered:
function(me:MouseEvent):Void {
mouseInside = true;
fadeTimelineIn.playFromStart();
}
onMouseExited:
function(me:MouseEvent):Void {
mouseInside = false;
fadeTimelineOut.playFromStart();
}
onMousePressed:
function(me:MouseEvent):Void {



}
onMouseReleased:
function(me:MouseEvent):Void {
}
onMouseClicked:
function(me:MouseEvent):Void {
if(action != null) action();
}
},


textRef = Text {
translateX: bind btnImage.width / 2 - textRef.layoutBounds.width / 2
translateY: bind btnImage.height - textRef.layoutBounds.height + 20
textOrigin: TextOrigin.TOP
textAlignment: TextAlignment.CENTER
content: title
fill: bind txtColor
opacity: bind txtOpacity
font:
Font {
name: "Arial Bold"
size: 12
}
},
]
};
}
}
