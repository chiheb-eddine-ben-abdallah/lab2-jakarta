package com.example.jakartaeecourse;

import jakarta.servlet.annotation.WebServlet;
import org.junit.jupiter.api.Test;

import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class ServletMappingTest {

    @Test
    void testHelloServletMappings() {
        WebServlet annotation = HelloServlet.class.getAnnotation(WebServlet.class);
        assertNotNull(annotation, "HelloServlet must have @WebServlet annotation");
        assertTrue(Arrays.asList(annotation.value()).contains("/hello"));
        assertTrue(Arrays.asList(annotation.value()).contains("/hello-servlet"));
    }

    @Test
    void testGoodbyeServletMapping() {
        WebServlet annotation = GoodbyeServlet.class.getAnnotation(WebServlet.class);
        assertNotNull(annotation, "GoodbyeServlet must have @WebServlet annotation");
        assertTrue(Arrays.asList(annotation.value()).contains("/goodbye"));
    }
}
