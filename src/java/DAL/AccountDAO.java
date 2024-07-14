/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Account;
import Models.CartItem;
import Models.CustomerAddress;
import Models.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class AccountDAO extends DBContext {

    public boolean checkEmailExist(String email)
            throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM account WHERE [email] = ? AND account.role_id != 1";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, email);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                if (rs.next()) {
                    return true;
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
        return false;
    }

    public boolean checkUsernameExist(String user)
            throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM account WHERE [username] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, user);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                if (rs.next()) {
                    return true;
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
        return false;
    }

    public void addAccount(Account acc) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "INSERT INTO [dbo].[account]\n"
                        + "([username] , [password], [role_id], [email], [fullname], [phone])\n"
                        + "VALUES( ?, ?, ?, ?, ?, ?)";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, acc.getUsername());
                stm.setString(2, acc.getPassword());
                stm.setInt(3, acc.getRoleId());
                stm.setString(4, acc.getEmail());
                stm.setString(5, acc.getFullname());
                stm.setString(6, acc.getPhone());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }

    }

    public Account loginByEmail(String userInput, String password) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM account WHERE [email] = ? AND [password] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, userInput);
                stm.setString(2, password);

                rs = stm.executeQuery();
                if (rs.next()) {
                    Account account = new Account();
                    account.setAccountId(rs.getInt("account_id"));
                    account.setUsername(rs.getString("username"));
                    account.setPassword(rs.getString("password"));
                    account.setRoleId(rs.getInt("role_id"));
                    account.setEmail(rs.getString("email"));
                    account.setFullname(rs.getString("fullname"));
                    account.setPhone(rs.getString("phone"));
                    List<CustomerAddress> addresses = fetchAddressesForAccount(account.getAccountId());
                    account.setAddresses(addresses);
                    CartItemDAO ciDAO = new CartItemDAO();
                    List<CartItem> cartItems = ciDAO.getCartItems(account.getAccountId());
                    account.setCartItems(cartItems);
                    return account;
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

    public Account loginByUsername(String userInput, String password) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM account WHERE [username] = ? AND [password] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, userInput);
                stm.setString(2, password);

                rs = stm.executeQuery();
                if (rs.next()) {
                    Account account = new Account();
                    account.setAccountId(rs.getInt("account_id"));
                    account.setUsername(rs.getString("username"));
                    account.setPassword(rs.getString("password"));
                    account.setRoleId(rs.getInt("role_id"));
                    account.setEmail(rs.getString("email"));
                    account.setFullname(rs.getString("fullname"));
                    account.setPhone(rs.getString("phone"));
                    List<CustomerAddress> addresses = fetchAddressesForAccount(account.getAccountId());
                    account.setAddresses(addresses);
                    CartItemDAO ciDAO = new CartItemDAO();
                    List<CartItem> cartItems = ciDAO.getCartItems(account.getAccountId());
                    account.setCartItems(cartItems);
                    return account;
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

    public List<Account> getAccountList() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Account> accountList = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT [account_id]\n"
                        + "      ,[username]\n"
                        + "      ,[password]\n"
                        + "      ,[role_id]\n"
                        + "      ,[email]\n"
                        + "      ,[fullname]\n"
                        + "      ,[phone]\n"
                        + "  FROM [dbo].[account]\n"
                        + "  where role_id != 1 AND role_id !=4";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Account account = new Account();
                    account.setAccountId(rs.getInt("account_id"));
                    account.setUsername(rs.getString("username"));
                    account.setPassword(rs.getString("password"));
                    account.setRoleId(rs.getInt("role_id"));
                    account.setFullname(rs.getString("fullname"));
                    account.setEmail(rs.getString("email"));
                    account.setPhone(rs.getString("phone"));
                    accountList.add(account);
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
        return accountList;
    }

    public Account updateAccount(Account account) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        try {

            con = connect;

            if (con != null) {
                String sql = "UPDATE Account SET fullname = ?, email = ?, phone = ? WHERE username = ?";

                stm = con.prepareStatement(sql);
                stm.setString(1, account.getFullname());
                stm.setString(2, account.getEmail());
                stm.setString(3, account.getPhone());
                stm.setString(4, account.getUsername());

                int rowsUpdated = stm.executeUpdate();
                if (rowsUpdated > 0) {
                    return account;
                }
            }
        } catch (SQLException e) {
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
        return null;
    }

    public Account getAccountByEmail(String email) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM account WHERE [email] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, email);

                rs = stm.executeQuery();
                if (rs.next()) {
                    Account account = new Account();
                    account.setAccountId(rs.getInt("account_id"));
                    account.setUsername(rs.getString("username"));
                    account.setPassword(rs.getString("password"));
                    account.setRoleId(rs.getInt("role_id"));
                    account.setEmail(rs.getString("email"));
                    account.setFullname(rs.getString("fullname"));
                    account.setPhone(rs.getString("phone"));
                    List<CustomerAddress> addresses = fetchAddressesForAccount(account.getAccountId());
                    account.setAddresses(addresses);
                    CartItemDAO ciDAO = new CartItemDAO();
                    List<CartItem> cartItems = ciDAO.getCartItems(account.getAccountId());
                    account.setCartItems(cartItems);

                    return account;
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

    public int getCustomerIdByAccountId(int accountId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int customerId = -1;

        try {
            con = connect;
            String sql = "SELECT account_id FROM Account WHERE account_id = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, accountId);

            rs = stm.executeQuery();
            if (rs.next()) {
                customerId = rs.getInt("account_id");
            } else {
                throw new SQLException("Customer ID not found for Account ID: " + accountId);
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Xử lý ngoại lệ hoặc log lỗi nếu cần
            }
        }

        return customerId;
    }

    public List<CustomerAddress> fetchAddressesForAccount(int customerId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<CustomerAddress> addresses = new ArrayList<>();
        try {
            con = connect;
            String sql = "SELECT * FROM [dbo].[customer_address] WHERE [customer_id] = ? ORDER BY [is_default] desc";
            stm = con.prepareStatement(sql);
            stm.setInt(1, customerId);

            rs = stm.executeQuery();
            while (rs.next()) {
                CustomerAddress address = new CustomerAddress();
                address.setAddressId(rs.getInt("address_id"));
                address.setCustomerId(rs.getInt("customer_id"));
                address.setPhone(rs.getString("phone"));
                address.setAddress(rs.getString("address"));
                address.setIsDefault(rs.getBoolean("is_default"));
                addresses.add(address);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
        return addresses;
    }

    public void addAddress(CustomerAddress address) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = connect;
            String sql = "INSERT INTO customer_address (customer_id, phone, address) VALUES (?, ?, ?)";
            stm = con.prepareStatement(sql);
            stm.setInt(1, address.getCustomerId());
            stm.setString(2, address.getPhone());
            stm.setString(3, address.getAddress());
            stm.executeUpdate();
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

    public void updateAddress(CustomerAddress address) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = connect;
            String sql = "UPDATE customer_address SET phone = ?, address = ? WHERE address_id = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, address.getPhone());
            stm.setString(2, address.getAddress());
            stm.setInt(3, address.getAddressId());
            stm.executeUpdate();
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

    public void deleteAddress(int addressId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = connect;
            String sql = "DELETE FROM customer_address WHERE address_id = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, addressId);
            stm.executeUpdate();
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

    public void setDefaultAddress(int addressId, int customerId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = connect;
            String resetSql = "UPDATE customer_address SET is_default = 0 WHERE customer_id = ?";
            stm = con.prepareStatement(resetSql);
            stm.setInt(1, customerId);
            stm.executeUpdate();

            String sql = "UPDATE customer_address SET is_default = 1 WHERE address_id = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, addressId);
            stm.executeUpdate();
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }

    public boolean updatePassword(Account account) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = connect;
            String sql = "UPDATE Account SET password = ? WHERE username = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, account.getPassword());
            stm.setString(2, account.getUsername());
            int rowsUpdated = stm.executeUpdate();
            return rowsUpdated > 0;
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }

    public boolean changePassword(String username, String currentPassword, String newPassword) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = connect;

            if (con != null) {
                String sql = "UPDATE Account SET password = ? WHERE username = ? AND password = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, newPassword);
                stm.setString(2, username);
                stm.setString(3, currentPassword);

                int rowsUpdated = stm.executeUpdate();
                return rowsUpdated > 0;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
        return false;
    }

    public boolean validateCurrentPassword(String username, String currentPassword) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = connect;

            if (con != null) {
                String sql = "SELECT username FROM Account WHERE username = ? AND password = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, currentPassword);

                rs = stm.executeQuery();
                return rs.next();
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
        return false;
    }

    public Account getAccountById(int accountId) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Account account = new Account();
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM account WHERE [account_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, accountId);

                rs = stm.executeQuery();
                if (rs.next()) {
                    account.setAccountId(rs.getInt("account_id"));
                    account.setUsername(rs.getString("username"));
                    account.setPassword(rs.getString("password"));
                    account.setRoleId(rs.getInt("role_id"));
                    account.setEmail(rs.getString("email"));
                    account.setFullname(rs.getString("fullname"));
                    account.setPhone(rs.getString("phone"));
                    List<CustomerAddress> addresses = fetchAddressesForAccount(account.getAccountId());
                    account.setAddresses(addresses);
                    CartItemDAO ciDAO = new CartItemDAO();
                    List<CartItem> cartItems = ciDAO.getCartItems(accountId);
                    account.setCartItems(cartItems);
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
        return account;

    }

    public List<Product> getWishlistProducts(int accountId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Product> wishlistProducts = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT p.product_id, p.name, p.description, p.price, p.image1, p.image2, p.image3, p.category_id, p.is_deleted, p.rating "
                        + "FROM wishlist w "
                        + "JOIN product p ON w.product_id = p.product_id "
                        + "WHERE w.customer_id = ? ";
                stm = con.prepareStatement(sql);
                stm.setInt(1, accountId);

                rs = stm.executeQuery();
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getDouble("price"));
                    p.setImg1(rs.getString("image1"));
                    p.setImg2(rs.getString("image2"));
                    p.setImg3(rs.getString("image3"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setIsDelete(rs.getBoolean("is_deleted"));
                    p.setRating(rs.getDouble("rating"));
                    wishlistProducts.add(p);
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

        return wishlistProducts;
    }

    public boolean addToWishlist(int accountId, int productId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "INSERT INTO wishlist (customer_id, product_id) VALUES (?, ?)";
                stm = con.prepareStatement(sql);
                stm.setInt(1, accountId);
                stm.setInt(2, productId);
                int rowsInserted = stm.executeUpdate();
                return rowsInserted > 0;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
        return false;
    }

    public boolean removeFromWishlist(int accountId, int productId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "DELETE FROM wishlist WHERE customer_id = ? AND product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, accountId);
                stm.setInt(2, productId);

                int rowsDeleted = stm.executeUpdate();
                return rowsDeleted > 0;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
        return false;
    }

    public boolean isProductInWishlist(int accountId, int productId) throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = connect;
            String sql = "SELECT COUNT(*) FROM Wishlist WHERE customer_id = ? AND product_id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, accountId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return false;
    }

    public boolean updateAccountRole(int accountId, int roleId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "UPDATE [dbo].[account]\n"
                        + "   SET [role_id] = ?\n"
                        + " WHERE [account_id] = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, roleId);
                stm.setInt(2, accountId);

                int rowsDeleted = stm.executeUpdate();
                return rowsDeleted > 0;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
        return false;
    }

    public List<Account> getAllCustomer() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Account> accountList = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT [account_id]\n"
                        + "      ,[username]\n"
                        + "      ,[password]\n"
                        + "      ,[role_id]\n"
                        + "      ,[email]\n"
                        + "      ,[fullname]\n"
                        + "      ,[phone]\n"
                        + "  FROM [dbo].[account]\n"
                        + "  where role_id = 3";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Account account = new Account();
                    account.setAccountId(rs.getInt("account_id"));
                    account.setUsername(rs.getString("username"));
                    account.setPassword(rs.getString("password"));
                    account.setRoleId(rs.getInt("role_id"));
                    account.setFullname(rs.getString("fullname"));
                    account.setEmail(rs.getString("email"));
                    account.setPhone(rs.getString("phone"));
                    accountList.add(account);
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
        return accountList;
    }

    public List<Account> getAllStaff() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Account> accountList = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT [account_id]\n"
                        + "      ,[username]\n"
                        + "      ,[password]\n"
                        + "      ,[role_id]\n"
                        + "      ,[email]\n"
                        + "      ,[fullname]\n"
                        + "      ,[phone]\n"
                        + "  FROM [dbo].[account]\n"
                        + "  where role_id = 2";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Account account = new Account();
                    account.setAccountId(rs.getInt("account_id"));
                    account.setUsername(rs.getString("username"));
                    account.setPassword(rs.getString("password"));
                    account.setRoleId(rs.getInt("role_id"));
                    account.setFullname(rs.getString("fullname"));
                    account.setEmail(rs.getString("email"));
                    account.setPhone(rs.getString("phone"));
                    accountList.add(account);
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
        return accountList;
    }

    public boolean updatePasswordByEmail(String email, String newPassword) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = connect;
            String sql = "UPDATE Account SET password = ? WHERE email = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, newPassword);
            stm.setString(2, email);
            int rowsUpdated = stm.executeUpdate();
            return rowsUpdated > 0;
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }
}
