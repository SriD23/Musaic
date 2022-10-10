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
@WebServlet("/unlikeSongsDispatcher")
public class unlikeSongsDispatcher extends HttpServlet {
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

        //takes in a id and inserts into db???
        String id = request.getParameter("id");
        String name = request.getParameter("name");

        //insert or delete in the db depending on if it's already there
        //so do a sql jdbc query to see if that id exists
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
        //error checking
        if (email.equals("")) {
            System.out.println("email is empty");
            request.getRequestDispatcher("search.jsp").forward(request, response);
        }

        //jdbc to check it that specific songID and email are in the playlist table
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        }
        catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        String db = Constant.DBUrl;

        String user = Constant.DBUserName;
        String pwd = Constant.DBPassword;
        String sql = "SELECT * FROM playlist WHERE users_email=? AND songId=?";

        try (Connection conn = DriverManager.getConnection(db, user, pwd);
             PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, email);
            ps.setString(2, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
            {
                System.out.println("changed");
                //if exists --> delete
                String sql2 = "DELETE FROM playlist WHERE songId = ? AND users_email = ?";
                try (Connection conn2 = DriverManager.getConnection(db, user, pwd);
                     PreparedStatement ps2 = conn2.prepareStatement(sql2);) {
                    ps2.setString(1, id);
                    ps2.setString(2, email);
                    int row = ps2.executeUpdate(); //the number of rows affected
                    System.out.println(row);
                }
                catch (SQLException sqle) {
                    System.out.println ("SQLException: " + sqle.getMessage());
                }
            }
        }
        catch (SQLException ex) {
            System.out.println ("SQLException: " + ex.getMessage());
        }

        String likedSongs = ""; //starter string
        String sql2 = "SELECT * FROM playlist WHERE users_email=?";

        try (Connection conn = DriverManager.getConnection(db, user, pwd);
             PreparedStatement ps = conn.prepareStatement(sql2);) {
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

        new ClientThread("localhost", 6789, email, name, true);

        request.setAttribute("form", form);
        request.getRequestDispatcher("playlist/playlists.jsp").forward(request, response);

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