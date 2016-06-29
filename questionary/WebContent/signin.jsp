<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Questionary web</title>
<meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/animate.css" type="text/css" />
<link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
<link rel="stylesheet" href="css/font.css" type="text/css" cache="false" />
<link rel="stylesheet" href="css/plugin.css" type="text/css" />
<link rel="stylesheet" href="css/app.css" type="text/css" />
<!--[if lt IE 9]>
    <script src="js/ie/respond.min.js" cache="false"></script>
    <script src="js/ie/html5.js" cache="false"></script>
    <script src="js/ie/fix.js" cache="false"></script>
  <![endif]-->
</head>
<body>
	<section id="content" class="m-t-lg wrapper-md animated fadeInUp">
		<a class="nav-brand" href="index.html">Questionary web</a>
		<div class="row m-n">
			<div class="col-md-4 col-md-offset-4 m-t-lg">
				<section class="panel">
					<header class="panel-heading text-center"> Sign in </header>
					<form  class="panel-body" action="login" method="post">
						<div class="form-group">
							<label class="control-label">Email</label> <input type="email" placeholder="test@example.com" id="inputEmail" name="inputEmail" class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label">Password</label> <input type="password" id="inputPassword" placeholder="Password" name="inputPassword" class="form-control">
						</div>
						<div class="checkbox">
							<label> <input type="checkbox"> Keep me logged in
							</label>
						</div>
						<button type="submit" class="btn btn-info" onclick="login()">Sign in</button>
						<div class="line line-dashed"></div>

					</form>
				</section>
			</div>
		</div>
	</section>
	<!-- footer -->
	<footer id="footer">
		<div class="text-center padder clearfix">
			<p>
				<small>Questionary web application<br>&copy; 2016
				</small>
			</p>
		</div>
	</footer>
	<!-- / footer -->
	<script >
	
	
	</script>
	<script src="js/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.js"></script>
	<!-- app -->
	<script src="js/app.js"></script>
	<script src="js/app.plugin.js"></script>
	<script src="js/app.data.js"></script>
</body>
</html>