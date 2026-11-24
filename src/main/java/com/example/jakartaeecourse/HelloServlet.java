package com.example.jakartaeecourse;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// Runs automatically when a client sends an HTTP GET request to /hello and writes a plain-text response back to the browser.
@WebServlet(name = "helloServlet", value = {"/hello", "/hello-servlet"})
public class HelloServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/plain;charset=UTF-8");
        resp.getWriter().println("Hello, Enterprise World!");
    }
}