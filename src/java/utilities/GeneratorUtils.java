/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utilities;

import DAL.OrderDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Random;

/**
 *
 * @author admin
 */
public class GeneratorUtils {

    public static String generateOrderCode() throws SQLException {

        StringBuilder orderCodeBuilder;
        String orderCode = "";
        OrderDAO orderDAO = new OrderDAO();

        do {

            orderCodeBuilder = new StringBuilder();
            String characters = "0123456789";
            Random random = new Random();

            for (int i = 0; i < utilities.CommonConst.ORDER_CODE_LENGTH; i++) {
                orderCodeBuilder.append(characters.charAt(random.nextInt(characters.length())));
            }

            orderCode = "ORD" + orderCodeBuilder.toString() + "VN";

        } while (orderDAO.isOrderCodeExist(orderCode));

        return orderCode;
    }

    public static void makeNotification(HttpServletRequest request, String message, String type) {
        HttpSession session = request.getSession();
        session.setAttribute(utilities.CommonConst.NOTIFICATION, message);
        session.setAttribute(utilities.CommonConst.NOTI_TYPE, type);
    }

    public static void getNotification(HttpServletRequest request) {

        HttpSession session = request.getSession();

        if (session.getAttribute(utilities.CommonConst.NOTIFICATION) != null) {

            request.setAttribute(utilities.CommonConst.NOTIFICATION,
                    session.getAttribute(utilities.CommonConst.NOTIFICATION));
            session.removeAttribute(utilities.CommonConst.NOTIFICATION);
        }

        if (session.getAttribute(utilities.CommonConst.NOTI_TYPE) != null) {

            request.setAttribute(utilities.CommonConst.NOTI_TYPE,
                    session.getAttribute(utilities.CommonConst.NOTI_TYPE));

            session.removeAttribute(utilities.CommonConst.NOTI_TYPE);
        }
    }
    
    public static String generateRandomPassword() throws SQLException {

        StringBuilder randomPassBuilder;
        String password = "";
        OrderDAO orderDAO = new OrderDAO();

        do {

            randomPassBuilder = new StringBuilder();
            String characters = "0123456789";
            Random random = new Random();

            for (int i = 0; i < 10; i++) {
                randomPassBuilder.append(characters.charAt(random.nextInt(characters.length())));
            }

            password = randomPassBuilder.toString();

        } while (orderDAO.isOrderCodeExist(password));

        return password;
    }

}
