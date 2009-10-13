/*
 * calendarWrapper.fx
 *
 * Created on Jun 17, 2009, 3:35:26 PM
 */

package javafx_timesheet_frontend;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import javafx.ext.swing.SwingComponent;
import javafx.io.http.HttpRequest;

import org.jdesktop.swingx.JXMonthView;

/**
 * @author dward
 */

public class CalendarNode extends SwingComponent{
  var cal: JXMonthView;
  public var calDateString: String;
  public var loadText: String;
  override function createJComponent() {
	    cal = EditCalendar.create();
        cal.addActionListener({ActionListener{
                public override function actionPerformed(e:ActionEvent){
                    EditCalendar.clampDate(e);
                    EditTable.removeAllRows();
                    calDateString = EditCalendar.getDateForMonthView();
                    loadData();
                }
            }
            }
        );
        cal.firePropertyChange("1", 1, 2);
        calDateString = EditCalendar.getDateForMonthView();
        loadData();
        cal
}

public function loadData():java.lang.Boolean{
//Define the HttpRequest object (getRequest) to load the data and populate the table
def getRequest: HttpRequest = HttpRequest {
location:    "http://www.greymatterworx.com/Timesheet/LoadData.do?Date={EditCalendar.getDateForQuery()}" ;
onInput: function(is: java.io.InputStream) {
        // use input stream to access content here.
        // can use input.available() to see how many bytes are available.
    try {
    def myB: BufferedReader= new BufferedReader
        (
        new InputStreamReader(is));
        var inputLine: String;
        loadText = "";
        var count = 0;
        def delim = ",";
        var tempString:String[];
        while ((inputLine = myB.readLine()) != null){
        if(Debug.DEBUG){
        println("Read in from DataSource: {inputLine}");
        }
        loadText = "{loadText}{inputLine}";
        tempString = inputLine.split(",");
        loadText = "{loadText}{tempString[0]}";
        EditTable.populateTable(count, tempString);
        count++;
        }
       myB.close();
    } finally {
       is.close();
    }
}

    onException: function(ex: java.lang.Exception) {
        println("onException - exception: {ex.getClass()} {ex.getMessage()}");
    }
}
getRequest.start();
return true;
};

public function saveData():java.lang.Boolean{
def postRequest: PostRequest = PostRequest {
    def testContent: String = EditCalendar.getPostString();;
    def testContentSize: Integer = testContent.getBytes().length;
    location: "http://www.greymatterworx.com/Timesheet/SaveData.do" ;
    onStarted: function() {
    if(Debug.DEBUG)
    {println("onStarted - started performing method: {postRequest.method} on location: {postRequest.location}");
    }
    }

    onConnecting: function() { 
    if(Debug.DEBUG){
    println("onConnecting")
    }
    }
    onDoneConnect: function() { 
    if(Debug.DEBUG){
    println("onDoneConnect")
    }
    }
    onWriting: function() {
    if(Debug.DEBUG){
    println("onWriting")
    }
    }
    // The content of a PUT or POST can be specified in the onOutput callback function.
    // Be sure to close the output sream when finished with it in order to allow
    // the HttpRequest implementation to clean up resources related to this
    // request as promptly as possible.  The calling next callback (onToWrite) depends
    // the output stream being closed.
    onOutput: function(os: java.io.OutputStream) {
        try {
            if(Debug.DEBUG){
            println("onOutput - about to write {testContent} to output stream");
            println("onOutput - about to write {testContentSize} bytes to output stream");
            }
            os.write(testContent.getBytes());
        }
        finally {
            if(Debug.DEBUG){
            println("onOutput - about to close output stream.");
            }
            os.close();
        }
    }

onDoneWrite: function() {
if(Debug.DEBUG){
    println("doneWrite")
    }
    }
onReadingHeaders: function() {
if(Debug.DEBUG){
    println("onReadingHeaders")
    }
    }
onResponseCode: function(code:Integer) { 
if(Debug.DEBUG){
    println("onResponseCode - responseCode: {code}")
    }
    }
onResponseMessage: function(msg:String) {
if(Debug.DEBUG){
    println("onResponseMessage - responseMessage: {msg}") }
}
onResponseHeaders: function(headerNames: String[]) {
if(Debug.DEBUG){
println("onResponseHeaders - there are {headerNames.size()} response headers:");
for (name in headerNames) {
println("    {name}: {postRequest.getResponseHeaderValue(name)}");
}
}
}
onReading: function() {
    if(Debug.DEBUG){
    println("onReading")
    }
    }





// The content of a response can be accessed in the onInput callback function.
// Be sure to close the input sream when finished with it in order to allow
// the HttpRequest implementation to clean up resources related to this
// request as promptly as possible.
onInput: function(is: java.io.InputStream) {
// use input stream to access content here.
// can use input.available() to see how many bytes are available.
try {
    if(Debug.DEBUG){
println("onInput - bytes of content available: {is.available()}");
}
} finally {
is.close();
}
}


onDoneRead: function() { 
if(Debug.DEBUG){
    println("onDoneRead") }
    }
onDone: function() { 
if(Debug.DEBUG){
    println("onDone")
    }
}
onException: function(ex: java.lang.Exception) {
    if(Debug.DEBUG){
println("onException - exception: {ex.getClass()} {ex.getMessage()}");
    }
    }
};

postRequest.start();




return true;
};
}
