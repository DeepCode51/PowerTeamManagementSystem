package com.powerteam.util;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;


@Service
public class ExcelUtil {

    @Autowired
    private HttpServletResponse response;

    public <T> void export(String fileName, List<T> data) {
        try {

            if (data == null || data.isEmpty()) {
                return;
            }

            List<ExcelColumn> columnList = new ArrayList<>();

            Class<?> type = data.get(0).getClass();

            List<Field> fields = Arrays.asList(type.getDeclaredFields());

            for (Field field : fields) {
                field.setAccessible(true);
                ExcelColumn excelColumn = field.getAnnotation(ExcelColumn.class);
                columnList.add(excelColumn);
            }

            columnList.sort((e1, e2) -> e1.order() - e2.order());
            fields.sort((f1, f2) -> f1.getAnnotation(ExcelColumn.class).order() - f2.getAnnotation(ExcelColumn.class).order());

            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet();

            HSSFRow headerRow = sheet.createRow(0);

            for (ExcelColumn column : columnList) {
                HSSFCell headerCell = headerRow.createCell(column.order());
                headerCell.setCellValue(column.headerName());
            }

            for (int i = 0; i < data.size(); i++) {
                T item = data.get(i);
                HSSFRow row = sheet.createRow(i + 1);

                for (int j = 0; j < fields.size(); j++) {
                    HSSFCell cell = row.createCell(j);

                    Field field = fields.get(j);

                    Class<?> fieldType = field.getType();

                    if (fieldType == String.class) {
                        cell.setCellValue(field.get(item).toString());
                    } else if (fieldType == int.class) {
                        cell.setCellValue(field.getInt(item));
                    } else if (fieldType == double.class) {
                        cell.setCellValue(field.getDouble(item));
                    } else if (fieldType == float.class) {
                        cell.setCellValue(field.getFloat(item));
                    } else if (fieldType == boolean.class) {
                        cell.setCellValue(field.getBoolean(item));
                    } else if (fieldType == byte.class) {
                        cell.setCellValue(field.getByte(item));
                    } else if (fieldType == long.class) {
                        cell.setCellValue(field.getLong(item));
                    } else if (fieldType == short.class) {
                        cell.setCellValue(field.getShort(item));
                    } else if (fieldType == char.class) {
                        cell.setCellValue(field.getChar(item));
                    } else if (fieldType == Date.class) {
                        Object value = field.get(item);
                        if (value != null) {
                            CellStyle dateStyle = workbook.createCellStyle();
                            CreationHelper createHelper = workbook.getCreationHelper();
                            dateStyle.setDataFormat(createHelper.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));
                            cell.setCellStyle(dateStyle);
                            cell.setCellValue((Date) value);
                        }
                    } else if (fieldType == Integer.class) {
                        Object value = field.get(item);
                        if (value != null) {
                            cell.setCellValue((Integer) value);
                        }
                    } else if (fieldType == Double.class) {
                        Object value = field.get(item);
                        if (value != null) {
                            cell.setCellValue((Double) value);
                        }
                    } else if (fieldType == Float.class) {
                        Object value = field.get(item);
                        if (value != null) {
                            cell.setCellValue((Float) value);
                        }
                    } else if (fieldType == Boolean.class) {
                        Object value = field.get(item);
                        if (value != null) {
                            cell.setCellValue((Boolean) value);
                        }
                    } else if (fieldType == Byte.class) {
                        Object value = field.get(item);
                        if (value != null) {
                            cell.setCellValue((Byte) value);
                        }
                    } else if (fieldType == Long.class) {
                        Object value = field.get(item);
                        if (value != null) {
                            cell.setCellValue((Long) value);
                        }
                    } else if (fieldType == Short.class) {
                        Object value = field.get(item);
                        if (value != null) {
                            cell.setCellValue((Short) value);
                        }
                    }
                }
            }

            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
            workbook.write(response.getOutputStream());
            response.flushBuffer();

        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
