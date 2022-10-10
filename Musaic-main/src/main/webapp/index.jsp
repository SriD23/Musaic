<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="index.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Musaic</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>

<!-- <body>
  <h1>Hello Bootstrap</h1>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body> -->
</html>

<body>



<div id="header">
    <header class="navbar navbar-dark navbar-fixed-top" role="banner">
        <div class="container-fluid">
            <nav class="collapse navbar-collapse" id="navbar-nav" role="navigation">
                <ul class="nav navbar-nav navbar-right nav-main">

                    <img class = "navbar-logo" src="images/rohen-removebg-preview.png" alt="Image failed to load" style="float: left; margin-right: 15px;">

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
                                        String logOutForm = "<a href='LogoutDispatcher' id='nav-link-sign-up'>Logout</a>";
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



<div class = "artists">

<%--   <a class = "home-text" href="search/search.jsp" style="color:white;">Start Streaming Now.</a>--%>
    <a class = "home-text" href="search/search.jsp">Stream your favorite artists now.</a>



    <img class = "home-slides" src="images/i_love_csci201-removebg-preview.png" alt="Image failed to load" ></img>

    <h2 class = "about-us" >
        Musaic is at the forefront of musical streaming services. Stream top hits with just the click of a button.
    </h2>
</div>

</body>