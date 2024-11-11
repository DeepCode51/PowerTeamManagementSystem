package com.powerteam.interceptor.annotation;

import java.lang.annotation.*;

/**
 * 标记的当前控制器或动作为需要登陆
 */
@Documented
@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
public @interface RequireSession {

}