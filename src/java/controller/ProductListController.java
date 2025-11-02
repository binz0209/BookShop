/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customers;
import model.Pagination;
import model.Products;

/**
 *
 * @author Admin
 */
@WebServlet(name="ProductListController", urlPatterns={"/productlist"})
public class ProductListController extends HttpServlet {
   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        session.setAttribute("listC", DAO.INSTANCE.getAllCategories());
        
        // ?lấy tham số filter từ JSP
        String categoryId_raw = request.getParameter("categoryId");
        String priceRange = request.getParameter("priceRange");
        
        // ?lấy account (để kiểm tra admin hay user)
        Customers customer = (Customers) session.getAttribute("account");
        List<Products> p = null;
        if (customer != null && customer.isRole() == true) {
            p = DAO.INSTANCE.manageProductsByAddmin();
        } else  {
            p = DAO.INSTANCE.getAllProducts();
        }
        request.setAttribute("products", p);
        
        // ?nếu có filter thì lọc sản phẩm
        if ((categoryId_raw != null && !categoryId_raw.isEmpty()) || (priceRange != null && !priceRange.isEmpty())) {
            try {
                int categoryId = (categoryId_raw == null || categoryId_raw.equals("0"))
                        ? 0
                        : Integer.parseInt(categoryId_raw);
                p = DAO.INSTANCE.filterProducts( categoryId, priceRange);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        // ?hiển thị best option (top 3 sản phẩm)
        List<Products> bestProducts = DAO.INSTANCE.getBestOptionProducts();
        request.setAttribute("bestProducts", bestProducts);
        
        // ?phân trang
        Pagination page;
        if (session.getAttribute("page") == null) {
            page = new Pagination(p.size(), 6, 1);
        } else if (request.getParameter("cp") != null) {
            int cp = Integer.parseInt(request.getParameter("cp"));
            page = new Pagination(p.size(), 6, cp);
        } else {
            page = (Pagination) session.getAttribute("page");
        }

        session.setAttribute("page", page);
        request.setAttribute("products", DAO.INSTANCE.getProductsByPage(page.getCurrentPage(), page.getPageLimit(), p));

        request.getRequestDispatcher("Views/productlist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("listC", DAO.INSTANCE.getAllCategories());
        doGet(request, response);
    }

}
