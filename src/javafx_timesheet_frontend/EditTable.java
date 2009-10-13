
package javafx_timesheet_frontend;

import java.awt.Dimension;
import java.util.Vector;
import javax.swing.DefaultCellEditor;
import javax.swing.JComboBox;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.event.TableModelEvent;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;

/**
 *
 * @author dward
 * @EditTable Class
 */
public class EditTable {
 //declare JTable member
    public JTable table;
    public static CustomTableModel timeSheetTableModel = new CustomTableModel();
    private static boolean createNewModel = true;
/**
 *Constructor
 */
public EditTable(){
table = new JTable(timeSheetTableModel);
if (createNewModel == true)
{
addColumnsToTable();
 createNewModel = false;
}
initializeTable();
}

private void addColumnsToTable(){
timeSheetTableModel.addColumn("Job");
timeSheetTableModel.addColumn("Desciption");
timeSheetTableModel.addColumn("Sunday");
timeSheetTableModel.addColumn("Monday");
timeSheetTableModel.addColumn("Tuesday");
timeSheetTableModel.addColumn("Wednesday");
timeSheetTableModel.addColumn("Thursday");
timeSheetTableModel.addColumn("Friday");
timeSheetTableModel.addColumn("Saturday");
timeSheetTableModel.addColumn("Total");
}

/**
 * CreateTable method to customize Table
 */
private void initializeTable()
{
table.setPreferredScrollableViewportSize(new Dimension(900, 110));
table.setSurrendersFocusOnKeystroke(true);

//Make the Job Column a pull down menu
TableColumn jobColumn = table.getColumnModel().getColumn(0);
JComboBox comboBox = new JComboBox();
comboBox.addItem("Job 1");
comboBox.addItem("Job 2");
comboBox.addItem("Job 3");
comboBox.addItem("Job 4");
comboBox.addItem("Job 5");
comboBox.addItem("Holiday");
comboBox.addItem("Vacation");
jobColumn.setCellEditor(new DefaultCellEditor(comboBox));

//Set tooltip for 1st column
DefaultTableCellRenderer renderer =
new DefaultTableCellRenderer();
renderer.setToolTipText("Click for combo box");
jobColumn.setCellRenderer(renderer);

//Set size of each column to 100
TableColumn column = null;
for (int i = 0; i < 10; i++) {
column = table.getColumnModel().getColumn(i);
if (i==1)
column.setPreferredWidth(100); //second column is bigger
else
column.setPreferredWidth(50);
}

}

public static JScrollPane addToPane(JTable table){
JScrollPane pane = new JScrollPane(table);
return pane;
}

public static void addRowToTable(JTable table)
{
    //Add a row to the end of the table
    if (((DefaultTableModel)table.getModel()).getRowCount() < 7 )
     ((DefaultTableModel)table.getModel()).addRow(new Object[] {"Job 1","Enter Description","0","8","8","8","8","8","0","40"} );
if(Debug.DEBUG)
{
    System.out.println("Row Count After Row Add = " + ((DefaultTableModel)table.getModel()).getRowCount() );
}
}

public static void deleteRowFromTable(JTable table)
{
 try
 {
    if (table.getRowCount() > 1){
    int currentRow = table.getSelectedRow();
      ((DefaultTableModel)table.getModel()).removeRow(currentRow);
       if ((table.getRowCount() > 1) && (currentRow > 1))
       {
      table.setRowSelectionInterval(currentRow-1, currentRow-1);
       }
       else
       {
       table.setRowSelectionInterval(new Integer(0),new Integer(0));
       }
       }
    }
 catch (ArrayIndexOutOfBoundsException e)
 {

 }
if(Debug.DEBUG)
{
    System.out.println("Row Count After Row Delete = " + ((DefaultTableModel)table.getModel()).getRowCount() );
}
}

public static void removeAllRows(){
 int i = 0;
 if(Debug.DEBUG)
    {
    System.out.println("Row Count Before Remove All Rows = " + ((EditTable.timeSheetTableModel).getRowCount() ) );
    }
   while( ( (EditTable.timeSheetTableModel).getRowCount()) > 0)
 {
    (EditTable.timeSheetTableModel).removeRow(i);
    if(Debug.DEBUG)
    {
    System.out.println("Row Count During Remove All Rows = " + ((EditTable.timeSheetTableModel).getRowCount() ) );
    }
 }
     if(Debug.DEBUG)
    {
    System.out.println("Row Count After Remove All Rows = " + ( (EditTable.timeSheetTableModel).getRowCount() ) );
    }
}

public static void populateTable(int count, String [] sourceString)
{
(EditTable.timeSheetTableModel).insertRow(count, sourceString);
    if(Debug.DEBUG)
    {
    System.out.println("Row Count For One Call to Populate Table = " + (EditTable.timeSheetTableModel).getRowCount() );
    }
}

public static String getFormattedRowString(int rowIndex){
String retString = "";
for (int i=0; i < ((EditTable.timeSheetTableModel).getColumnCount()); i++)
{
retString = retString + (EditTable.timeSheetTableModel).getValueAt(rowIndex, i).toString() + ",";
}
return retString;
}
}

class CustomTableModel extends DefaultTableModel{
final int JOBID_ROW = 0;
final int DESC_ROW = 1;
final int SUNDAY_ROW = 2;
final int MONDAY_ROW = 3;
final int TUESDAY_ROW = 4;
final int WEDNESDAY_ROW = 5;
final int THURSDAY_ROW = 6;
final int FRIDAY_ROW = 7;
final int SATURDAY_ROW = 8;
final int TOTALS_ROW = 9;

//set whether a Cell is Editable or not
@Override
public boolean isCellEditable(int rowIndex, int mColIndex) {
if(mColIndex == 9)
return false;
else
return true;
}

@Override
public void setValueAt(Object aValue, int row, int column) {
super.setValueAt(aValue, row, column);

/**
* If one of the hour values is changed then try to update the sum
* if the hour value is a number
*/
if(column > 1 && column < 9)
{
try{
Vector rowVector = (Vector)dataVector.elementAt(row);
Integer sumValue =  Integer.parseInt((String)rowVector.get(SUNDAY_ROW)) +
Integer.parseInt((String)rowVector.get(MONDAY_ROW)) +
Integer.parseInt((String)rowVector.get(TUESDAY_ROW)) +
Integer.parseInt((String)rowVector.get(WEDNESDAY_ROW)) +
Integer.parseInt((String)rowVector.get(THURSDAY_ROW)) +
Integer.parseInt((String)rowVector.get(FRIDAY_ROW)) +
Integer.parseInt((String)rowVector.get(SATURDAY_ROW));
rowVector.setElementAt((Object)sumValue, 9);
}
/**
* if the number value changed is not a number, then a NumberFormatException
* is thrown and we set the offending value to zero and calculate the sum
*/
catch(NumberFormatException e)
{
Vector rowVector = (Vector)dataVector.elementAt(row);
String zero = "0";
rowVector.setElementAt((Object)zero, column);
Integer sumValue =  Integer.parseInt((String)rowVector.get(SUNDAY_ROW)) +
Integer.parseInt((String)rowVector.get(MONDAY_ROW)) +
Integer.parseInt((String)rowVector.get(TUESDAY_ROW)) +
Integer.parseInt((String)rowVector.get(WEDNESDAY_ROW)) +
Integer.parseInt((String)rowVector.get(THURSDAY_ROW)) +
Integer.parseInt((String)rowVector.get(FRIDAY_ROW)) +
Integer.parseInt((String)rowVector.get(SATURDAY_ROW));
rowVector.setElementAt((Object)sumValue, 9);
}
}
}

 @Override
 public void newDataAvailable(TableModelEvent event) {
  System.out.println("Change occurred at: " + event.getFirstRow() + "," + event.getColumn());
  super.newDataAvailable(event);
 }
};
