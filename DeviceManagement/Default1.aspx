<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default1.aspx.cs" Inherits="DeviceManagement.Default1" %>

<!DOCTYPE html>
<html lang="en-us">
<head>
    <meta charset="utf-8">
    <title>Device Management</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" media="screen" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/smartadmin-production.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/smartadmin-skins.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/demo.min.css">
    <link href="css/selportalcss.css" rel="stylesheet" />
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <style>
        .breadcrumb .popover {
            min-width: 350px !important;
        }

        .breadcrumb .popover-title {
            color: black !important;
            text-align: center !important;
            font-weight: bold !important;
            text-transform: uppercase;
        }

        .breadcrumb .popover-content ul {
            padding-left: 0px;
        }

            .breadcrumb .popover-content ul li {
                list-style: none;
                line-height: 40px;
                border-bottom: 1px dotted gray;
            }

        #ribbon .breadcrumb .popover-content ul li a {
            color: black !important;
            font-weight: bold !important;
            color: #221c1c !important;
        }

        .breadcrumb .popover-content ul li a {
            color: black !important;
            font-weight: bold !important;
            color: #221c1c !important;
        }
    </style>
</head>

<body class="">


    <!-- #HEADER -->
    <header id="header">

        <div class="pull-right">

            <!-- collapse menu button -->
            <div id="hide-menu" class="btn-header pull-right">
                <span><a href="javascript:void(0);" data-action="toggleMenu" title="Collapse Menu"><i class="fa fa-reorder"></i></a></span>
            </div>
            <!-- end collapse menu -->
            <!-- #MOBILE -->
            <!-- Top menu profile link : this shows only when top menu is active -->
            <ul id="mobile-profile-img" class="header-dropdown-list hidden-xs padding-5">
                <li class="">
                    <a href="#" class="dropdown-toggle no-margin userdropdown" data-toggle="dropdown">
                        <img src="img/avatars/sunny.png" alt="John Doe" class="online" />
                    </a>
                    <ul class="dropdown-menu pull-right">
                        <li>
                            <a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0"><i class="fa fa-cog"></i>Setting</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#ajax/profile.html" class="padding-10 padding-top-0 padding-bottom-0"><i class="fa fa-user"></i><u>P</u>rofile</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" data-action="toggleShortcut"><i class="fa fa-arrow-down"></i><u>S</u>hortcut</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="javascript:void(0);" class="padding-10 padding-top-0 padding-bottom-0" data-action="launchFullscreen"><i class="fa fa-arrows-alt"></i>Full <u>S</u>creen</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="Login.aspx" class="padding-10 padding-top-5 padding-bottom-5" data-action="userLogout"><i class="fa fa-sign-out fa-lg"></i><strong><u>L</u>ogout</strong></a>
                        </li>
                    </ul>
                </li>
            </ul>

            <!-- logout button -->
            <div id="logout" class="btn-header transparent pull-right">
                <span><a href="Login.aspx?Action=Logout" title="Sign Out" data-action="userLogout" data-logout-msg="You can improve your security further after logging out by closing this opened browser"><i class="fa fa-sign-out"></i></a></span>
            </div>
            <!-- end logout button -->
            <!-- search mobile button (this is hidden till mobile view port) -->
            <div id="search-mobile" class="btn-header transparent pull-right">
                <span><a href="javascript:void(0)" title="Search"><i class="fa fa-search"></i></a></span>
            </div>
            <!-- fullscreen button -->
            <div id="fullscreen" class="btn-header transparent pull-right">
                <span><a href="javascript:void(0);" data-action="launchFullscreen" title="Full Screen"><i class="fa fa-arrows-alt"></i></a></span>
            </div>
            <style>
                #activity {
                    -moz-border-radius: 2px;
                    -webkit-border-radius: 2px;
                    border-radius: 2px;
                    cursor: default !important;
                    display: inline-block;
                    font-weight: 700;
                    height: 30px;
                    width: 30px;
                    padding: 2px;
                    text-align: center;
                    text-decoration: none !important;
                    -moz-user-select: none;
                    -webkit-user-select: none;
                    background-color: #f8f8f8;
                    background-image: -webkit-gradient(linear,left top,left bottom,from(#f8f8f8),to(#f1f1f1));
                    background-image: -webkit-linear-gradient(top,#f8f8f8,#f1f1f1);
                    background-image: -moz-linear-gradient(top,#f8f8f8,#f1f1f1);
                    background-image: -ms-linear-gradient(top,#f8f8f8,#f1f1f1);
                    background-image: -o-linear-gradient(top,#f8f8f8,#f1f1f1);
                    background-image: linear-gradient(top,#f8f8f8,#f1f1f1);
                    border: 1px solid #bfbfbf;
                    color: #c4bab6;
                    font-size: 19px;
                    margin: 10px 0 0;
                    position: relative;
                }

                    #activity b.badge {
                        position: absolute;
                        top: -5px;
                        right: -5px;
                        cursor: pointer;
                        background: #0091d9;
                        display: inline-block;
                        font-size: 10px;
                        box-shadow: inset 1px 1px 0 rgba(0,0,0,.1),inset 0 -1px 0 rgba(0,0,0,.07);
                        color: #fff;
                        font-weight: 700;
                        border-radius: 50%;
                        -moz-border-radius: 50%;
                        -webkit-border-radius: 50%;
                        padding: 2px 4px 3px;
                        text-align: center;
                        line-height: normal;
                    }

                .ajax-dropdown {
                    top: 48px !important;
                    right: 16px !important;
                    left: auto !important;
                    width: 344px;
                    height: 435px;
                    padding: 10px;
                    background: #fff;
                    border: 1px solid #b3b3b3;
                }

                    *.ajax-dropdown::before, .ajax-dropdown::after {
                        content: none !important;
                        /*bottom: 0 !important;*/
                        /*border: none !important;*/
                    }
            </style>
            <span id="activity" class="activity-dropdown active pull-right"><i class="fa fa-user"></i><b class="badge ">0</b> </span>
            <div class="ajax-dropdown" style="padding: 0px;">
                <!-- notification content -->
                <div class="ajax-notifications custom-scroll" style="padding: 0px; height: 433px;">
                    <ul class="notification-body">
                    </ul>
                </div>
            </div>
        </div>

        <span style="width: 600px; margin-top: 0px; margin-left: 30px;">
            <a href="#">
                <img src="images/logo3.png" style="height: 75px;" alt="SmartAdmin">
            </a>
        </span>
        <!-- PLACE YOUR LOGO HERE -->
        <!-- END LOGO PLACEHOLDER -->
        <!-- Note: The activity badge color changes when clicked and resets the number to 0
             Suggestion: You may want to set a flag when this happens to tick off all checked messages / notifications -->
        <!--<span id="activity" class="activity-dropdown"> <i class="fa fa-user"></i> <b class="badge"> 21 </b> </span>

        <div class="ajax-dropdown">
            <div class="btn-group btn-group-justified" data-toggle="buttons">
                <label class="btn btn-default">
                    <input type="radio" name="activity" id="ajax/notify/mail.html">
                    Msgs (14)
                </label>
                <label class="btn btn-default">
                    <input type="radio" name="activity" id="ajax/notify/notifications.html">
                    notify (3)
                </label>
                <label class="btn btn-default">
                    <input type="radio" name="activity" id="ajax/notify/tasks.html">
                    Tasks (4)
                </label>
            </div>

            <div class="ajax-notifications custom-scroll">

                <div class="alert alert-transparent">
                    <h4>Click a button to show messages here</h4>
                    This blank page message helps protect your privacy, or you can show the first message here automatically.
                </div>

                <i class="fa fa-lock fa-4x fa-border"></i>

            </div>
            <span>
                Last updated on: 12/12/2013 9:43AM
                <button type="button" data-loading-text="
                    <i class='fa fa-refresh fa-spin'></i> Loading..." class="btn btn-xs btn-default pull-right">
                    <i class="fa fa-refresh"></i>
                </button>
            </span>

        </div>-->
        <!-- END AJAX-DROPDOWN -->
        <!-- #PROJECTS: projects dropdown -->
        <!--<div class="project-context hidden-xs">

            <ul class="dropdown-menu">
                <li>
                    <a href="javascript:void(0);">Online e-merchant management system - attaching integration with the iOS</a>
                </li>
                <li>
                    <a href="javascript:void(0);">Notes on pipeline upgradee</a>
                </li>
                <li>
                    <a href="javascript:void(0);">Assesment Report for merchant account</a>
                </li>
                <li class="divider"></li>
                <li>
                    <a href="javascript:void(0);"><i class="fa fa-power-off"></i> Clear</a>
                </li>
            </ul>

        </div>-->
        <!-- end pulled right: nav area -->

    </header>
    <aside id="left-panel">
        <div class="login-info">
            <span>
                <a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
                    <asp:Image runat="server" ID="imgAvatar" AlternateText="me" CssClass="online" Height="30"></asp:Image>
                    <span>
                        <asp:Label runat="server" ID="lbUserName">                            
                        </asp:Label>
                    </span>
                    <i class="fa fa-angle-down"></i>
                </a>

            </span>
        </div>
        <nav>
            <ul>
                <li>
                    <a href="#device/MyDevice/ListDeviceKeeping.aspx" style="display: none"></a>
                </li>
                                
                
                
                <li>
                    <a href="#"><i class="fa fa-lg fa-fw fa-hdd-o"></i><span class="menu-item-parent">DEVICES</span></a>
                    <ul>
                        <li runat="server" id="liDeviceManagement"><a href="#">Device Management</a>
                            <ul>
                                <li>
                                    <a href="device/DeviceManagement.aspx">Device Management</a>
                                </li>
                                <li>
                                    <a href="device/management/ListDeviceAvailable.aspx">Set Borrow Devices</a>
                                </li>
                                <li>
                                    <a href="device/CommonManagement.aspx">Common</a>
                                </li>
                                <li>
                                    <a href="device/ReturnDevice.aspx">Return Devices</a>
                                </li>
                            </ul>
                        </li>
                        <li runat="server" id="menuInventory"><a href="#">Inventory Device</a>
                            <ul>
                                <li runat="server" id="liInventoryResolve">
                                    <a href="device/InventoryRequest.aspx">Request</a>
                                </li>
                                <li style="display: none">
                                    <a href="device/InventoryResolve.aspx">Inventory Resolve</a>
                                </li>
                                <li>
                                    <a href="device/ConfirmDevice.aspx">Confirmation</a>
                                </li>
                            </ul>
                        </li>
                        <li runat="server" id="menuListDevice">
                            <a href="device/ListAllDeviceAllowBorrow.aspx">List of Devices</a>
                        </li>
                        <li runat="server" id="menuListDevice2">
                            <a href="device/ListAllDevice.aspx">List of Devices</a>
                        </li>
                        <li>
                            <a href="device/DeviceInTeam.aspx">Device In Team</a>
                        </li>
                        <li>
                            <a href="#">My devices</a>
                            <ul>
                                <li>
                                    <a href="device/MyDevice/ListDeviceBorrowing.aspx">List Borrowing</a>
                                </li>
                                <li>
                                    <a href="device/MyDevice/ListDeviceKeeping.aspx">List Keeping</a>
                                </li>
                                <li>
                                    <a href="#">Transfer Device</a>
                                    <ul>
                                        <%--                                        <li>
                                            <a href="device/MyDevice/ConfirmKeepingDevice.aspx">Request Transfer</a>
                                        </li>
                                        <li>
                                            <a href="device/MyDevice/ConfirmKeepingDevice.aspx">Approve Transfer</a>
                                        </li>--%>
                                        <li>
                                            <a href="device/MyDevice/ConfirmKeepingDevice.aspx">Confirm Keeping</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li>
                        <li runat="server" id="menuBorrowDevice"><a href="#">Borrow Device</a>
                            <ul>
                                <li>
                                    <a href="device/BorrowDevice/BorrowByModel.aspx">Borrow by Model</a>
                                </li>
                                <li>
                                    <a href="device/BorrowDevice/Borrow.aspx">Borrow by Device</a>
                                </li>
                                <li>
                                    <a href="device/BorrowDevice/BorrowDeviceHaveReturn.aspx">Device has returned</a>
                                </li>
                            </ul>
                        </li>
                        <li><a href="#">Approval</a>
                            <ul>
                                <li>
                                    <a href="device/MyApprove/ApproveGroupByDevice.aspx">Approval Device</a>
                                </li>
                                <li>
                                    <a href="device/MyApprove/ApproveGroupByModel.aspx">Approval Model</a>
                                </li>
                                <li>
                                    <a href="device/Request.aspx">Request</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#"><i class="fa fa-lg fa-fw fa-clock-o"></i><span class="menu-item-parent">MY ACTIVITY</span></a>
                    <ul>
                        <li>
                            <a href="/myactivity/logactivity.aspx">Log</a>
                        </li>
                    </ul>
                </li>
                <li runat="server" id="liAdminWebsite">
                    <a href="#"><i class="fa fa-lg fa-fw fa-slack"></i><span class="menu-item-parent">ADMIN WEBSITE</span></a>
                    <ul>
                        <li><a href="#">Device</a>
                            <ul>
                                <li>
                                    <a href="admin/device/configdevicemanager.aspx">Device Manager</a>
                                </li>
                                <li>
                                    <a href="admin/device/configallowborrowdevice.aspx">Allow Borrow Device</a>
                                </li>
                                <li>
                                    <a href="admin/device/ConfigTransferDeviceAllMember.aspx">Transfer All Merber</a>
                                </li>
                                <li>
                                    <a href="admin/device/ListDeviceTransferPending.aspx">Transfer pending</a>
                                </li>
                                <li>
                                    <a href="admin/device/ListDeviceBorrowPending.aspx">Borrow pending</a>
                                </li>
                            </ul>
                        </li>
                        <li><a href="#">HR Management</a>
                            <ul>
                                <li>
                                    <a href="hr/teammanagement.aspx">Team</a>
                                </li>
                                <li>
                                    <a href="hr/HRManagement.aspx">Member</a>
                                </li>
<%--                                <li>
                                    <a href="hr/SetupLayout.aspx">Layout</a>
                                </li>--%>
                                <li>
                                    <a href="hr/OTSurvey.aspx">OT Survey</a>
                                </li>
                            </ul>
                        </li>
                        <li><a href="#">Utils</a>
                            <ul>
                                <li>
                                    <a href="admin/mail/sendmail.aspx">Send Mail</a>
                                </li>
                                <li>
                                    <a href="admin/utils/barcodegenerator.aspx">BarCode Generator</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">Log</a>
                            <ul>
                                <li>
                                    <a href="/admin/log/loginsystem.aspx">Log Access System</a>
                                </li>
                                <li>
                                    <a href="/admin/log/Logtransferdevice.aspx">Log Transfer Device</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">Config</a>
                            <ul>
                                <li>
                                    <a href="/Admin/Config/SetupDataConfig.aspx">Setup Data Config</a>
                                </li>

                                <%--                                <li>
                                    <a href="/Admin/Config/SendMailNotification.aspx">Send Mail Notification</a>
                                </li>--%>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>
        <span class="minifyme" data-action="minifyMenu"><i class="fa fa-arrow-circle-left hit"></i></span>

    </aside>
    <!-- END NAVIGATION -->
    <!-- #MAIN PANEL -->
    <div id="main" role="main">

        <!-- RIBBON -->
        <div id="ribbon">

            <span class="ribbon-button-alignment">
                <span id="refresh" class="btn btn-ribbon" data-action="resetWidgets" data-title="refresh" rel="tooltip" data-placement="bottom" data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings." data-html="true" data-reset-msg="Would you like to RESET all your saved widgets and clear LocalStorage?"><i class="fa fa-refresh"></i></span>
            </span>

            <!-- breadcrumb -->
            <ol class="breadcrumb">
                <!-- This is auto generated -->
            </ol>
            <!-- end breadcrumb -->
            <!-- You can also add more buttons to the
            ribbon for further usability

            Example below:

            <span class="ribbon-button-alignment pull-right" style="margin-right:25px">
                <span id="search" class="btn btn-ribbon hidden-xs" data-title="search"><i class="fa fa-grid"></i> Change Grid</span>
                <span id="add" class="btn btn-ribbon hidden-xs" data-title="add"><i class="fa fa-plus"></i> Add</span>
                <span id="search" class="btn btn-ribbon" data-title="search"><i class="fa fa-search"></i> <span class="hidden-mobile">Search</span></span>
            </span> -->

        </div>
        <!-- END RIBBON -->
        <!-- #MAIN CONTENT -->
        <div id="content">
        </div>

        <!-- END #MAIN CONTENT -->

    </div>
    <!-- END #MAIN PANEL -->
    <!-- #PAGE FOOTER -->
    <div class="page-footer">
        <div class="row">
            <div class="modalloading"></div>
            <div class="col-xs-12 col-sm-6">
                <span class="txt-color-white">Sel Portal - Devtool Team © 2014</span>
            </div>

            <div class="col-xs-6 col-sm-6 text-right hidden-xs">
                <div class="txt-color-white inline-block">
                    <%--                    <i class="txt-color-blueLight hidden-mobile">Last account activity <i class="fa fa-clock-o"></i><strong>52 mins ago &nbsp;</strong> </i>--%>
                    <%--                    <div class="btn-group dropup">
                        <button class="btn btn-xs dropdown-toggle bg-color-blue txt-color-white" data-toggle="dropdown">
                            <i class="fa fa-link"></i><span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu pull-right text-left">
                            <li>
                                <div class="padding-5">
                                    <p class="txt-color-darken font-sm no-margin">Download Progress</p>
                                    <div class="progress progress-micro no-margin">
                                        <div class="progress-bar progress-bar-success" style="width: 50%;"></div>
                                    </div>
                                </div>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="padding-5">
                                    <p class="txt-color-darken font-sm no-margin">Server Load</p>
                                    <div class="progress progress-micro no-margin">
                                        <div class="progress-bar progress-bar-success" style="width: 20%;"></div>
                                    </div>
                                </div>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="padding-5">
                                    <p class="txt-color-darken font-sm no-margin">Memory Load <span class="text-danger">*critical*</span></p>
                                    <div class="progress progress-micro no-margin">
                                        <div class="progress-bar progress-bar-danger" style="width: 70%;"></div>
                                    </div>
                                </div>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="padding-5">
                                    <button class="btn btn-block btn-default">refresh</button>
                                </div>
                            </li>
                        </ul>
                    </div>--%>
                    <!-- end btn-group-->
                </div>
                <!-- end div-->
            </div>
            <!-- end col -->
        </div>
        <!-- end row -->
    </div>
    <!-- END FOOTER -->
    <!-- #SHORTCUT AREA : With large tiles (activated via clicking user name tag)
         Note: These tiles are completely responsive, you can add as many as you like -->
    <div id="shortcut">
        <ul>
            <li>
                <a href="javascript:void(0)" data-toggle="modal" data-target="#remoteModal2" class="jarvismetro-tile big-cubes bg-color-blue" id="btnChangePassword"><span class="iconbox"><i class="fa  fa-key fa-4x"></i><span>Change password</span></span></a>
            </li>
            <li>
                <a href="#/hr/userprofile.aspx" class="jarvismetro-tile big-cubes bg-color-blue"><span class="iconbox"><i class="fa  fa-user fa-4x"></i><span>My Profile</span></span></a>
            </li>
            <%--            <li>
                <a href="#ajax/inbox.html" class="jarvismetro-tile big-cubes bg-color-blue"><span class="iconbox"><i class="fa fa-envelope fa-4x"></i><span>Mail <span class="label pull-right bg-color-darken">14</span></span> </span></a>
            </li>--%>
            <%--            <li>
                <a href="#ajax/calendar.html" class="jarvismetro-tile big-cubes bg-color-orangeDark"><span class="iconbox"><i class="fa fa-calendar fa-4x"></i><span>Calendar</span> </span></a>
            </li>
            <li>
                <a href="#ajax/gmap-xml.html" class="jarvismetro-tile big-cubes bg-color-purple"><span class="iconbox"><i class="fa fa-map-marker fa-4x"></i><span>Maps</span> </span></a>
            </li>
            <li>
                <a href="#ajax/invoice.html" class="jarvismetro-tile big-cubes bg-color-blueDark"><span class="iconbox"><i class="fa fa-book fa-4x"></i><span>Invoice <span class="label pull-right bg-color-darken">99</span></span> </span></a>
            </li>
            <li>
                <a href="#ajax/gallery.html" class="jarvismetro-tile big-cubes bg-color-greenLight"><span class="iconbox"><i class="fa fa-picture-o fa-4x"></i><span>Gallery </span></span></a>
            </li>
            <li>
                <a href="#ajax/profile.html" class="jarvismetro-tile big-cubes selected bg-color-pinkDark"><span class="iconbox"><i class="fa fa-user fa-4x"></i><span>My Profile </span></span></a>
            </li>--%>
        </ul>
    </div>


    <%--    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <script>
        if (!window.jQuery) {
            document.write('<script src="js/libs/jquery-2.0.2.min.js"><\/script>');
            //document.write('<script src="js/libs/jquery-ui-1.10.3.min.js"><\/script>');
        }
    </script>

    <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
    <script>
        if (!window.jQuery.ui) {
            document.write('<script src="js/libs/jquery-ui-1.10.3.min.js"><\/script>');
        }
    </script>--%>
    <script src="js/libs/jquery-2.0.2.min.js"></script>
    <script src="js/libs/jquery-ui-1.10.3.min.js"></script>

    <script src="js/plugin/ckeditor/ckeditor.js"></script>

    <script>
        $("#btnChangePassword").click(function () {
            var target = "/account/dialogchangepassword.aspx"
            $('#remoteModal2').removeData();
            $('#remoteModal2').modal({ backdrop: 'static' });
            $('#remoteModal2').load(target, function () {
                $('#remoteModal2').modal("show");
            });
            return false;
        });

    </script>

    <!-- IMPORTANT: APP CONFIG -->
    <script src="js/app.config.js"></script>

    <!-- JS TOUCH : include this plugin for mobile drag / drop touch events-->
    <script src="js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script>

    <!-- BOOTSTRAP JS -->
    <script src="js/bootstrap/bootstrap.min.js"></script>

    <!-- CUSTOM NOTIFICATION -->
    <script src="js/notification/SmartNotification.min.js"></script>

    <!-- JARVIS WIDGETS -->
    <script src="js/smartwidgets/jarvis.widget.min.js"></script>

    <!-- EASY PIE CHARTS -->
    <script src="js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>

    <!-- SPARKLINES -->
    <script src="js/plugin/sparkline/jquery.sparkline.min.js"></script>

    <!-- JQUERY VALIDATE -->
    <script src="js/plugin/jquery-validate/jquery.validate.min.js"></script>

    <script src="js/selportalscript.js"></script>

    <!-- JQUERY MASKED INPUT -->
    <script src="js/plugin/masked-input/jquery.maskedinput.min.js"></script>

    <!-- JQUERY SELECT2 INPUT -->
    <script src="js/plugin/select2/select2.min.js"></script>

    <!-- JQUERY UI + Bootstrap Slider -->
    <script src="js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>

    <!-- browser msie issue fix -->
    <script src="js/plugin/msie-fix/jquery.mb.browser.min.js"></script>

    <!-- FastClick: For mobile devices: you can disable this in app.js -->
    <script src="js/plugin/fastclick/fastclick.min.js"></script>
    <script type="text/javascript" src="js/plugin/x-editable/moment.min.js"></script>
    <script type="text/javascript" src="js/plugin/x-editable/jquery.mockjax.min.js"></script>
    <script type="text/javascript" src="js/plugin/x-editable/x-editable.min.js"></script>


    <!--[if IE 8]>
        <h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
    <![endif]-->
    <!-- Demo purpose only -->
    <script src="js/demo.min.js"></script>

    <!-- MAIN APP JS FILE -->
    <script src="js/app.min.js"></script>

    <!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
    <!-- Voice command : plugin -->
    <script src="js/speech/voicecommand.min.js"></script>
    <script src="js/communicator/mscommunicator.js"></script>


   <%-- <script>
        var loading = false;
        function GetNotification() {
            AJAXFunction.CallAjaxNoLoading("POST", "/AJAXProcess/Notification.aspx", "GetNotification", {}, function (response) {
                loading = false;
                if (response.Status) {
                    if (response.Count > 9) {
                        $("#activity").find("b.badge").text("9+");
                    }
                    else
                        $("#activity").find("b.badge").text(response.Count);

                    var ul = $(".notification-body").empty();
                    if (response.Data.length == 0) {
                        var li = $('<li style=" width:100%; text-align:center;border-bottom: dotted 2px #eee;list-style: none;">').text('You have no new notifications');
                        ul.append(li);
                    }
                    for (var i = 0; i < response.Data.length; i++) {
                        var li = $("<li>");
                        var span = $("<span>");
                        var div = $('<div class="bar-holder no-padding">');
                        var p = $('<p class="margin-bottom-5">').append($("<a>").attr("href", response.Data[i].Link).append(response.Data[i].Content).click(function (event) {

                            if ("/" + location.hash == $(this).attr("href")) {

                                checkURL();
                            }
                            else {
                                location.replace($(this).attr("href"));
                            }
                        }));
                        div.append(p);
                        span.append(div);
                        li.append(span);
                        ul.append(li);
                    }
                }
                else {
                    var ul = $(".notification-body").empty();
                    if (response.Data.length == 0) {
                        var li = $('<li style=" width:100%; text-align:center;border-bottom: dotted 2px #eee;list-style: none;">').text('You have no new notifications');
                        ul.append(li);
                    }

                }
            });
        }

        function CallGetNotification() {
            if (!loading) {
                loading = true;
                setTimeout(function () {
                    GetNotification();
                });
                setTimeout(function () {
                    CallGetNotification();
                }, 5000)
            }
            else {
                setTimeout(function () {
                    CallGetNotification();
                }, 5000)
            }
        }

        CallGetNotification();
    </script>--%>
    <%--    <script type="text/javascript" src="js/plugin/jqgrid/jquery.jqGrid.min.js"></script>--%>
    <%--<script type="text/javascript" src="js/plugin/jqgrid/grid.locale-en.min.js"></script>--%>
    <div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
    </div>
</body>

</html>
