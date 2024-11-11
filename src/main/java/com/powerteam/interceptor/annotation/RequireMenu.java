package com.powerteam.interceptor.annotation;

import java.lang.annotation.*;

/**
 * 标记需要Menu权限
 */
@Documented
@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
public @interface RequireMenu {

    /**
     * MenuCode
     *
     * @return
     */
    String value() default "";
}
