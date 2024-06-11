/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Account;
import Models.CustomerAddress;
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
                        + "VALUES( ?, ?, ?, ?, ?, ?, ?)";
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
                    List<CustomerAddress> addresses = fetchAddressesForAccount(con, account.getAccountId());
                    account.setAddresses(addresses);
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
                    List<CustomerAddress> addresses = fetchAddressesForAccount(con, account.getAccountId());
                    account.setAddresses(addresses);
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
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT [account_id]\n"
                        + "      ,[username]\n"
                        + "      ,[password]\n"
                        + "      ,[role_id]\n"
                        + "      ,[email]\n"
                        + "      ,[phone]\n"
                        + "  FROM [dbo].[account]\n"
                        + "  where role_id != 1";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Account account = new Account();
                    account.setAccountId(rs.getInt("account_id"));
                    account.setUsername(rs.getString("username"));
                    account.setPassword(rs.getString("password"));
                    account.setRoleId(rs.getInt("role_id"));
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
                    List<CustomerAddress> addresses = fetchAddressesForAccount(con, account.getAccountId());
                    account.setAddresses(addresses);
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

    private List<CustomerAddress> fetchAddressesForAccount(Connection con, int accountId) throws SQLException {
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<CustomerAddress> addresses = new ArrayList<>();
        try {
            String sql = "SELECT * FROM address WHERE account_id = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, accountId);

            rs = stm.executeQuery();
            while (rs.next()) {
                CustomerAddress address = new CustomerAddress();
                address.setAddressId(rs.getInt("address_id"));
                address.setCustomerId(rs.getInt("customer_id"));
                address.setPhone(rs.getString("phone"));
                address.setAddress(rs.getString("address"));
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
}
