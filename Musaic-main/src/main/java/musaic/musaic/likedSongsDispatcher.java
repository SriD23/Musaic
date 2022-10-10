package musaic.musaic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.*;

import musaic.musaic.Util.Constant;


/**
 * Servlet implementation class SearchDispatcher
 */
@WebServlet("/likedSongsDispatcher")
public class likedSongsDispatcher extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Default constructor.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //TODO
        //collect the inputs
        response.setContentType("text/html");
        System.out.println("in lsd");

        String likedSongs = ""; //starter string


        Cookie[] cookies = request.getCookies();
        String email = "";
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("email"))
                {
                    email = cookie.getValue();
                }
            }
        }
        if (!email.equals("")) {
            System.out.println("Running");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            }
            catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
            String db = Constant.DBUrl;

            String user = Constant.DBUserName;
            String pwd = Constant.DBPassword;
            String sql = "SELECT * FROM playlist WHERE users_email=?";

            try (Connection conn = DriverManager.getConnection(db, user, pwd);
                 PreparedStatement ps = conn.prepareStatement(sql);) {
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                while (rs.next())
                {
                    likedSongs = likedSongs + rs.getString("songId") + " ";
                }
            }
            catch (SQLException ex) {
                System.out.println ("SQLException: " + ex.getMessage());
            }

            String form = "<form action='' method=''> "
                    + "<input type = 'hidden' id = 'liked' value = '" + likedSongs + "'>"
                    + "</form>";

            request.setAttribute("form", form);
            request.getRequestDispatcher("playlist/playlists.jsp").forward(request, response);

        }
        else {
            //send to login.jsp (search rn)
            response.sendRedirect("auth/auth.jsp");
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

