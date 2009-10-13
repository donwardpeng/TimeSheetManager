/*
 * MenuNode.fx
 *
 * Created on Jul 1, 2009, 2:28:00 PM
 */

package javafx_timesheet_frontend;

/**
 * @author dward
 */

/*
 *  MenuNode.fx -
 *  A custom node that functions as a menu
 *
 *  Developed 2008 by James L. Weaver (jim.weaver at lat-inc.com)
 *  to demonstrate how to create custom nodes in JavaFX
 */

import javafx.scene.*;
import javafx.scene.effect.*;
import javafx.scene.layout.*;

public class MenuNode extends CustomNode {

  /*
   * A sequence containing the ButtonNode instances
   */
  public var buttons:ButtonNode[];

  /**
   * Create the Node
   */
   override function create():Node {
    HBox {
      spacing: 50
      content: buttons
      effect:
        Reflection {
          fraction: 0.70
          topOpacity: 0.8
        }
    }
  }
}
