/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utilities;

import DAL.OrderDAO;
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

            for (int i = 0; i < Constant.CommonConst.TRACKING_CODE_LENGTH; i++) {
                trackingCodeBuilder.append(characters.charAt(random.nextInt(characters.length())));
            }

            trackingCode = "TKC" + trackingCodeBuilder.toString() + "VN";

        } while (orderDAO.isTrackingCodeExist(trackingCode));

        return trackingCode;
    }
    
    public static void main(String[] args) throws SQLException {
        
        System.out.println("Phạm Thế Tài");
        
    }

}
