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
@WebServlet("/SearchDispatcher")
public class SearchDispatcher extends HttpServlet {
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

        String cat = request.getParameter("options");
        String term = request.getParameter("term");
        String limit = request.getParameter("range");

        //hardcoded for now until search works
//        	String cat = "artistTerm";
//        	String term = "Drake";
//        	String limit = "18";


        //loop through the sql set and see which songs are liked?
        //but how to pass that info to the backend
        //by building a giant string?? lmao

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
        //only if there is an email
        if (!email.equals("")) {

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
        }

//			System.out.println(likedSongs);

        //add the string here

        String form = "<form action='' method=''> "
                + "<input type = 'hidden' id = 'cat' value = '" + cat + "'>"
                + "<input type = 'hidden' id = 'term' value = '" + term + "'>"
                + "<input type = 'hidden' id = 'limit' value = '" + limit + "'>"
                + "<input type = 'hidden' id = 'liked' value = '" + likedSongs + "'>"
                + "</form>";

        //reroute

        request.setAttribute("form", form);
//			response.sendRedirect("results.jsp");

        request.getRequestDispatcher("results/results.jsp").forward(request, response);

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
