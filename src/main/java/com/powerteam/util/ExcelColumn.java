package com.powerteam.util;

import java.lang.annotation.*;

/**
 * Excel导出 - 列定义标记
 */
@Documented
@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD})
public @interface ExcelColumn {

    /**
     * 表头
     *
     * @return
     */
    String headerName() default "未设定表头";

    /**
     * 列排序
     *
     * @return
     */
    int order() default 0;
    
}
