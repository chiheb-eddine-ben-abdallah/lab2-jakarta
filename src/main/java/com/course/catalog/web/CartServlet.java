package com.course.catalog.web;

import com.course.catalog.model.ProductCatalog;
import com.course.catalog.model.ProductDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/cart", "/cart/add", "/cart/remove"})
public class CartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<ProductDTO> cart = (List<ProductDTO>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        String path = req.getServletPath();
        String productIdParam = req.getParameter("productId");
        Long productId = null;
        if (productIdParam != null && !productIdParam.isBlank()) {
            try {
                productId = Long.valueOf(productIdParam.trim());
            } catch (NumberFormatException ignored) {
                // Ignore malformed productId and redirect back to cart.
            }
        }

        if (productId != null) {
            if ("/cart/remove".equals(path)) {
                for (int i = 0; i < cart.size(); i++) {
                    if (cart.get(i).getId().equals(productId)) {
                        cart.remove(i);
                        break;
                    }
                }
            } else if ("/cart/add".equals(path)) {
                ProductDTO product = ProductCatalog.findById(productId);
                if (product != null) {
                    cart.add(product);
                }
            }
        }

        session.setAttribute("cart", cart);
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}