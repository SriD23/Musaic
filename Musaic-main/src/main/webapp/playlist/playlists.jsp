<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Liked Songs Page</title>
<%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/70b040b9ff.js" crossorigin="anonymous"></script>
    <style>
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        i {
            color: red;
        }
        .navbar-dark {
            background-color: black;
        }

        .navbar-dark .navbar-nav>li>a {
            color: #fff;
            padding: 28px 17px;
            font-weight: 700;
            line-height: 24px;
        }

        .nav>li>a:focus,
        .nav>li>a:hover {
            background-color: black !important;
            color: #ff00ff;
        }

        .nav .divider {
            background-color: #d9dadc;
            width: 1px;
            height: 16px;
            margin: 32px 17px;
        }

        .navbar-logo {
            margin-right:500px;
            margin-top: 2px;
            margin-bottom: 2px;
            max-width: 7%;
            max-height: 7%;
            background-repeat: no-repeat;
            background-size: 100% 100%;
            color: transparent;
            text-shadow: none;
            background-color: transparent;
            border: 0;
            float: left;
            padding-top:0px;
        }

        /* .nav-pic{
            margin-top: 2000px;
            padding-right: 1500px;

        } */

        .nav .img-banner {
            width:150px;
            height: auto;
            margin: auto 5px;
            float: left;
        }

        .nav #nav-pic
        {
            font-size: 400%;
            margin-top: 28px;
            margin-bottom: 0px;
            padding-top:0px;
            padding-bottom:0px;
            margin-right:550px;
        }

        .container
        {
            padding-top: 0px;
        }

        #header {
            margin-bottom: 10%;
        }
    </style>
</head>
<body>
<% String form = (String) request.getAttribute("form");
    if (form != null) out.println(form);
%>

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

<div class="container-fluid">

    <div class="row">
        <h1 class="col-12 mt-4">Liked Songs</h1>
    </div> <!-- .row -->

    <div class="row">

        <div class="col-12 mt-4">
            Showing <span id="num-results" class="font-weight-bold"></span> result(s).
        </div>

        <table class="table table-responsive table-striped col-12 mt-3">
            <thead>
            <tr>
                <th>Cover</th>
                <th>Artist</th>
                <th>Track</th>
                <th>Album</th>
                <th>Preview</th>
                <th>Remove Song</th>
            </tr>
            </thead>
            <tbody>



            </tbody>
        </table>
    </div> <!-- .row -->

</div> <!-- .container-fluid -->


<script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
<script>

    // getting attributes from the form that got passed in
    let likedSongs = document.getElementById('liked').value;
    console.log(likedSongs)

    //split into array
    let songArr = likedSongs.split(" ");
    console.log(songArr)
    console.log(songArr.length)

    document.querySelector("tbody").replaceChildren();

    // Prepare the endpoint
    for (let i = 0; i < songArr.length -1; i++) {

        $.ajax({
            method: "GET",
            url: 'https://itunes.apple.com/lookup',

            //parameters sent separately
            data: {
                id: songArr[i],
            }
        })
            .done(function(results) {
                //function will run when we get a result from itunes
                console.log(results)
                displayResults(results, i)
            })
            .fail(function(results) {
                console.log('ERRRRRORR!')
            })
    }

    function displayResults(resultsString, j) {
        // Convert the JSON string to JS objects
        console.log("in results");
        let resultsJS = JSON.parse(resultsString);
        //console.log(resultsJS);

        //document.querySelector("#num-results").innerHTML = resultsJS.resultCount;
        //console.log(resultsJS.resultCount)

        for(let i = 0; i < resultsJS.results.length; i++) {
            let img = resultsJS.results[i].artworkUrl100
            let audio = resultsJS.results[i].previewUrl
            let trackId = resultsJS.results[i].trackId

            console.log(trackId);
            let likeForm = "";

            if (!likedSongs.includes(trackId)) {
                likeForm = "<form id = '" + j+100 + "' action = 'unlikeSongsDispatcher' method = 'GET'>"
                    + "<input type = 'hidden' name = 'id' value = '" + trackId + "'>"
                    + "<input type = 'hidden' name = 'name' value = '" + resultsJS.results[i].trackName + "'>"
                    + "<a id='" + j + "' href='#/' onclick='likeSong(" + j + ")'><i class='fa-regular fa-heart'></i></a>"
                    + "</form>";
            }
            else {
                likeForm = "<form id = '" + j+100 + "' action = 'unlikeSongsDispatcher' method = 'GET'>"
                    + "<input type = 'hidden' name = 'id' value = '" + trackId + "'>"
                    + "<input type = 'hidden' name = 'name' value = '" + resultsJS.results[i].trackName + "'>"
                    + "<a id='" + j + "' href='#/' onclick='likeSong(" + j + ")'><i class='fa-solid fa-heart'></i></a>"
                    + "</form>";
            }

            let htmlString = "<tr><td><img src=" + "\""+ img +  "\"" + "></td><td>" + resultsJS.results[i].artistName + "</td>"
                + "<td>" + resultsJS.results[i].trackName + "</td><td>" + resultsJS.results[i].collectionName + "</td>"
                + "<td><audio src=" + "\"" + resultsJS.results[i].previewUrl + "\"" +" controls></audio></td>"
                + "<td>" + likeForm + "</td></tr>";

            document.querySelector("tbody").innerHTML += htmlString;
            //console.log(htmlString);
            //console.log("pls")

        }

    }

    function likeSong(i) {
        let toggle = document.getElementById(i);
        console.log(i)
        console.log(document.getElementById(i))
        let display = toggle.innerHTML;
        console.log(toggle);
        console.log(toggle.innerHTML);
        console.log(display === '<i class="fa-regular fa-heart"></i>')
        if (display === '<i class="fa-regular fa-heart"></i>') {
            document.getElementById(i).innerHTML = "<i class='fa-solid fa-heart'></i>";
            console.log("in if")
        }
        else {
            document.getElementById(i).innerHTML = '<i class="fa-regular fa-heart"></i>';
            console.log("in else")
        }
        document.getElementById(i+"100").submit();
        //create and delete cookies in the java file to keep track of which songs are liked?
    }




</script>
</body>
</html>