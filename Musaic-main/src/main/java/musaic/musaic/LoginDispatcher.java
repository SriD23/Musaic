package musaic.musaic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import musaic.musaic.Util.Constant;
import javax.servlet.http.Cookie;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * Servlet implementation class LoginDispatcher
 */
@WebServlet("/LoginDispatcher")
public class LoginDispatcher extends HttpServlet {
    //    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * Default constructor.
     */
    public LoginDispatcher() {
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //TODO
        response.setContentType("text/html");
        String message = "";
        Boolean errors = false;

        String email = request.getParameter("email-login").trim();
        String password = request.getParameter("pwd-login").trim();

        // Absent data
        if (email.isEmpty() || password.isEmpty()) {
            message += "<div id=\"error\">Error: missing email or password!</div>";
            errors = true;
            request.setAttribute("error_msg", message);
            request.getRequestDispatcher("/auth.jsp").forward(request, response);
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        String sql = "SELECT email FROM Users WHERE email = ? AND password = ?";

        try (Connection conn = DriverManager.getConnection(Constant.DBUrl, Constant.DBUserName, Constant.DBPassword);
             PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            // Could not find matching login
            if (!rs.isBeforeFirst()) {
                message += "<div id=\"error\">Error: Email or password is incorrect!</div>";
                errors = true;
                request.setAttribute("error_msg", message);
                request.getRequestDispatcher("auth/auth.jsp").forward(request, response);
            } else {
                rs.next();
                Cookie email_cook = new Cookie("email", email);
                email_cook.setMaxAge(60*60);

                response.addCookie(email_cook);
                response.setContentType("text/html");

                response.sendRedirect("index.jsp");
            }
        } catch (SQLException sqle) {
            System.out.println ("SQLException: " + sqle.getMessage());
        }

    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}


