/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utilities;

import DAL.OrderDAO;
import jakarta.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.Random;

/**
 *
 * @author admin
 */
public class GeneratorUtils {

    public static String generateOrderTrackingCode() throws SQLException {

        StringBuilder trackingCodeBuilder;
        String trackingCode = "";
        OrderDAO orderDAO = new OrderDAO();

        do {

            trackingCodeBuilder = new StringBuilder();
            String characters = "0123456789";
            Random random = new Random();

            for (int i = 0; i < utilities.CommonConst.TRACKING_CODE_LENGTH; i++) {
                trackingCodeBuilder.append(characters.charAt(random.nextInt(characters.length())));
            }

            trackingCode = "TKC" + trackingCodeBuilder.toString() + "VN";

        } while (orderDAO.isTrackingCodeExist(trackingCode));

        return trackingCode;
    }

    public static void makeNotification(HttpServletRequest request, String message, String type) {
        request.getSession().setAttribute(utilities.CommonConst.NOTIFICATION, message);
        request.getSession().setAttribute(utilities.CommonConst.NOTI_TYPE, type);
    }

    public static void getNotification(HttpServletRequest request) {

        if (request.getSession().getAttribute(utilities.CommonConst.NOTIFICATION) != null) {

            request.setAttribute(utilities.CommonConst.NOTIFICATION,
                    request.getSession().getAttribute(utilities.CommonConst.NOTIFICATION));

            request.setAttribute(utilities.CommonConst.NOTI_TYPE,
                    request.getSession().getAttribute(utilities.CommonConst.NOTI_TYPE));

            request.getSession().invalidate();
        }
    }

}
