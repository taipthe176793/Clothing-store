package utilities;

import DAL.ProductDAO;
import DAL.ProductVariantDAO;
import Models.Order;
import Models.OrderDetails;
import Models.Product;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtils {

    public static final String FROM_EMAIL = "ntfstu555@gmail.com";
    public static final String FROM_PASSWORD = "wrasolcszamxspai";

    public static boolean sendEmail(String toEmail, String subject, String content) {
        // Get the session object
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
            }
        };

        Session session = Session.getInstance(props, auth);
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject(subject);
            message.setContent(content, "text/html; charset=utf-8");

            // Send message
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static String generateOrderEmailContent(Order order, String subTitleMessage) throws SQLException, ClassNotFoundException {
        StringBuilder content = new StringBuilder();
        content.append("<html>")
                .append("<head>")
                .append("<style>")
                .append("table {width: 100%; border-collapse: collapse; margin-bottom: 20px;}")
                .append("th, td {border: 1px solid #dddddd; text-align: left; padding: 8px;}")
                .append("th {background-color: #f2f2f2;}")
                .append("tr:nth-child(even) {background-color: #f9f9f9;}")
                .append("</style>")
                .append("</head>")
                .append("<body>")
                .append("<h1>").append(subTitleMessage).append("</h1>")
                .append("<p>Order Code: ").append(order.getOrderCode()).append("</p>")
                .append("<p>Date: ").append(order.getCreatedAt()).append("</p>")
                .append("<p>Customer Name: ").append(order.getFullname()).append("</p>")
                .append("<p>Shipping Address: ").append(order.getDeliveryAddress()).append("</p>")
                .append("<hr>")
                .append("<h2>Order Details</h2>")
                .append("<table>")
                .append("<tr>")
                .append("<th>Item</th>")
                .append("<th>Quantity</th>")
                .append("<th>Price</th>")
                .append("<th>Total</th>")
                .append("</tr>");

        List<OrderDetails> items = order.getListOrderDetails();
        ProductVariantDAO vDao = new ProductVariantDAO();
        ProductDAO pDao = new ProductDAO();
        for (OrderDetails item : items) {
            Product p = pDao.findProductById(vDao.findProductVariantById(item.getProductVariantId()).getProductId());
            double itemTotal = item.getQuantity() * p.getPrice();
            content.append("<tr>")
                    .append("<td>").append(p.getName()).append("</td>")
                    .append("<td>").append(item.getQuantity()).append("</td>")
                    .append("<td>$").append(String.format("%.2f", p.getPrice())).append("</td>")
                    .append("<td>$").append(String.format("%.2f", itemTotal)).append("</td>")
                    .append("</tr>")
                    .append("</table>");
        }

        content.append("<strong>Status: ")
                .append(order.getStatus()).append("</strong> <br />")
                .append("<strong>Discount: ")
                .append("$").append(String.format("%.2f", order.getDiscount())).append("</strong> <br />")
                .append("<strong>Total Amount: ")
                .append("$").append(String.format("%.2f", order.getTotalAmount())).append("</strong> <br />")
                .append("<hr>")
                .append("<p>If you have any questions about your order, please contact us at ntfstu555@gmail.com.</p>")
                .append("</body>")
                .append("</html>");

        return content.toString();
    }
}
