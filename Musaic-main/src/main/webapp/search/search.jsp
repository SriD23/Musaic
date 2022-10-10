<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link rel="stylesheet" type="text/css" href="search.css">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

</head>
<body>

<div id="header">
    <header class="navbar navbar-dark navbar-fixed-top" role="banner">
        <div class="container-fluid">
            <nav class="collapse navbar-collapse" id="navbar-nav" role="navigation">
                <ul class="nav navbar-nav navbar-right nav-main">

                    <img class = "navbar-logo" src="../images/rohen-removebg-preview.png" alt="Image failed to load" style="float: left; margin-right: 15px;">

                    <li>
                        <a href="../index.jsp" id="nav-pic">
                            Musaic
                        </a>
                    </li>
                    <li>
                        <a href="../search/search.jsp" id="nav-search">
                            Search
                        </a>
                    </li>
                    <li>
                        <a href="../likedSongsDispatcher" id="nav-link-liked-songs">
                            Liked Songs
                        </a>
                    </li>
                    <li role="separator" class="divider"></li>
                    <li>
                        <%
                            boolean def = true;
                            String reg = "<a href='../auth/auth.jsp' id='nav-link-sign-up'>Login / Register</a>";
                            Cookie[] cookies2 = request.getCookies();
                            if (cookies2 != null) {
                                for (Cookie cookie : cookies2) {
                                    if (cookie.getName().equals("email"))
                                    {
                                        String logOutForm = "<a href='../LogoutDispatcher' id='nav-link-sign-up'>Logout</a>";
                                        def = false;
                                        out.println(logOutForm);
                                    }
                                }
                            }
                            if (def) {
                                out.println(reg);
                            }
                        %>

                    </li>
                </ul>
            </nav>
        </div>
    </header>
</div>


<form action = "../SearchDispatcher" method = "GET" class = "searchPage">
    <div class = "searchbar">
        <%--dropdown bar--%>
        <select name="options" class="options">
            <option value="artistTerm" class="dropdown">Artist</option>
            <option value="albumTerm" class="dropdown">Album</option>
            <option value="songTerm" class="dropdown">Song Title</option>
        </select>
        <%--searchbar--%>
        <div class = "searchbardirect">
            <input type = "text" name = "term" required Placeholder = "Search...">
        </div>
    </div>
    <%--slider--%>
    <div class = "numberofresults">
        <div class = "songnum">
            <%--for text--%>
            <div class = barText>
                <p>Select how many results you would like: <span id="demo"></span></p>
            </div>
            <input type="range" name="range" min="1" max="25" value="13" class="slider" id="myRange">
            <script type = "text/javascript">
                var slider = document.getElementById("myRange");
                var output = document.getElementById("demo");
                output.innerHTML = slider.value; // Display the default slider value
                // Update the current slider value (each time you drag the slider handle)
                slider.oninput = function() {
                    output.innerHTML = this.value;
                }
            </script>
        </div>
    </div>
    <br>
    <br>
    <%--    TODO: change button--%>
    <div class = "searchbarsubmit">
        <button class = "searchsong btn btn-primary" type = "submit"><i class="fa fa-search fa-2x"></i>
            Search!
        </button>
    </div>
</form>
</body>
</html>