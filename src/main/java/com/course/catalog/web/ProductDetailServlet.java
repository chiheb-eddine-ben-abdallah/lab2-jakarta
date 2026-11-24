package com.course.catalog.web;

import com.course.catalog.model.ProductCatalog;
import com.course.catalog.model.ProductDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/catalog/product")
public class ProductDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        ProductDTO product = null;
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isBlank()) {
            try {
                Long id = Long.valueOf(idParam.trim());
                product = ProductCatalog.findById(id);
            } catch (NumberFormatException ignored) {
                // Invalid id renders the "Product not found." state in product-detail.jsp.
            }
        }

        req.setAttribute("product", product);
        req.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(req, resp);
    }
}