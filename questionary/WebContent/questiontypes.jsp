<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Web Questionary</title>
<meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/animate.css" type="text/css" />
<link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
<link rel="stylesheet" href="css/font.css" type="text/css" cache="false" />
<link rel="stylesheet" href="js/fuelux/fuelux.css" type="text/css" />
<link rel="stylesheet" href="js/datatables/datatables.css" type="text/css" />
<link rel="stylesheet" href="css/plugin.css" type="text/css" />
<link rel="stylesheet" href="css/app.css" type="text/css" />
<!--[if lt IE 9]>
    <script src="js/ie/respond.min.js" cache="false"></script>
    <script src="js/ie/html5.js" cache="false"></script>
    <script src="js/ie/fix.js" cache="false"></script>
  <![endif]-->
</head>
<% 
	if(request.getSession()==null || request.getSession().getAttribute("email")==null){
		request.getRequestDispatcher("signin.jsp").forward(request, response);
	}
%>
<body>
	<section class="hbox stretch">
		<!-- .aside -->
		<aside class="bg-dark aside-sm" id="nav">
			<section class="vbox">
				<header class="header bg-dark bg-gradient">
					<a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen" data-target="#nav"> <i class="fa fa-bars"></i>
					</a> <a href="#" class="nav-brand" data-toggle="fullscreen">Web App</a> <a class="btn btn-link visible-xs" data-toggle="class:show" data-target=".nav-user"> <i class="fa fa-comment-o"></i>
					</a>
				</header>
				<section>
					<nav class="nav-primary hidden-xs">
						<ul class="nav">
							<li><a href="index.jsp"> <b class="badge bg-primary pull-right"></b> <i class="fa fa-users"></i> <span>Questions</span>
							</a></li>
							<li class="dropdown-submenu active"><a href="questiontypes.jsp"> <i class="fa fa-question-circle"></i> <span>Question Types</span>
							</a></li>
							<li><a href="question-answer.jsp"> <i class="fa fa-pencil"></i> <span>Answers</span>
							</a></li>
								<li><a href="answerlist.jsp"> <i class="fa fa-pencil"></i> <span>Answer list</span>
							</a></li>
						</ul>
					</nav>
				</section>
				<footer class="footer bg-gradient hidden-xs">
				<a href="LogOutServlet"  class="btn btn-sm btn-link m-r-n-xs pull-right"> <i class="fa fa-power-off"></i>
					</a> <a href="#nav" data-toggle="class:nav-vertical" class="btn btn-sm btn-link m-l-n-sm"> <i class="fa fa-bars"></i>
					</a>
				</footer>
			</section>
		</aside>
		<!-- /.aside -->
		<!-- .vbox -->
		<section id="content">
			<section class="vbox">
				<header class="header bg-dark dk">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#static" data-toggle="tab">Questions</a></li>

					</ul>
				</header>
				<section class="scrollable wrapper">
					<div class="tab-content">
						<div class="tab-pane active" id="static">

							<section class="panel">

								<div class="table-responsive">
									<table class="table table-striped b-t text-sm" id="questions">
										<thead>
											<tr>
												<th>Type Name</th>
											

											</tr>
										</thead>
									</table>
								</div>
							</section>
						</div>
					</div>
				</section>
			</section>
			<a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a>
		</section>
		<!-- /.vbox -->
	</section>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script>
		var service = 'http://mgl.usask.ca:8080/question/api/';
		$(document).ready(function() {
			jQuery.support.cors = true;
			$.ajax({
				type : "GET",
				url : service + 'questions/questiontypes',
				data : "{}",
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				cache : false,
				success : function(data) {
					var trHTML = '';
					$.each(data.list, function(i, item) {
						trHTML += '<tr><td>' + item.type + '</td></tr>';
					});
					$('#questions').append(trHTML);
				},
				error : function(msg) {
					alert(msg.responseText);
				}
			});
		})
	</script>

</body>
</html>