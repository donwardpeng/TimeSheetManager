/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package javafx_timesheet_frontend;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import org.jdesktop.swingx.JXMonthView;

/**
 *
 * @author dward
 */
public class EditCalendar {
//static JXDatePicker picker;
static JXMonthView picker;

public static JXMonthView create(){
      Date today = new Date();
      Calendar cal = Calendar.getInstance();
      cal.setTime(today);
      int currentDay = cal.get(Calendar.DAY_OF_WEEK);
      int daysToAdd = 1 - currentDay;
      cal.add(Calendar.DAY_OF_WEEK, daysToAdd);
      Date sundayOfWeek = cal.getTime();
      picker = new JXMonthView(sundayOfWeek);
      picker.setSelectionDate(sundayOfWeek);
/**
 * Highlight the week selected
 */
      cal.add(Calendar.DAY_OF_WEEK, 1);
      Date mondayOfWeek = cal.getTime();
      cal.add(Calendar.DAY_OF_WEEK, 1);
      Date tuesdayOfWeek = cal.getTime();
      cal.add(Calendar.DAY_OF_WEEK, 1);
      Date wednesdayOfWeek = cal.getTime();
      cal.add(Calendar.DAY_OF_WEEK, 1);
      Date thursdayOfWeek = cal.getTime();
      cal.add(Calendar.DAY_OF_WEEK, 1);
      Date fridayOfWeek = cal.getTime();
      cal.add(Calendar.DAY_OF_WEEK, 1);
      Date saturdayOfWeek = cal.getTime();
      picker.clearFlaggedDates();
      picker.setFlaggedDates(sundayOfWeek, mondayOfWeek, tuesdayOfWeek,
              wednesdayOfWeek, thursdayOfWeek, fridayOfWeek,
              saturdayOfWeek);
/**
 * Config the colors and highlighting for the Monthview
 */
     picker.setDaysOfTheWeekForeground(Color.BLACK);
     picker.setMonthStringBackground(Color.LIGHT_GRAY);
     picker.setShowingLeadingDays(true);
     picker.setShowingTrailingDays(true);
     picker.setShowingWeekNumber(true);
     picker.setTraversable(true);
     picker.setFlaggedDayForeground(Color.BLUE);
     picker.setSelectionBackground(Color.WHITE);
     picker.setTodayBackground(Color.RED);
return picker;
}
/**
 * method to set the Current Date to the Previous Sunday
 */
public static void setDateToPreviousWeek()
{
Date currentSelected =  picker.getLastSelectionDate();
Calendar cal = Calendar.getInstance();
cal.setTime(currentSelected);
int currentDay = cal.get(Calendar.DAY_OF_WEEK);
int daysToAdd = 1 - currentDay - 7;
cal.add(Calendar.DAY_OF_WEEK, daysToAdd);
Date sundayOfWeek = cal.getTime();
cal.add(Calendar.DAY_OF_WEEK, 1);
Date mondayOfWeek = cal.getTime();
cal.add(Calendar.DAY_OF_WEEK, 1);
Date tuesdayOfWeek = cal.getTime();
cal.add(Calendar.DAY_OF_WEEK, 1);
Date wednesdayOfWeek = cal.getTime();
cal.add(Calendar.DAY_OF_WEEK, 1);
Date thursdayOfWeek = cal.getTime();
cal.add(Calendar.DAY_OF_WEEK, 1);
Date fridayOfWeek = cal.getTime();
cal.add(Calendar.DAY_OF_WEEK, 1);
Date saturdayOfWeek = cal.getTime();
picker.setSelectionDate(sundayOfWeek);
picker.clearFlaggedDates();
picker.setFlaggedDates(sundayOfWeek, mondayOfWeek, tuesdayOfWeek,
wednesdayOfWeek, thursdayOfWeek, fridayOfWeek,
saturdayOfWeek);
}

/**
 * method to set the Current Date to the Next Sunday
 */
public static void setDateToNextWeek()
{
Date currentSelected =  picker.getLastSelectionDate();
Calendar cal = Calendar.getInstance();
cal.setTime(currentSelected);
int currentDay = cal.get(Calendar.DAY_OF_WEEK);
int daysToAdd = 1 - currentDay + 7;
cal.add(Calendar.DAY_OF_WEEK, daysToAdd);
Date sundayOfWeek = cal.getTime();
picker.setSelectionDate(sundayOfWeek);
cal.add(Calendar.DAY_OF_WEEK, 1);
Date mondayOfWeek = cal.getTime();
cal.add(Calendar.DAY_OF_WEEK, 1);
Date tuesdayOfWeek = cal.getTime();
cal.add(Calendar.DAY_OF_WEEK, 1);
Date wednesdayOfWeek = cal.getTime();
cal.add(Calendar.DAY_OF_WEEK, 1);
Date thursdayOfWeek = cal.getTime();
cal.add(Calendar.DAY_OF_WEEK, 1);
Date fridayOfWeek = cal.getTime();
cal.add(Calendar.DAY_OF_WEEK, 1);
Date saturdayOfWeek = cal.getTime();
picker.setSelectionDate(sundayOfWeek);
picker.clearFlaggedDates();
picker.setFlaggedDates(sundayOfWeek, mondayOfWeek, tuesdayOfWeek,
wednesdayOfWeek, thursdayOfWeek, fridayOfWeek,
saturdayOfWeek);
}

public static void clampDate(ActionEvent e){
          if (JXMonthView.COMMIT_KEY.equals(e.getActionCommand())) {
              Date currentSelected =  picker.getLastSelectionDate();
              Calendar cal = Calendar.getInstance();
              cal.setTime(currentSelected);
              int currentDay = cal.get(Calendar.DAY_OF_WEEK);
              int daysToAdd = 1 - currentDay;
              cal.add(Calendar.DAY_OF_WEEK, daysToAdd);
              Date sundayOfWeek = cal.getTime();
              cal.add(Calendar.DAY_OF_WEEK, 1);
              Date mondayOfWeek = cal.getTime();
              cal.add(Calendar.DAY_OF_WEEK, 1);
              Date tuesdayOfWeek = cal.getTime();
              cal.add(Calendar.DAY_OF_WEEK, 1);
              Date wednesdayOfWeek = cal.getTime();
              cal.add(Calendar.DAY_OF_WEEK, 1);
              Date thursdayOfWeek = cal.getTime();
              cal.add(Calendar.DAY_OF_WEEK, 1);
              Date fridayOfWeek = cal.getTime();
              cal.add(Calendar.DAY_OF_WEEK, 1);
              Date saturdayOfWeek = cal.getTime();
              picker.setSelectionDate(sundayOfWeek);
              picker.clearFlaggedDates();
              picker.setFlaggedDates(sundayOfWeek, mondayOfWeek, tuesdayOfWeek,
                      wednesdayOfWeek, thursdayOfWeek, fridayOfWeek,
                      saturdayOfWeek);
              }

}

public static String getDateForQuery(){
     Date currentSelected = picker.getFirstSelectionDate();
     Calendar cal = Calendar.getInstance();
     cal.setTime(currentSelected);
     String retDate = String.format("%04d%02d%02d",(cal.get(Calendar.YEAR)),1+(cal.get(Calendar.MONTH)),(cal.get(Calendar.DAY_OF_MONTH)));
     return retDate;
}

public static String getDateForMonthView(){
     Date currentSelected = picker.getFirstSelectionDate();
     DateFormat df = DateFormat.getDateInstance(DateFormat.FULL);
     String retDate = "Week Ending: " + df.format(currentSelected);
     return retDate;
}

public static String getPostString(){
String postString = null;
postString = "Date=" + getDateForQuery() + "&";
for (int i=0; i < ((EditTable.timeSheetTableModel).getRowCount()); i++)
{
postString = postString + "Row" + i + "="  + (EditTable.getFormattedRowString(i)) + "&";
}
if(Debug.DEBUG){
System.out.println("PostString:\n" + postString);
}
return postString;
}
}
