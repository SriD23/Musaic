package musaic.musaic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.*;

import musaic.musaic.Util.Constant;

/**
 * Servlet implementation class RegisterDispatcher
 */
@WebServlet("/RegisterDispatcher")
public class RegisterDispatcher extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Default constructor.
     */
    public RegisterDispatcher() {
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
        //PrintWriter out = response.getWriter();

        //have to do jdbc stuff to check if the person is already registered
        //if not go ahead and add them to the database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        }
        catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        String db = Constant.DBUrl;

        String user = Constant.DBUserName;
        String pwd = Constant.DBPassword;
        String sql = "SELECT * FROM users WHERE email=?";

        //Make this pretty formatting like the example
        String error = "<div class='error'>";

        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String pass = request.getParameter("pwd");
        String confPass = request.getParameter("pwd-confirm");
        String check = request.getParameter("conditions");
        boolean err = false;


        //array of valid email endings
        String[] endings = {"com", "edu", "net", "org", "gov"};

        if (email.contentEquals(""))
        {
            error += "Error: Missing email</div>";
            request.setAttribute("error", error);
            response.sendRedirect("/auth/auth.jsp");
//            request.getRequestDispatcher("/auth/auth.jsp").forward(request, response);
        }

        //check if email already exists with JDBC SQL stuff
        try (Connection conn = DriverManager.getConnection(db, user, pwd);
             PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
            {
                err = true;
                error += "Error: Email has already been registered</div>";
                request.setAttribute("error", error);
                response.sendRedirect("/auth/auth.jsp");
//                request.getRequestDispatcher("/auth/auth.jsp").forward(request, response);
            }
        }
        catch (SQLException ex) {
            System.out.println ("SQLException: " + ex.getMessage());
        }

        if (name.contentEquals(""))
        {
            error = error += "Error: Missing name</div>";
            request.setAttribute("error", error);
            response.sendRedirect("/auth/auth.jsp");
//            request.getRequestDispatcher("/auth/auth.jsp").forward(request, response);
        }
        else if (pass.contentEquals(""))
        {
            error = error += "Error: Missing password</div>";
            request.setAttribute("error", error);
            response.sendRedirect("/auth/auth.jsp");
//            request.getRequestDispatcher("/auth/auth.jsp").forward(request, response);
        }
        else if (confPass.contentEquals(""))
        {
            error = error += "Error: Missing confirm password</div>";
            request.setAttribute("error", error);
            response.sendRedirect("/auth/auth.jsp");
//            request.getRequestDispatcher("/auth/auth.jsp").forward(request, response);
        }
        else if (!pass.equals(confPass))
        {
            error = error += "Error: Passwords do not match</div>";
            request.setAttribute("error", error);
            response.sendRedirect("/auth/auth.jsp");
//            request.getRequestDispatcher("/auth/auth.jsp").forward(request, response);
        }
        else if (check == null)
        {
            error = error += "Error: Must accept the conditions</div>";
            request.setAttribute("error", error);
            response.sendRedirect("/auth/auth.jsp");
//            request.getRequestDispatcher("/auth/auth.jsp").forward(request, response);
        }
        //error checking the name's for no special characters
        else if (!isValidName(name))
        {
            error = error += "Error: Name can only have letters and spaces</div>";
            request.setAttribute("error", error);
            response.sendRedirect("/auth/auth.jsp");
//            request.getRequestDispatcher("/auth/auth.jsp").forward(request, response);
        }
        //error check the email endings
        else if (!isValidEmail(email))
        {
            error = error += "Error: Email format not accepted</div>";
            request.setAttribute("error", error);
            response.sendRedirect("/auth/auth.jsp");
//            request.getRequestDispatcher("/auth/auth.jsp").forward(request, response);
        }
        else if (!email.split("\\.")[email.split("\\.").length -1].equals(endings[0]) && !email.split("\\.")[email.split("\\.").length -1].equals(endings[1])
                && !email.split("\\.")[email.split("\\.").length -1].equals(endings[2]) && !email.split("\\.")[email.split("\\.").length -1].equals(endings[3])
                && !email.split("\\.")[email.split("\\.").length -1].equals(endings[4]))
        {
            error = error += "Error: Email format not accepted</div>";
            request.setAttribute("error", error);
            response.sendRedirect("/auth/auth.jsp");
//            request.getRequestDispatcher("/auth/auth.jsp").forward(request, response);
        }
        else if (!err)
        {
            //jdbc stuff to insert the info to the database
            //need to insert the email name and password
            String sql2 = "INSERT INTO users (email, username, password) VALUES (?, ?, ?)";
            try (Connection conn = DriverManager.getConnection(db, user, pwd);
                 PreparedStatement ps = conn.prepareStatement(sql2);) {
                ps.setString(1, email);
                ps.setString(2, name);
                ps.setString(3, pass);
                int row = ps.executeUpdate(); //the number of rows affected
            }
            catch (SQLException sqle) {
                System.out.println ("SQLException: " + sqle.getMessage());
            }

            //have to do the cookie stuff here?
            //and have to display the user name at the top in format specified
            //change the name to help with space
            name = name.replace(" ","+");
            Cookie cookie = new Cookie("email", email);
            cookie.setMaxAge(60*60); //1 hour
            response.addCookie(cookie);

            error = "";
            request.setAttribute("error", error);
            response.sendRedirect("index.jsp");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

    public static boolean isValidEmail(String email)
    {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\."+
                "[a-zA-Z0-9_+&*-]+)*@" +
                "(?:[a-zA-Z0-9-]+\\.)+[a-z" +
                "A-Z]{2,7}$";

        Pattern pat = Pattern.compile(emailRegex);
        return pat.matcher(email).matches();
    }
    public static boolean isValidName(String name)
    {
        Pattern p = Pattern.compile("^[ A-Za-z]+$");
        Matcher m = p.matcher(name);
        return m.matches();
    }

}
