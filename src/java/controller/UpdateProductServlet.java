/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Categories;
import model.Products;

/**
 *
 * @author Admin
 */
public class UpdateProductServlet extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProductServlet at " + request.getContextPath() + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("pid"));
        Products p = DAO.INSTANCE.getProductById(id);
        request.setAttribute("update", p);
        DAO dao = new DAO();
        List<Categories> lcate = dao.getAllCategories();
        request.setAttribute("listCate", lcate);
        request.getRequestDispatcher("Views/update.jsp").forward(request, response);
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

        // Nếu form có tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy tham số từ form
        String id_raw = request.getParameter("id");
        String price_raw = request.getParameter("price");
        String quantity_raw = request.getParameter("quantity");
        String cateID_raw = request.getParameter("cateID");
        String status_raw = request.getParameter("status"); // map với isContinue
        System.out.printf("[RAW] id=%s, price=%s, qty=%s, cateID=%s, status=%s%n",
        id_raw, price_raw, quantity_raw, cateID_raw, status_raw);
        try {
            // 1) Kiểm tra thiếu tham số
            if (id_raw == null || price_raw == null || quantity_raw == null || cateID_raw == null) {
                throw new IllegalArgumentException("Thiếu tham số: id/price/quantity/cateID");
            }

            // 2) Parse các giá trị số nguyên
            int id = Integer.parseInt(id_raw.trim());
            int quantity = Integer.parseInt(quantity_raw.trim());
            int cateID = Integer.parseInt(cateID_raw.trim());

            // 3) Chuẩn hoá và parse price (xử lý '99,000' hoặc '99.000')
            String priceNormalized = price_raw.replaceAll("[^0-9]", "");
            if (priceNormalized.isEmpty()) {
                throw new NumberFormatException("Giá trị price không hợp lệ: '" + price_raw + "'");
            }
            long price = Long.parseLong(priceNormalized);

            // 4) Parse status (nếu null thì mặc định 0 = đang bán)
            int status = 0;
            if (status_raw != null && !status_raw.trim().isEmpty()) {
                status = Integer.parseInt(status_raw.trim());
            }

            // 5) Log tham số để chắc chắn truyền đúng
            System.out.printf(
                    "UpdateProduct args -> id=%d, price=%d (raw='%s'), qty=%d, cateID=%d, status=%d%n",
                    id, price, price_raw, quantity, cateID, status
            );

            // 6) Gọi DAO cập nhật
            DAO dao = DAO.getINSTANCE(); // dùng instance thống nhất
            dao.updateProduct(id, price, quantity, cateID, status);
            System.out.println("Update product done!");

            // 7) Nếu cần: verify ngay sau cập nhật (debug)
            // Products p = dao.getProductById(id);
            // if (p != null) {
            //     System.out.printf("DB after update -> id=%d, price=%d, qty=%d, cateID=%d, status=%d%n",
            //             p.getId(), p.getPrice(), p.getQuantity(), p.getCategoryID(), p.getStatus());
            // }
            // 8) Thành công -> quay về list
            response.sendRedirect("productlist?cp=1");
            return;

        } catch (Exception e) {
            e.printStackTrace();
            // Gửi thông báo lỗi + giữ lại dữ liệu form để user sửa
            request.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
            request.setAttribute("id", id_raw);
            request.setAttribute("price", price_raw);
            request.setAttribute("quantity", quantity_raw);
            request.setAttribute("cateID", cateID_raw);
            request.setAttribute("status", status_raw);

            // Bạn có thể forward về trang update.jsp (nhớ set list category trước đó trong doGet)
            request.getRequestDispatcher("Views/update.jsp").forward(request, response);
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
