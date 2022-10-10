<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <title>Results Page</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
  <script src="https://kit.fontawesome.com/70b040b9ff.js" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="../playlist/playlist.css">
  <style>
    .table th, .table td {
      text-align: center;
      vertical-align: middle;
    }
    i {
      color: red;
    }
  </style>
</head>
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

<% String form = (String) request.getAttribute("form");
  if (form != null) out.println(form);
%>

<div class="container-fluid">

  <div class="row">
    <h1 class="col-12 mt-4">Results!</h1>
  </div> <!-- .row -->

  <div class="row">

    <div class="col-12 mt-4">
      Showing <span id="num-results" class="font-weight-bold">0</span> result(s).
    </div>

    <table class="table table-responsive table-striped col-12 mt-3">
      <thead>
      <tr>
        <th>Cover</th>
        <th>Artist</th>
        <th>Track</th>
        <th>Album</th>
        <th>Preview</th>
        <th>Like Song</th>
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
  let cat = document.getElementById('cat').value;
  console.log(cat);
  let term = document.getElementById('term').value;
  console.log(term);
  let limit = document.getElementById('limit').value;
  console.log(limit)
  let likedSongs = document.getElementById('liked').value;
  console.log(likedSongs)


  // Prepare the endpoint
  let endpoint = "https://itunes.apple.com/search?term=" + term + "&limit=10&media=music&attribute=" + cat;
  console.log(endpoint);

  $.ajax({
    method: "GET",
    url: 'https://itunes.apple.com/search',

    //parameters sent separately
    data: {
      term: term,
      limit: limit,
      attribute: cat,
    }
  })
          .done(function(results) {
            //function will run when we get a result from itunes
            console.log(results)
            displayResults(results)
          })
          .fail(function(results) {
            console.log('ERRRRRORR!')
          })

  function displayResults(resultsString) {
    // Convert the JSON string to JS objects
    console.log("in results");
    let resultsJS = JSON.parse(resultsString);
    //console.log(resultsJS);

    document.querySelector("#num-results").innerHTML = resultsJS.resultCount;
    console.log(resultsJS.resultCount)

    // Clear the previous search result
    document.querySelector("tbody").replaceChildren();

    for(let i = 0; i < resultsJS.results.length; i++) {
      let img = resultsJS.results[i].artworkUrl100
      let audio = resultsJS.results[i].previewUrl
      let trackId = resultsJS.results[i].trackId

      console.log(trackId);
      let likeForm = "";

      if (!likedSongs.includes(trackId)) {
        likeForm = "<form id = '" + i+100 + "' action = 'playlistDispatcher' method = 'GET'>"
                + "<input type = 'hidden' id = 'cat' name = 'category' value = '" + cat + "'>"
                + "<input type = 'hidden' id = 'term' name = 'term' value = '" + term + "'>"
                + "<input type = 'hidden' id = 'limit' name = 'limit' value = '" + limit + "'>"
                + "<input type = 'hidden' name = 'id' value = '" + trackId + "'>"
                + "<input type = 'hidden' name = 'name' value = '" + resultsJS.results[i].trackName + "'>"
                + "<a id='" + i + "' href='#/' onclick='likeSong(" + i + ")'><i class='fa-regular fa-heart'></i></a>"
                + "</form>";
      }
      else {
        likeForm = "<form id = '" + i+100 + "' action = 'playlistDispatcher' method = 'GET'>"
                + "<input type = 'hidden' id = 'cat' name = 'category' value = '" + cat + "'>"
                + "<input type = 'hidden' id = 'term' name = 'term' value = '" + term + "'>"
                + "<input type = 'hidden' id = 'limit' name = 'limit' value = '" + limit + "'>"
                + "<input type = 'hidden' name = 'id' value = '" + trackId + "'>"
                + "<input type = 'hidden' name = 'name' value = '" + resultsJS.results[i].trackName + "'>"
                + "<a id='" + i + "' href='#/' onclick='likeSong(" + i + ")'><i class='fa-solid fa-heart'></i></a>"
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