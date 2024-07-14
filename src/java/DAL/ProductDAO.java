/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class ProductDAO extends DBContext {

    private final int PRODUCTS_PER_PAGE = 8;

    public List<Product> getAllProducts()
            throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Product> productList = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[product]";
                //3. Create Statement
                stm = con.prepareStatement(sql);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getInt("price"));
                    p.setImg1(rs.getString("image1"));
                    p.setImg2(rs.getString("image2"));
                    p.setImg3(rs.getString("image3"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setIsDelete(rs.getBoolean("is_deleted"));
                    p.setRating(rs.getDouble("rating"));

                    productList.add(p);

                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }

        }
        return productList;
    }

    public Product findProductById(int productId)
            throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[product] WHERE [product_id] = ? AND [is_deleted] = 0";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                if (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getInt("price"));
                    p.setImg1(rs.getString("image1"));
                    p.setImg2(rs.getString("image2"));
                    p.setImg3(rs.getString("image3"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setIsDelete(rs.getBoolean("is_deleted"));
                    p.setRating(rs.getDouble("rating"));

                    return p;

                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }

        }
        return null;
    }

    public void addProduct(Product product) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "INSERT INTO [dbo].[product]\n"
                        + "([name] , [description], [price], [image1], [image2] , [image3], [category_id], [is_deleted], [rating])\n"
                        + "VALUES\n"
                        + "(?,?,?,?,?,?,?,?,?)";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, product.getName());
                stm.setString(2, product.getDescription());
                stm.setDouble(3, product.getPrice());
                stm.setString(4, product.getImg1());
                stm.setString(5, product.getImg2());
                stm.setString(6, product.getImg3());
                stm.setInt(7, product.getCategoryId());
                stm.setBoolean(8, false);
                stm.setDouble(9, product.getRating());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

    public void updateProduct(Product product) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "UPDATE [dbo].[product]\n"
                        + "   SET [name] = ?\n"
                        + "      ,[description] = ?\n"
                        + "      ,[price] = ?\n"
                        + "      ,[image1] = ?\n"
                        + "      ,[image2] = ?\n"
                        + "      ,[image3] = ?\n"
                        + "      ,[category_id] = ?\n"
                        + " WHERE [product_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, product.getName());
                stm.setString(2, product.getDescription());
                stm.setDouble(3, product.getPrice());
                stm.setString(4, product.getImg1());
                stm.setString(5, product.getImg2());
                stm.setString(6, product.getImg3());
                stm.setInt(7, product.getCategoryId());
                stm.setInt(8, product.getProductId());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }

    }

    public void deleteProduct(int productId) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "UPDATE [dbo].[product]\n"
                        + "   SET [is_deleted] = ?\n"
                        + " WHERE [product_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, true);
                stm.setInt(2, productId);

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }

    }

    public Product findProductByName(String productName)
            throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[product] WHERE [name] = ? AND [is_deleted] = 0";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, productName);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                if (rs.next()) {

                    Product product = new Product();

                    product.setProductId(rs.getInt("product_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getInt("price"));
                    product.setImg1(rs.getString("image1"));
                    product.setImg2(rs.getString("image2"));
                    product.setImg3(rs.getString("image3"));
                    product.setCategoryId(rs.getInt("category_id"));
                    product.setIsDelete(rs.getBoolean("is_deleted"));
                    product.setRating(rs.getDouble("rating"));

                    return product;

                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }

        }
        return null;
    }

    public List<Product> getProductByPage(int pageNumber) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Product> productList = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * \n"
                        + "FROM [dbo].[product]\n"
                        + "WHERE [is_deleted] = 0\n"
                        + "ORDER BY [product_id] DESC\n"
                        + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, (pageNumber - 1) * PRODUCTS_PER_PAGE);
                stm.setInt(2, PRODUCTS_PER_PAGE);
                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getInt("price"));
                    p.setImg1(rs.getString("image1"));
                    p.setImg2(rs.getString("image2"));
                    p.setImg3(rs.getString("image3"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setIsDelete(rs.getBoolean("is_deleted"));
                    p.setRating(rs.getDouble("rating"));

                    ProductVariantDAO pDAO = new ProductVariantDAO();

                    p.setVariantList(pDAO.getAllVariantsOfAProduct(p.getProductId()));
                    productList.add(p);

                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }

        }
        return productList;
    }

    public List<Product> getLastestProducts()
            throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Product> lastestProducts = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT TOP 6 * FROM product\n"
                        + "WHERE [is_deleted] = 0 \n"
                        + "ORDER BY product_id DESC";
                //3. Create Statement
                stm = con.prepareStatement(sql);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getInt("price"));
                    p.setImg1(rs.getString("image1"));
                    p.setImg2(rs.getString("image2"));
                    p.setImg3(rs.getString("image3"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setIsDelete(rs.getBoolean("is_deleted"));
                    p.setRating(rs.getDouble("rating"));

                    lastestProducts.add(p);

                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }

        }
        return lastestProducts;
    }

    public List<Product> getRandomProducts()
            throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Product> randomProducts = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT TOP 6 * FROM product\n"
                        + "WHERE [is_deleted] = 0 \n"
                        + "ORDER BY NEWID()";
                //3. Create Statement
                stm = con.prepareStatement(sql);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getInt("price"));
                    p.setImg1(rs.getString("image1"));
                    p.setImg2(rs.getString("image2"));
                    p.setImg3(rs.getString("image3"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setIsDelete(rs.getBoolean("is_deleted"));
                    p.setRating(rs.getDouble("rating"));

                    randomProducts.add(p);

                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }

        }
        return randomProducts;
    }

    public List<Product> getSameCategoryProducts(int categoryId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Product> products = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT TOP 6 * FROM [dbo].[product]\n"
                        + "WHERE [category_id] = ? \n"
                        + "AND [is_deleted] = 0";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, categoryId);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getInt("price"));
                    p.setImg1(rs.getString("image1"));
                    p.setImg2(rs.getString("image2"));
                    p.setImg3(rs.getString("image3"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setIsDelete(rs.getBoolean("is_deleted"));
                    p.setRating(rs.getDouble("rating"));

                    products.add(p);

                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }

        }
        return products;
    }

    public List<Product> getProductsByFilterAndPage(String category, String price, String size, String color, String sort, String search, int pageNumber) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Product> productList = new ArrayList<>();
        int paramIndex = 1;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                StringBuilder query = new StringBuilder();

                boolean filterByVariants = !size.equals("all") || !color.equals("all");

                if (filterByVariants && !size.isBlank() && !color.isBlank()) {
                    query.append("SELECT p.*, v.size, v.color FROM [dbo].[product] p \n")
                            .append("JOIN [dbo].[product_variants] v \n")
                            .append("ON p.product_id = v.product_id\n")
                            .append("WHERE p.is_deleted = 0");
                } else {
                    query.append("SELECT p.* FROM [dbo].[product] p \n")
                            .append("WHERE p.is_deleted = 0");
                }

                if (!category.isBlank() && !category.equals("0")) {
                    query.append(" AND p.category_id = ?");
                }
                if (!price.isBlank() && !price.equals("all")) {
                    switch (price) {
                        case "0-15":
                            query.append(" AND p.price BETWEEN 0 AND 15");
                            break;
                        case "15-25":
                            query.append(" AND p.price BETWEEN 15 AND 25");
                            break;
                        case "25-50":
                            query.append(" AND p.price BETWEEN 25 AND 50");
                            break;
                        case "50-999":
                            query.append(" AND p.price > 50");
                            break;
                        default:
                            break;
                    }
                }
                if (!size.isBlank() && !size.equals("all")) {
                    query.append(" AND v.size = ?");
                }
                if (!color.isBlank() && !color.equals("all")) {
                    query.append(" AND v.color = ?");
                }

                if (!search.isBlank()) {
                    query.append(" AND p.name LIKE ?");
                }

                if (!sort.isBlank()) {
                    switch (sort) {
                        case "name-asc":
                            query.append(" ORDER BY p.name ASC");
                            break;
                        case "name-desc":
                            query.append(" ORDER BY p.name DESC");
                            break;
                        case "price-asc":
                            query.append(" ORDER BY p.price ASC");
                            break;
                        case "price-desc":
                            query.append(" ORDER BY p.price DESC");
                            break;
                        default:
                            query.append(" ORDER BY p.product_id DESC");
                            break;
                    }
                }

                if (sort.isBlank()) {
                    query.append(" ORDER BY p.product_id DESC");
                }

                query.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

                //3. Create Statement
                stm = con.prepareStatement(query.toString());

                if (!category.isBlank() && !category.equals("0")) {
                    stm.setInt(paramIndex++, Integer.parseInt(category));
                }
                if (!size.isBlank() && !size.equals("all")) {
                    stm.setString(paramIndex++, size);
                }
                if (!color.isBlank() && !color.equals("all")) {
                    stm.setString(paramIndex++, color);
                }

                if (!search.isBlank()) {
                    stm.setString(paramIndex++, "%" + search + "%");
                }

                stm.setInt(paramIndex++, (pageNumber - 1) * PRODUCTS_PER_PAGE);
                stm.setInt(paramIndex++, PRODUCTS_PER_PAGE);
                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getInt("price"));
                    p.setImg1(rs.getString("image1"));
                    p.setImg2(rs.getString("image2"));
                    p.setImg3(rs.getString("image3"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setIsDelete(rs.getBoolean("is_deleted"));
                    p.setRating(rs.getDouble("rating"));

                    ProductVariantDAO pDAO = new ProductVariantDAO();

                    p.setVariantList(pDAO.getAllVariantsOfAProduct(p.getProductId()));

                    productList.add(p);

                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
        return productList;
    }

    public List<Product> getProductsByFilter(String category, String price, String size, String color, String sort, String search) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Product> productList = new ArrayList<>();
        int paramIndex = 1;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                StringBuilder query = new StringBuilder();

                boolean filterByVariants = !size.equals("all") || !color.equals("all");

                if (filterByVariants && !size.isBlank() && !color.isBlank()) {
                    query.append("SELECT p.*, v.size, v.color FROM [dbo].[product] p \n")
                            .append("JOIN [dbo].[product_variants] v \n")
                            .append("ON p.product_id = v.product_id\n")
                            .append("WHERE p.is_deleted = 0");
                } else {
                    query.append("SELECT p.* FROM [dbo].[product] p \n")
                            .append("WHERE p.is_deleted = 0");
                }

                if (!category.isBlank() && !category.equals("0")) {
                    query.append(" AND p.category_id = ?");
                }
                if (!price.isBlank() && !price.equals("all")) {
                    switch (price) {
                        case "0-15":
                            query.append(" AND p.price BETWEEN 0 AND 15");
                            break;
                        case "15-25":
                            query.append(" AND p.price BETWEEN 15 AND 25");
                            break;
                        case "25-50":
                            query.append(" AND p.price BETWEEN 25 AND 50");
                            break;
                        case "50-999":
                            query.append(" AND p.price > 50");
                            break;
                        default:
                            break;
                    }
                }
                if (!size.isBlank() && !size.equals("all")) {
                    query.append(" AND v.size = ?");
                }
                if (!color.isBlank() && !color.equals("all")) {
                    query.append(" AND v.color = ?");
                }

                if (!search.isBlank()) {
                    query.append(" AND p.name LIKE ?");
                }

                if (!sort.isBlank()) {
                    switch (sort) {
                        case "name-asc":
                            query.append(" ORDER BY p.name ASC");
                            break;
                        case "name-desc":
                            query.append(" ORDER BY p.name DESC");
                            break;
                        case "price-asc":
                            query.append(" ORDER BY p.price ASC");
                            break;
                        case "price-desc":
                            query.append(" ORDER BY p.price DESC");
                            break;
                        default:
                            query.append(" ORDER BY p.product_id DESC");
                            break;
                    }
                }

                if (sort.isBlank()) {
                    query.append(" ORDER BY p.product_id DESC");
                }

                //3. Create Statement
                stm = con.prepareStatement(query.toString());

                if (!category.isBlank() && !category.equals("0")) {
                    stm.setInt(paramIndex++, Integer.parseInt(category));
                }
                if (!size.isBlank() && !size.equals("all")) {
                    stm.setString(paramIndex++, size);
                }
                if (!color.isBlank() && !color.equals("all")) {
                    stm.setString(paramIndex++, color);
                }

                if (!search.isBlank()) {
                    String searchQuery = "%" + search + "%";
                    stm.setString(paramIndex++, searchQuery);
                }

                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getInt("price"));
                    p.setImg1(rs.getString("image1"));
                    p.setImg2(rs.getString("image2"));
                    p.setImg3(rs.getString("image3"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setIsDelete(rs.getBoolean("is_deleted"));
                    p.setRating(rs.getDouble("rating"));

                    ProductVariantDAO pDAO = new ProductVariantDAO();

                    p.setVariantList(pDAO.getAllVariantsOfAProduct(p.getProductId()));
                    productList.add(p);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
        return productList;
    }

}
