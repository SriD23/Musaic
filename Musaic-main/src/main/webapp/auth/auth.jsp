<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta content="301645777112-2rlc9gth0f5d4reimjcm9bf0kj7ahec0.apps.googleusercontent.com"
        name="google-signin-client_id">
  <title>Login / Register</title>
  <link rel="stylesheet" href="auth.css">

  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link crossorigin href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

  <script src="https://apis.google.com/js/platform.js" async defer></script>
  <meta name="google-signin-client_id" content="9613097655-tb5emdkt36nttdv2e91f6j7u8u4dghjh.apps.googleusercontent.com">

  <link href="index.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" type="text/css">
  <script src="https://apis.google.com/js/api:client.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

</head>
<body>
<!--  Display errors -->


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

<div id="row">
  <div id="login-content">
    <form action="../LoginDispatcher" id="login" method="GET">
      <h1>Login</h1>
      <p>Email</p>
      <input type="email" id="email-login" class="blacktext" name="email-login" size=60% required>
      <p>Password</p>
      <input type="password" id="pwd-login" class="blacktext" name="pwd-login" size=60% required>
      <div>
        <button type="submit" id="login-button" form="login" value="Submit"><i class="fa fa-sign-in"></i> Sign in</button>
      </div>

    </form>
  </div>


  <form action="../RegisterDispatcher" id="register" method="GET">
    <div id="register-content">
      <h1>Register</h1>
      <p>Email</p>
      <input type="email" id="email-register" class="blacktext" name="email" size=60% required>
      <p>Name</p>
      <input type="text" id="name-register" class="blacktext" name="name" size=60% required>
      <p>Password</p>
      <input type="password" id="pwd-register" class="blacktext" name="pwd" size=60% required>
      <p>Confirm Password</p>
      <input type="password" id="pwd-confirm" class="blacktext" name="pwd-confirm" size=60% required>
    </div>
    <input type="checkbox" id="conditions" name="conditions" value="True" required>I have read and agreed to all terms and conditions of Musaic.
    <div>
      <button type="submit" id="register-button" form="register" value="Submit"><i class="fa fa-solid fa-user-plus"></i> Create Account</button>
    </div>

  </form>

</div>

<%
  String error = (String) request.getAttribute("error_msg");
  if (error != null) {
    out.println(error);
  }
%>

<script>
  function onSuccess(googleUser) {
    var profile = googleUser.getBasicProfile();
    var name = profile.getName();
    var email = profile.getEmail();
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.disconnect();

    window.location.href = "../GoogleDispatcher?name="+name+"&email="+email;
  }

  function onFailure(error) {
    console.log(error);
  }

  function renderButton() {
    gapi.signin2.render('my-signin2', {
      'scope': 'profile email',
      'width': 415,
      'height': 35,
      'longtitle': true,
      'theme': 'dark',
      'onsuccess': onSuccess,
      'onfailure': onFailure
    });
  }
</script>

<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>


</body>
</html>