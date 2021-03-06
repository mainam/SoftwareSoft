﻿<%@ Page Language="C#" EnableViewStateMac="false" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SoftwareStore.Login" %>

<!DOCTYPE html>

<html lang="en-us">
<head>
    <meta charset="utf-8">
    <title>SELPORTAL</title>
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" media="screen" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/smartadmin-production.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/smartadmin-skins.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/demo.css">
    <link rel="shortcut icon" href="img/favicon/favicon.ico" type="image/x-icon">
    <link rel="icon" href="img/favicon/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">
    <script src="js/plugin/pace/pace.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <script> if (!window.jQuery) { document.write('<script src="js/libs/jquery-2.0.2.min.js"><\/script>'); } </script>
    <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
    <script> if (!window.jQuery.ui) { document.write('<script src="js/libs/jquery-ui-1.10.3.min.js"><\/script>'); } </script>
    <script src="js/bootstrap/bootstrap.min.js"></script>
    <script src="js/notification/SmartNotification.min.js"></script>
    <script src="js/smartwidgets/jarvis.widget.min.js"></script>
    <script src="js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>
    <script src="js/plugin/sparkline/jquery.sparkline.min.js"></script>
    <script src="js/plugin/jquery-validate/jquery.validate.min.js"></script>
    <script src="js/plugin/masked-input/jquery.maskedinput.min.js"></script>
    <script src="js/plugin/select2/select2.min.js"></script>
    <script src="js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>
    <script src="js/plugin/msie-fix/jquery.mb.browser.min.js"></script>
    <script src="js/plugin/fastclick/fastclick.js"></script>
    <script src="js/selportalscript.js"></script>


</head>
<body id="login" class="animated fadeInDown" onload="AutoLogin();">
    <header id="header">
        <div id="logo-group">
            <span>
                <a href="Login.aspx">
                    <img src="images/logo3.png" alt="Sel Portal" height="70" />
                </a></span>
        </div>
        <%--        <span id="login-header-space"><span class="hidden-mobile">Need an account?</span> <a href="RegisterAccount.aspx" class="btn btn-danger">Creat account</a> </span>--%>
    </header>

    <div id="main" role="main">
        <div id="content" class="container">
            <div class="row" style="margin-top: 100px;">

                <div class="col-xs-12 col-sm-12 col-md-5 col-lg-4" style="float: right">
                    <div class="well no-padding">
                        <form id="login_form" class="smart-form client-form">
                            <input id="txtType" type="hidden" runat="server" />
                            <input type="hidden" id="datalogin" />
                            <header>
                                Sign In						
                            </header>

                            <fieldset>

                                <section>
                                    <label class="label">SingleID</label>
                                    <label class="input">
                                        <i class="icon-append fa fa-user"></i>
                                        <input id="txtUsername" name="txtUsername" type="text" />
                                        <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i>Please enter email address/username</b></label>
                                </section>

                                <section>
                                    <label class="label">Password</label>
                                    <label class="input">
                                        <i class="icon-append fa fa-lock"></i>
                                        <input id="txtPassword" name="txtPassword" type="password" />
                                        <b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i>Enter your password</b>
                                    </label>
                                    <div class="note">
                                        <a href="forgotpassword.aspx">Forgot password?</a>
                                    </div>
                                </section>

                                <section id="mesError">
                                </section>
                            </fieldset>
                            <footer>
                                <button id="btnLoginAccount" class="btn btn-primary" type="button">Login</button>
                                <button id="btnLoginSSO" class="btn btn-primary ignore" type="button" onclick="LoginSSO()">Login SSO</button>
                            </footer>
                        </form>

                    </div>

                </div>

                <div style="height: 600px; padding-left: 15px; float: left; width: 700px;">
                    <div id="myCarousel-2" class="carousel slide">
                        <ol class="carousel-indicators">
                            <li data-target="#myCarousel-2" data-slide-to="0" class="active"></li>
                            <li data-target="#myCarousel-2" data-slide-to="1" class=""></li>
                            <li data-target="#myCarousel-2" data-slide-to="2" class=""></li>
                            <li data-target="#myCarousel-2" data-slide-to="3" class=""></li>
                            <li data-target="#myCarousel-2" data-slide-to="4" class=""></li>
                            <li data-target="#myCarousel-2" data-slide-to="5" class=""></li>
                            <li data-target="#myCarousel-2" data-slide-to="6" class=""></li>
                            <li data-target="#myCarousel-2" data-slide-to="7" class=""></li>
                            <li data-target="#myCarousel-2" data-slide-to="8" class=""></li>
                            <li data-target="#myCarousel-2" data-slide-to="9" class=""></li>
                            <li data-target="#myCarousel-2" data-slide-to="10" class=""></li>
                        </ol>
                        <div class="carousel-inner">
                            <!-- Slide 1 -->
                            <div class="item active">
                                <img src="/images/slide/DSC_0199.JPG" alt="">
                            </div>
                            <!-- Slide 2 -->
                            <div class="item">
                            </div>
                            <!-- Slide 3 -->
                            <div class="item">
                            </div>
                            <div class="item">
                            </div>
                            <div class="item">
                            </div>
                            <div class="item">
                            </div>
                            <div class="item">
                            </div>
                            <div class="item">
                            </div>
                            <div class="item">
                            </div>
                            <div class="item">
                            </div>
                            <div class="item">
                            </div>
                        </div>
                        <a class="left carousel-control" href="#myCarousel-2" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
                        <a class="right carousel-control" href="#myCarousel-2" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
                    </div>
                </div>

            </div>
        </div>

    </div>

    <object style="visibility: hidden; height: 1px;" id="EpAdm2 Control" name="EpAdmC" classid="CLSID:C63E3330-049F-4C31-B47E-425C84A5A725"></object>


    <!--[if IE 7]>
			
			<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
			
		<![endif]-->

    <!-- MAIN APP JS FILE -->
    <script src="js/app.js"></script>
    <script src="js/selportalscript.js"></script>
    <script type="text/javascript">
        Cookie.Reset();

        runAllForms();
        var LoginForm = function () {
            if (!($('#login_form').valid()))
                return;

            AJAXFunction.CallAjax("POST", "/Login.aspx", "LoginAccount", { username: $('#txtUsername').val(), pass: $('#txtPassword').val() }, function (response) {
                if (response.Status) {
                    var url = GetQueryStringHref("Url");
                    if (url != null)
                        window.location.href = url;
                    else
                        window.location.href = "/Default.aspx";
                } else {
                    $('#mesError').empty().append(CreateErrorMessage("Username or Password is not correct"));
                }

            });
        }
        $(function () {


            $('#txtUsername').keypress(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') {
                    LoginForm();
                }
            });
            $('#txtPassword').keypress(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') {
                    LoginForm();
                }
            });



            $("#login_form").validate({
                // Rules for form validation
                rules: {
                    txtUsername: {
                        required: true,
                        minlength: 5,
                        maxlength: 20
                    },
                    txtPassword: {
                        required: true
                    }
                },

                // Messages for form validation
                messages: {
                    txtUsername: {
                        required: 'Please enter your User Name'
                    },
                    txtPassword: {
                        required: 'Please enter your password'
                    }
                },

                // Do not change code below
                errorPlacement: function (error, element) {
                    error.insertAfter(element.parent());
                },
                setting:
                    {
                        ignore: '.ignore'
                    }
            });
        });

        $("#btnLoginAccount").click(LoginForm);


        function GetSSO() {
            var rrtn = EpAdmC.GetSecureBox();
            if (rrtn != null && rrtn != "") {
                $('#datalogin').val(rrtn);
            }
            else {
                $('#datalogin').val("");
            }
        }
        function LoginSSO() {
            var ua = window.navigator.userAgent
            var msie = ua.indexOf("MSIE ")
            if (msie <= 0)      // If Internet Explorer, return version number
            {
                alertbox('Please using IE to Login SSO');
                return;
            }
            if ($('#datalogin').val() == "") {
                alertbox("Please login mysingle first");
                return;
            }
            AJAXFunction.CallAjax("POST", "/Login.aspx", "LoginSSO", { data: $('#datalogin').val() }, function (response) {
                if (response.Status) {
                    var url = GetQueryStringHref("Url");
                    if (url != null)
                        location.replace(url);
                    else
                        location.replace('/Default.aspx');
                }
                else {
                    $('#mesError').empty().append(CreateErrorMessage("Login SSO Failed"));
                }

            });
        }

        function AutoLogin() {
            if ($('#datalogin').val() != "") {
                var action = GetQueryStringHref("Action");
                if (action == null) {
                    AJAXFunction.CallAjax("POST", "/Login.aspx", "LoginSSO", { data: $('#datalogin').val() }, function (response) {
                        if (response.Status) {
                            var url = GetQueryStringHref("Url");
                            if (url != null)
                                location.replace(url);
                            else
                                location.replace('/Default.aspx');
                        }
                        else {
                            $('#mesError').empty().append(CreateErrorMessage("Auto login sso failed!!"));
                        }

                    });
                }
            }
        }

        function CreateErrorMessage(mess) {
            var div = $('<div style="margin-top: 20px; color: red; margin-left: 10px">');
            var button = $('<button class="close" data-dismiss="alert">').text('x');
            var i = $('<i class="fa-fw fa fa-times">');
            var strong = $('<strong>').text('Error!');
            var span = $('<span>').text(mess);
            div.append(button);
            div.append(i);
            div.append(strong);
            div.append(span);
            return div;
        }



        $(document).ready(function () {
            GetSSO();
        });
    </script>
</body>
</html>
