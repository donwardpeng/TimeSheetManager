/*
 * PostRequest.fx
 *
 * Created on Jun 25, 2009, 1:49:47 PM
 */

package javafx_timesheet_frontend;

import javafx.io.http.HttpRequest;

/**
 * @author dward
 */

public class PostRequest extends HttpRequest {

    override public var method = HttpRequest.POST;
    def testContent: String = EditCalendar.getPostString();;
    def testContentSize: Integer = testContent.getBytes().length;

    // override the enqueue function in order to make sure the Content-Type
    // and Content-Length headers are provided
    override function start() {
        setHeader("Content-Type", "application/x-www-form-urlencoded");
        //setHeader("Content-Length", "{testContentSize}");
        super.start();
    }
}

