package com.powerteam.controller;

import com.powerteam.interceptor.annotation.RequireSession;
import com.powerteam.model.sys.User;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpSession;

@RequireSession
public class AuthorizedController {

    @Autowired
    private HttpSession session;

    public User getUser() {
        return (User) session.getAttribute("User");
    }
}
