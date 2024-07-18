///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package Controllers;
//
//import com.pusher.rest.Pusher;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.BufferedReader;
//import java.util.Collections;
//import org.json.JSONObject;
//
///**
// *
// * @author admin
// */
//public class SendMessageServlet extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet SendMessageServlet</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet SendMessageServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("application/json;charset=UTF-8");
//
//        StringBuilder jsonBuffer = new StringBuilder();
//        String line = null;
//        try (BufferedReader reader = request.getReader()) {
//            while ((line = reader.readLine()) != null) {
//                jsonBuffer.append(line);
//            }
//        }
//
//        String jsonString = jsonBuffer.toString();
//        JSONObject jsonObject = new JSONObject(jsonString);
//        String message = jsonObject.getString("message");
//
//        Pusher pusher = new Pusher("1835384", "72b2a0d0d5af33522f53", "7ec0cb4b69446d8afca0");
//        pusher.setCluster("ap1");
//        pusher.setEncrypted(true);
//        try {
//            pusher.trigger("chat-channel", "message-event", Collections.singletonMap("message", message));
//        } catch (Exception e) {
//            e.printStackTrace(); // Print full stack trace for debugging
//            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//            PrintWriter out = response.getWriter();
//            out.print("{\"error\":\"Internal Server Error\"}");
//            out.flush();
//        }
//        try (PrintWriter out = response.getWriter()) {
//            out.print("{\"status\":\"Message sent\"}");
//            out.flush();
//        }
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
