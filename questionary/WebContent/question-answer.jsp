<!DOCTYPE html>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="servlets.QuestionTO"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="java.util.ArrayList"%>
<%@page import="servlets.Question"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
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
<!--[if lt IE 9]>
    <script src="js/ie/respond.min.js" cache="false"></script>
    <script src="js/ie/html5.js" cache="false"></script>
    <script src="js/ie/fix.js" cache="false"></script>
  <![endif]-->
</head>

<style>
.rating {
	overflow: hidden;
	display: inline-block;
	font-size: 0;
	position: relative;
}

.rating-input {
	float: right;
	width: 16px;
	height: 16px;
	padding: 0;
	margin: 0 0 0 -16px;
	opacity: 0;
}

.rating:hover .rating-star:hover, .rating:hover .rating-star:hover ~
	.rating-star, .rating-input:checked ~ .rating-star {
	background-position: 0 0;
}

.rating-star, .rating:hover .rating-star {
	position: relative;
	float: right;
	display: block;
	width: 16px;
	height: 16px;
	background: url('http://kubyshkin.ru/samples/star-rating/star.png') 0
		-16px;
}

/* Just for the demo */
</style>

<%
	if (request.getSession() == null || request.getSession().getAttribute("email") == null) {
		request.getRequestDispatcher("signin.jsp").forward(request, response);
	}
	Map<String, String> typeMap = new HashMap<String, String>();
	Map<Integer, QuestionTO> questionMap = new HashMap<Integer, QuestionTO>();
	try {
		if (session.getAttribute("questions") == null) {
			QuestionTO[] questions = null;
			String url = "http://mgl.usask.ca:8080/question/api/questions";

			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			// optional default is GET
			con.setRequestMethod("GET");

			// add request header
			String USER_AGENT = "Mozilla/5.0";
			con.setRequestProperty("User-Agent", USER_AGENT);

			int responseCode = con.getResponseCode();
			System.out.println("\nSending 'GET' request to URL : " + url);
			System.out.println("Response Code : " + responseCode);

			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer responseBuffer = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				responseBuffer.append(inputLine);
			}
			in.close();
			System.out.println(response.toString());

			Gson gson = new Gson();
			questions = gson.fromJson(responseBuffer.toString(), QuestionTO[].class);
			System.out.println("question size:" + questions.length);
			session.setAttribute("questions", questions);
		}

	} catch (Exception ex) {
		ex.printStackTrace();
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
							<li><a href="questiontypes.jsp"> <i class="fa fa-question-circle"></i> <span>Question Types</span>
							</a></li>
							<li class="dropdown-submenu active"><a href="question-answer.jsp"> <i class="fa fa-pencil"></i> <span>Answer question</span>
							</a></li>
								<li><a href="answerlist.jsp"> <i class="fa fa-pencil"></i> <span>Answer list</span>
							</a></li>
							
						</ul>
					</nav>
				</section>
				<footer class="footer bg-gradient hidden-xs">
					<a href="LogOutServlet" class="btn btn-sm btn-link m-r-n-xs pull-right"> <i class="fa fa-power-off"></i>
					</a> <a href="#nav" data-toggle="class:nav-vertical" class="btn btn-sm btn-link m-l-n-sm"> <i class="fa fa-bars"></i>
					</a>
				</footer>
			</section>
		</aside>
		<!-- /.aside -->
		<!-- .vbox -->
		<section id="content">
			<section class="vbox">
				<header class="header bg-dark bg-gradient">
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
										<form role="form" action="QuestionaryAnswerServlet" enctype="multipart/form-data" method="post">
											<label class="col-sm-2 control-label">Questions</label>
											<div class="col-sm-10">
												<div class="btn-group m-r">
													<select name="selectedQuestion" id="selectedQuestion" class="form-control m-b" onchange="questionOnChange()">
														<%
															Integer qId = 0;
															if (request.getParameter("selected") != null) {
																qId = new Integer(request.getParameter("selected").toString());
															}
															typeMap.clear();
															QuestionTO[] questions = (QuestionTO[]) session.getAttribute("questions");
															boolean mapEmpty = true;
															if (!typeMap.isEmpty()) {
																mapEmpty = false;
																session.setAttribute("typeMap", typeMap);
															}
															for (int i = 0; i < questions.length; i++) {
																if (mapEmpty == true) {
																	typeMap.put(questions[i].getId().toString(), questions[i].getType());
																	questionMap.put(questions[i].getId(), questions[i]);
																}
																if (qId.intValue() == questions[i].getId().intValue()) {
														%>
														<option value="<%=questions[i].getId()%>" selected="selected"><%=questions[i].getTitle()%></option>
														<%
															} else {
														%>
														<option value="<%=questions[i].getId()%>"><%=questions[i].getTitle()%></option>
														<%
															}
															}
															session.setAttribute("questionMap", questionMap);
															System.out.println("questionMap:" + typeMap);
														%>
													</select>
												</div>
												<%
													QuestionTO tempQuestionTO = null;
													if (request.getParameter("selected") == null) {
														tempQuestionTO = questions[0];
													} else {
														tempQuestionTO = questionMap.get(new Integer(request.getParameter("selected")));
													}
													if (tempQuestionTO.getType().equals("Video") || tempQuestionTO.getType().equals("Image")) {
												%>
												<input accept="audio/*,video/*,image/*" type="file" name="file" />
												<%
													} else if (tempQuestionTO.getType().equals("Rate")) {
														List<String> rateCycle = questionMap.get(tempQuestionTO.getId()).getOptions();
														Integer start = new Integer(rateCycle.get(0));
														Integer step = new Integer(rateCycle.get(1));
														Integer finish = new Integer(rateCycle.get(2));
												%>
												<br /> <select name="rating" id="rating" class="form-control m-b">
													<%
														for (int j = start; j <= finish; j = j + step) {
													%><option value="<%=j%>"><%=j%></option>
													<%
														}
													%>
												</select>
												<%
													} else {
												%>
												<select name="answerChoice" id="answerChoice" class="form-control m-b">
													<%
														for (String answer : tempQuestionTO.getOptions()) {
													%>
													<option value="<%=answer%>"><%=answer%></option>
													<%
														}
													%>
												</select>
												<%
													}
												%>


											</div>
											<div class="form-group">
												<div class="col-lg-offset-2 col-lg-10">
													<button type="submit" class="btn btn-primary">Submit</button>
												</div>
											</div>
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

		function questionOnChange() {
			var x = document.getElementById("selectedQuestion").value;

			window.location.assign("http://mgl.usask.ca:8080/questionary/question-answer.jsp?selected=" + x)

		}

		function submitSave() {
			var formData = '{"title": "' + document.getElementById("title").value + '", "description" : "' + document.getElementById("description").value + '", "options" : "'
					+ document.getElementById("options").value + '", "expireDate" : "' + document.getElementById("expiredate").value + '", "questionType" : '
					+ document.getElementById("questiontype").value + '}';
			console.log(formData);
			//alert(formData);
			$.ajax({
				url : service + 'questions',
				type : "POST",
				contentType : "application/json",
				data : formData,
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					//data - response from server
					//alert("success");

				},
				error : function(jqXHR, textStatus, errorThrown) {
					//	alert("error");
				}
			});

		};

		$(document).ready(function() {
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
		});
	</script>
</body>
</html>