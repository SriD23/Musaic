package musaic.musaic.Util;

import java.util.regex.Pattern;

public class Constant {

    static public String DBUrl = "jdbc:mysql://localhost:3306/MusaicDB";
    static public String DBUserName = "root";
    static public String DBPassword = "rootroot";

    static public Pattern namePattern = Pattern.compile("^[ A-Za-z]+$");
    static public Pattern emailPattern = Pattern.compile("^[a-zA-Z0-9_+&*-]+(?:\\."
            + "[a-zA-Z0-9_+&*-]+)*@"
            + "(?:[a-zA-Z0-9-]+\\.)+[a-z"
            + "A-Z]{2,7}$");

}

