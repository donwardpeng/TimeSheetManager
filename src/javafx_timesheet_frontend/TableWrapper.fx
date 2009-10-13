/*
 * TableWrapper.fx
 *
 * Created on Jun 17, 2009, 3:55:54 PM
 */

package javafx_timesheet_frontend;

import javafx.ext.swing.SwingComponent;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import java.awt.Color;

/**
 * @author dward
 */

//declare JXTable Control for Time Data
public class TableWrapper extends SwingComponent{
  var customTable: EditTable;
  public var table: JTable;
  var model: DefaultTableModel;
  var pane:JScrollPane;

  override function createJComponent() {
      customTable = new EditTable();
      table = customTable.table;
      table.setBackground(Color.WHITE);
      table.setForeground(Color.BLACK);
      pane = EditTable.addToPane(table);
      pane
}

public function addRow(){
  customTable.addRowToTable(table);
    }

public function deleteRow(){
  customTable.deleteRowFromTable(table);
    }



}
