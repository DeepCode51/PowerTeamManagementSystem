package com.powerteam.util;

import java.util.Calendar;
import java.util.Date;

public class DateUtil {

    public static Date toStartDate(Date startDate) {
        if (startDate != null) {
            Calendar c = Calendar.getInstance();
            c.setTime(startDate);
            c.set(Calendar.HOUR_OF_DAY, 0);
            c.set(Calendar.MINUTE, 0);
            c.set(Calendar.SECOND, 0);
            c.set(Calendar.MILLISECOND, 0);
            startDate = c.getTime();
        }

        return startDate;
    }

    public static Date toEndDate(Date endDate) {
        if (endDate != null) {
            Calendar c = Calendar.getInstance();
            c.setTime(endDate);
            c.set(Calendar.HOUR_OF_DAY, 23);
            c.set(Calendar.MINUTE, 59);
            c.set(Calendar.SECOND, 59);
            c.set(Calendar.MILLISECOND, 999);
            endDate = c.getTime();
        }

        return endDate;
    }

    public static Date firstDayInMonth() {
        Calendar c = Calendar.getInstance();
        c.add(Calendar.MONTH, 0);
        c.set(Calendar.DAY_OF_MONTH, 1);
        return toStartDate(c.getTime());
    }

    public static Date lastDayInMonth() {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
        return toEndDate(c.getTime());
    }

    public static Date addDays(Date date, int days) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(c.DATE, days);
        return c.getTime();
    }
}
