package utilities;

import Config.Config;
import jakarta.servlet.http.HttpServletRequest;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import java.util.stream.Collectors;

import static utilities.CommonConst.TMN_ID;
import static utilities.CommonConst.VNPAY_KEY;
import static utilities.CommonConst.VNPAY_URL;

public class VNPayUtils {

    public static String generatePaymentUrl(String orderId, double amount, String orderInfo, String returnUrl, HttpServletRequest request) throws NoSuchAlgorithmException, UnsupportedEncodingException {

        String vnp_IpAddr = Config.getIpAddress(request);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());

        Map<String, String> params = new HashMap<>();
        params.put("vnp_Version", "2.1.0");
        params.put("vnp_Command", "pay");
        params.put("vnp_TmnCode", TMN_ID);
        params.put("vnp_Amount", String.valueOf((long) (amount * 100)));
        params.put("vnp_CurrCode", "VND");
        params.put("vnp_TxnRef", orderId);
        params.put("vnp_OrderInfo", orderInfo);
        params.put("vnp_OrderType", "other");
        params.put("vnp_Locale", "vn");
        params.put("vnp_ReturnUrl", returnUrl);
        params.put("vnp_IpAddr", vnp_IpAddr);
        params.put("vnp_CreateDate", vnp_CreateDate);
        params.put("vnp_ExpireDate", vnp_ExpireDate);

        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();

        for (String fieldName : fieldNames) {
            String fieldValue = params.get(fieldName);
            if (fieldValue != null && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName).append("=").append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append("=");
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (!fieldName.equals(fieldNames.get(fieldNames.size() - 1))) {
                    query.append("&");
                    hashData.append("&");
                }
            }
        }
        String queryString = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(VNPAY_KEY, hashData.toString());
        queryString += "&vnp_SecureHash=" + vnp_SecureHash;

        return VNPAY_URL + "?" + queryString;
    }

    public static boolean verifyResponse(Map<String, String> vnpParams) {
        String vnpSecureHash = vnpParams.remove("vnp_SecureHash");

        List<String> fieldNames = new ArrayList<>(vnpParams.keySet());
        Collections.sort(fieldNames);

        StringBuilder hashData = new StringBuilder();
        try {
            for (String fieldName : fieldNames) {
                String fieldValue = vnpParams.get(fieldName);
                if (fieldValue != null && fieldValue.length() > 0) {
                    hashData.append(fieldName).append("=").append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    if (!fieldName.equals(fieldNames.get(fieldNames.size() - 1))) {
                        hashData.append("&");
                    }
                }
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return false;
        }

        String secureHash = Config.hmacSHA512(VNPAY_KEY, hashData.toString());

        return vnpSecureHash.equals(secureHash);
    }
}
