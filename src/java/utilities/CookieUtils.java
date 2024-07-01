/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utilities;

import DAL.AccountDAO;
import Models.Account;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public class CookieUtils {

    public static String getCookieValueByName(String cookieName, HttpServletRequest request) {
        Cookie[] arr = request.getCookies();
        if (arr != null) {
            for (Cookie cookie : arr) {
                if (cookie.getName().equals(cookieName)) {
                    return cookie.getValue();
                }
            }
        }
        return "";
    }

    public static void deleteCookieByName(String cookieName, HttpServletRequest request, HttpServletResponse response) {
        Cookie[] arr = request.getCookies();
        if (arr != null) {
            for (Cookie cookie : arr) {
                if (cookie.getName().equals(cookieName)) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
    }

    public static void updateCookieValueByName(String cookieName, String value, HttpServletRequest request, HttpServletResponse response) {
        Cookie[] arr = request.getCookies();
        if (arr != null) {
            for (Cookie cookie : arr) {
                if (cookie.getName().equals(cookieName)) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    break;
                }
            }
            Cookie updateCookie = new Cookie(cookieName, value);
            updateCookie.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(updateCookie);
        }
    }

}
