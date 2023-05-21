package com.sac.workoutservice.util;

import java.util.Calendar;
import java.util.Date;

/**
 * @author Sachith Harshamal
 * @created 2023-05-21
 */
public class DateUtil {

    public static int getYearsBetweenDates(Date startDate, Date endDate) {
        Calendar startCalendar = Calendar.getInstance();
        startCalendar.setTime(startDate);

        Calendar endCalendar = Calendar.getInstance();
        endCalendar.setTime(endDate);

        int years = endCalendar.get(Calendar.YEAR) - startCalendar.get(Calendar.YEAR);

        // Check if the end date is before the start date in terms of months and days
        if (endCalendar.get(Calendar.MONTH) < startCalendar.get(Calendar.MONTH)
                || (endCalendar.get(Calendar.MONTH) == startCalendar.get(Calendar.MONTH)
                && endCalendar.get(Calendar.DAY_OF_MONTH) < startCalendar.get(Calendar.DAY_OF_MONTH))) {
            years--;
        }

        return years;
    }
}
