package com.course.catalog.model;

import java.util.List;

public class ProductCatalog {
    private static final List<ProductDTO> PRODUCTS = List.of(
            new ProductDTO(1L, "Wireless Mechanical Keyboard", "Electronics", 89.99),
            new ProductDTO(2L, "USB-C Docking Station", "Electronics", 129.50),
            new ProductDTO(3L, "Clean Code (Book)", "Books", 39.99),
            new ProductDTO(4L, "Ergonomic Desk Lamp", "Home", 45.00),
            new ProductDTO(5L, "Noise-Cancelling Headphones", "Electronics", 199.00)
    );

    public static List<ProductDTO> findAll() {
        return PRODUCTS;
    }

    public static ProductDTO findById(Long id) {
        return PRODUCTS.stream()
                .filter(p -> p.getId().equals(id))
                .findFirst()
                .orElse(null);
    }
}