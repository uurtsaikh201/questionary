<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Questionary App</title>
<meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="css/animate.css" type="text/css" />
<link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
<link rel="stylesheet" href="css/font.css" type="text/css" cache="false" />
<link rel="stylesheet" href="js/select2/select2.css" type="text/css" />
<link rel="stylesheet" href="js/fuelux/fuelux.css" type="text/css" />
<link rel="stylesheet" href="js/datepicker/datepicker.css" type="text/css" />
<link rel="stylesheet" href="js/slider/slider.css" type="text/css" />
<link rel="stylesheet" href="css/plugin.css" type="text/css" />
<link rel="stylesheet" href="css/app.css" type="text/css" />
<script src="js/jquery.min.js"></script>
  <!-- Bootstrap -->
  <script src="js/bootstrap.js"></script>
  <!-- app -->
  <script src="js/app.js"></script>
  <script src="js/app.plugin.js"></script>
  <script src="js/app.data.js"></script>
  <!-- fuelux -->
  <script src="js/fuelux/fuelux.js"></script>
  <!-- datepicker -->
  <script src="js/datepicker/bootstrap-datepicker.js"></script>
  <!-- slider -->
  <script src="js/slider/bootstrap-slider.js"></script>
  <!-- file input -->  
  <script src="js/file-input/bootstrap.file-input.js"></script>
  <!-- combodate -->
  <script src="js/libs/moment.min.js"></script>
  <script src="js/combodate/combodate.js" cache="false"></script>
  <!-- parsley -->
  <script src="js/parsley/parsley.min.js" cache="false"></script>
  <script src="js/parsley/parsley.extend.js" cache="false"></script>
  <!-- select2 -->
  <script src="js/select2/select2.min.js" cache="false"></script>
  <!-- wysiwyg -->
  <script src="js/wysiwyg/jquery.hotkeys.js" cache="false"></script>
  <script src="js/wysiwyg/bootstrap-wysiwyg.js" cache="false"></script>
  <script src="js/wysiwyg/demo.js" cache="false"></script>
  <!-- markdown -->
  <script src="js/markdown/epiceditor.min.js" cache="false"></script>
  <script src="js/markdown/demo.js" cache="false"></script>
<!--[if lt IE 9]>
    <script src="js/ie/respond.min.js" cache="false"></script>
    <script src="js/ie/html5.js" cache="false"></script>
    <script src="js/ie/fix.js" cache="false"></script>
  <![endif]-->
</head>
<%
	if (request.getSession() == null || request.getSession().getAttribute("email") == null) {
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
							<li class="dropdown-submenu active"><a href="index.jsp"> <b class="badge bg-primary pull-right"></b> <i class="fa fa-users"></i> <span>Questions</span>
							</a></li>
							<li><a href="questiontypes.jsp"> <i class="fa fa-question-circle"></i> <span>Question Types</span>
							</a></li>
							<li><a href="question-answer.jsp"> <i class="fa fa-pencil"></i> <span>Answers</span>
							</a></li>
						</ul>
					</nav>
				</section>
				<footer class="footer bg-gradient hidden-xs">
					<a href="LogOutServlet"  class="btn btn-sm btn-link m-r-n-xs pull-right"> <i class="fa fa-power-off"></i>
					</a> <a href="/LogOutServlet" data-toggle="class:nav-vertical" class="btn btn-sm btn-link m-l-n-sm"> <i class="fa fa-bars"></i>
					</a>
				</footer>
			</section>
		</aside>
		<!-- /.aside -->
		<!-- .vbox -->
		<section id="content">
			<section class="vbox">
				<header class="header  bg-light b-b">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#basic" data-toggle="tab">Question</a></li>
					</ul>
				</header>
				<section class="scrollable wrapper">
					<div class="tab-content">
						<div class="row">
							<div>
								<section class="panel">
									<header class="panel-heading font-bold">Question Edit Form</header>
									<div class="panel-body">
										<form role="form" action="QuestionServlet">
											<div class="form-group">
												<label>Question Title</label> <input type="text" id="title" name="title" class="form-control" placeholder="Enter title">

											</div>
											<div class="form-group">
												<label>Desription</label> <input type="text" id="description" name="description"  class="form-control" placeholder="Enter description">
											</div>
											<div class="form-group">
												<label>Options</label> <input type="text" id="options" name="options" class="form-control" placeholder="Enter options">
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label">Question Type</label> <select name="questiontype" id="questiontype" class="form-control m-b">
												</select>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label">Exire Date</label>
												<div class="col-sm-10">
													<input class="input-sm input-s datepicker-input form-control" id="expiredate" name="expiredate" size="16" type="text" value="12-02-2013" data-date-format="dd-mm-yyyy"> <input type="text"
														style="visibility: hidden;" id="id" name="id" class="form-control" />
														<input type="text" style="visibility:hidden;" name="action" value="update" class="form-control"/>
												</div>
											</div>
											<button type="submit" class="btn btn-s-md btn-white" id="submitButton" >Submit</button>
										</form>
									</div>
								</section>
							</div>
						</div>
					</div>
				</section>
			</section>
		</section>
		<!-- /.vbox -->
	</section>

	<script src="js/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.js"></script>
	<script src="js/datepicker/bootstrap-datepicker.js"></script>
	<script src="js/libs/moment.min.js"></script>
	<script>
		var service = 'http://mgl.usask.ca:8080/question/api/';

		function submitSave() {
			var id = document.getElementById("id").value;
			console.log("id:" + id);

			var formData = '{"title": "' + document.getElementById("title").value + '", "description" : "' + document.getElementById("description").value + '", "options" : "'
					+ document.getElementById("options").value + '", "expireDate" : "' + document.getElementById("expiredate").value + '", "questionType" : '
					+ document.getElementById("questiontype").value + '}';
			console.log(formData);
			//alert(formData);
			$.ajax({
				url : service + 'questions/' + id,
				type : "POST",
				contentType : "application/json",
				data : formData,
				dataType : "json",
				success : function(data, textStatus, jqXHR) {

					window.location = "http://mgl.usask.ca:8080/questionary/"
				},
				error : function(jqXHR, textStatus, errorThrown) {
					//	alert("error");
				}
			});
		};

		$(document).ready(function() {
			jQuery.support.cors = true;
			var id =
	<%=request.getParameter("id")%>
		;
			if (id == undefined) {
				window.location = "http://mgl.usask.ca:8080/questionary/";
			} else {
				var selectedType = "";
				$.ajax({
					type : "GET",
					url : service + 'questions/' + id,
					data : "{}",
					contentType : "text/plain; charset=utf-8",
					dataType : "json",
					cache : false,
					success : function(data) {
						var title = document.getElementById("title");
						title.value = data.title;
						var id = document.getElementById("id");
						id.value = data.id;

						var description = document.getElementById("description");
						description.value = data.description;

						var expiredate = document.getElementById("expiredate");
						expiredate.value = data.expireDate;

						var options = document.getElementById("options");
						options.value = data.options;
						selectedType = data.type;
						console.log("title:" + data.title + " selectedType:" + selectedType);
						ajaxCallTypes(selectedType);
					},
					error : function(msg) {
						//alert(msg.responseText);
					}
				});
			}
		});

		function ajaxCallTypes(selectedType) {
			$.ajax({
				type : "GET",
				url : 'http://mgl.usask.ca:8080/question/api/questions/questiontypes',
				data : "{}",
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success : function(data) {
					//alert('success');
					$.each(data.list, function(i, theItem) {
						var combo = document.getElementById("questiontype");
						var option = document.createElement("option");
						console.log("selected value:" + selectedType + " " + theItem.type);
						if (selectedType == theItem.type) {
							option.selected = "selected";
						}
						option.text = theItem.type;
						option.value = theItem.id;
						try {
							combo.add(option, null); // Other browsers
						} catch (error) {
							//	alert('error found');
							combo.add(option); // really old browser
						}

					});
				},
				error : function(msg, url, line) {
					//	alert('error trapped in error: function(msg, url, line)');
					//	alert('msg = ' + msg + ', url = ' + url + ', line = ' + line);

				}
			});
		}
	</script>
</body>
</html>