/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.customer;

import DAL.AccountDAO;
import Models.Account;
import Models.CustomerAddress;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author caoqu
 */
public class AddressControllers extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddressControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddressControllers at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            showAddresses(request, response);
        } else {
            switch (action) {
                case "view":
                    showAddresses(request, response);
                    break;
                default:
                    throw new AssertionError();
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            addAddress(request, response);
        } else {
            switch (action) {
                case "update":
                    updateAddress(request, response);
                    break;
                case "delete":
                    deleteAddress(request, response);
                    break;
                case "set-default":
                    setDefaultAddress(request, response);
                    break;
                default:
                    throw new AssertionError();
            }
        }
    }

    private void showAddresses(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Cookie[] arr = request.getCookies();
            int accountId = 0;
            Account account = null;

            if (arr != null) {
                for (Cookie o : arr) {

                    if (o.getName().equals("userId")) {
                        accountId = Integer.parseInt(o.getValue());
                        AccountDAO aDAO = new AccountDAO();

                        account = aDAO.getAccountById(accountId);

                        break;
                    }

                }
            }

            if (account == null) {
                response.sendRedirect(request.getContextPath() + "/Views/authen/login.jsp");
                return;
            }

            AccountDAO accountDAO = new AccountDAO();
            int customerId = accountDAO.getCustomerIdByAccountId(account.getAccountId());

            List<CustomerAddress> addresses = accountDAO.fetchAddressesForAccount(customerId);

            request.setAttribute("addresses", addresses);
            request.getRequestDispatcher("/Views/user/address.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error fetching addresses", e);
        }
    }

    private void addAddress(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Cookie[] arr = request.getCookies();
            int accountId = 0;
            Account account = null;

            if (arr != null) {
                for (Cookie o : arr) {

                    if (o.getName().equals("userId")) {
                        accountId = Integer.parseInt(o.getValue());
                        AccountDAO aDAO = new AccountDAO();

                        account = aDAO.getAccountById(accountId);

                        break;
                    }

                }
            }
            if (account == null) {
                response.sendRedirect(request.getContextPath() + "/Views/authen/login.jsp");
                return;
            }
            AccountDAO accountDAO = new AccountDAO();
            int customerId = accountDAO.getCustomerIdByAccountId(account.getAccountId());
            String phone = request.getParameter("phone");
            String city = request.getParameter("city");
            String district = request.getParameter("district");
            String ward = request.getParameter("ward");
            String stAddress = request.getParameter("stAddress");
            
            String address = city + ", " + district + ", " + ward + ", " + stAddress;

            CustomerAddress newAddress = new CustomerAddress();
            newAddress.setCustomerId(customerId);
            newAddress.setPhone(phone);
            newAddress.setAddress(address);

            accountDAO.addAddress(newAddress);

            response.sendRedirect(request.getContextPath() + "/customer/address");
        } catch (SQLException e) {
            throw new ServletException("Error adding address", e);
        }
    }

    private void updateAddress(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int addressId = Integer.parseInt(request.getParameter("id"));
            String phone = request.getParameter("phone");
            String city = request.getParameter("city");
            String district = request.getParameter("district");
            String ward = request.getParameter("ward");
            String stAddress = request.getParameter("stAddress");
            
            String address = city + ", " + district + ", " + ward + ", " + stAddress;

            CustomerAddress updatedAddress = new CustomerAddress();
            updatedAddress.setAddressId(addressId);
            updatedAddress.setPhone(phone);
            updatedAddress.setAddress(address);

            AccountDAO accountDAO = new AccountDAO();
            accountDAO.updateAddress(updatedAddress);

            response.sendRedirect(request.getContextPath() + "/customer/address");
        } catch (SQLException e) {
            throw new ServletException("Error updating address", e);
        }
    }

    private void deleteAddress(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int addressId = Integer.parseInt(request.getParameter("id"));

            AccountDAO accountDAO = new AccountDAO();
            accountDAO.deleteAddress(addressId);

            response.sendRedirect(request.getContextPath() + "/customer/address");
        } catch (SQLException e) {
            throw new ServletException("Error deleting address", e);
        }
    }

    private void setDefaultAddress(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int addressId = Integer.parseInt(request.getParameter("id"));

            Cookie[] arr = request.getCookies();
            int accountId = 0;
            Account account = null;

            if (arr != null) {
                for (Cookie o : arr) {

                    if (o.getName().equals("userId")) {
                        accountId = Integer.parseInt(o.getValue());
                        AccountDAO aDAO = new AccountDAO();

                        account = aDAO.getAccountById(accountId);

                        break;
                    }

                }
            }

            if (account == null) {
                response.sendRedirect(request.getContextPath() + "/Views/authen/login.jsp");
                return;
            }

            AccountDAO accountDAO = new AccountDAO();
            int customerId = accountDAO.getCustomerIdByAccountId(account.getAccountId());

            accountDAO.setDefaultAddress(addressId, customerId);

            List<CustomerAddress> addresses = accountDAO.fetchAddressesForAccount(customerId);

            CustomerAddress defaultAddress = null;
            for (CustomerAddress addr : addresses) {
                if (addr.getAddressId() == addressId) {
                    defaultAddress = addr;
                }
            }
            if (defaultAddress != null) {
                addresses.remove(defaultAddress);
                addresses.add(0, defaultAddress);
            }

            request.setAttribute("addresses", addresses);

            request.getRequestDispatcher("/Views/user/address.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Lỗi khi đặt địa chỉ mặc định", e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
