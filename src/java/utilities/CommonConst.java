package utilities;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author ADMIN
 */
public class CommonConst {

    public static final String GOOGLE_CLIENT_ID = "927392698257-i0te23e7qorb6jr5upat4d8ae26ih03f.apps.googleusercontent.com";
    public static final String GOOGLE_CLIENT_SECRET = "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";
    public static final String GOOGLE_REDIRECT_URI = "http://localhost:8080/SWP391_SE1817/auth?action=loginWithGoogle";
    public static final String GOOGLE_GRANT_TYPE = "authorization_code";
    public static final String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    public static final int ROLE_ADMIN = 1;
    public static final int ROLE_STAFF = 2;
    public static final int ROLE_CUSTOMER = 3;
    public static final int ROLE_GUEST = 4;

    public static final String NOTIFICATION = "notification";
    public static final String NOTI_TYPE = "type";

    public static final String NOTI_SUCCESS = "alert-box-success";
    public static final String NOTI_WARNING = "alert-box-warning";
    public static final String NOTI_ERROR = "alert-box-danger";
    public static final String NOTI_INFO = "alert-box-info";

    public static final String ORDER_PENDING_STATUS = "Pending";
    public static final String ORDER_SHIPPED_STATUS = "Shipping";
    public static final String ORDER_DELIVERED_STATUS = "Delivered";
    public static final String ORDER_CANCELLED_STATUS = "Cancelled";

    public static final String COD_METHOD = "cod";
    public static final String VNPAY_METHOD = "vnpay";

    public static final int TRACKING_CODE_LENGTH = 10;

    public static final char OPERATION_DESCREASE = '-';
    public static final char OPERATION_INCREASE = '+';
    
    public static final String CART_COOKIE = "cart";
    public static final String ITEMS_NUMBER_CART_COOKIE = "cin";
    
    public static final String USER_ID_COOKIE = "userId";    

}
