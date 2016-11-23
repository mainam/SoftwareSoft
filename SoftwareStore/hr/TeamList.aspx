<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeamList.aspx.cs" Inherits="SoftwareStore.hr.TeamList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        

        .org-chart * {
	        -webkit-box-sizing: border-box;
	        -moz-box-sizing: border-box;
	        box-sizing: border-box;
	        position: relative;
        }

        .cf:before,
        .cf:after {
            content: " "; /* 1 */
            display: table; /* 2 */
        }

        .cf:after {
            clear: both;
        }

        /**
         * For IE 6/7 only
         * Include this rule to trigger hasLayout and contain floats.
         */
        .cf {
            *zoom: 1;
        }

        /* Generic styling */

        /*body {
	        background: #F5EEC9;	
        }*/

        .content{
	        width: 100%;
	        max-width: 1142px;
	        margin: 0 auto;
	        padding: 0 20px;
        }

        .org-chart a:focus{
	        outline: 2px dashed #f7f7f7;
        }

        @media all and (max-width: 767px){
	        .content{
		        padding: 0 20px;
	        }	
        }

        .org-chart ul{
	        padding: 0;
	        margin: 0;
	        list-style: none;		
        }

        .org-chart ul a{
	        display: block;
	        background: #ccc;
	        border: 4px solid #fff;
	        text-align: center;
	        overflow: hidden;
	        font-size: .7em;
	        text-decoration: none;
	        font-weight: bold;
	        color: #333;
	        height: 70px;
	        margin-bottom: -26px;
	        box-shadow: 4px 4px 9px -4px rgba(0,0,0,0.4);
	        -webkit-transition: all linear .1s;
	        -moz-transition: all linear .1s;
	        transition: all linear .1s;
        }


        @media all and (max-width: 767px){
	        ul a{
		        font-size: 1em;
	        }
        }


        .org-chart ul a span{
	        top: 50%;
	        margin-top: -0.7em;
	        display: block;
        }

        /*
 
         */

        .org-chart .administration > li > a{
	        margin-bottom: 25px;
        }

        .org-chart .director > li > a{
	        width: 50%;
	        margin: 0 auto 0px auto;
        }

        .org-chart .subdirector:after{
	        content: "";
	        display: block;
	        width: 0;
	        height: 130px;
	        background: red;
	        border-left: 4px solid #fff;
	        left: 45.45%;
	        position: relative;
        }

        .org-chart .subdirector,
        .org-chart .departments{
	        position: absolute;
	        width: 100%;
        }

        .org-chart .subdirector > li:first-child,
        .org-chart .departments > li:first-child{	
	        width: 18.59894921190893%;
	        height: 64px;
	        margin: 0 auto 92px auto;		
	        padding-top: 25px;
	        border-bottom: 4px solid white;
	        z-index: 1;	
        }

        .org-chart .subdirector > li:first-child{
	        float: right;
	        right: 27.2%;
	        border-left: 4px solid white;
        }

        .org-chart .departments > li:first-child{	
	        float: left;
	        left: 27.2%;
	        border-right: 4px solid white;	
        }

        .org-chart .subdirector > li:first-child a,
        .org-chart .departments > li:first-child a{
	        width: 100%;
        }

        .org-chart .subdirector > li:first-child a{	
	        left: 25px;
        }

        @media all and (max-width: 767px){
	        .subdirector > li:first-child,
	        .departments > li:first-child{
		        width: 40%;	
	        }

	        .subdirector > li:first-child{
		        right: 10%;
		        margin-right: 2px;
	        }

	        .subdirector:after{
		        left: 49.8%;
	        }

	        .departments > li:first-child{
		        left: 10%;
		        margin-left: 2px;
	        }
        }


        .org-chart .departments > li:first-child a{
	        right: 25px;
        }

        .org-chart .department:first-child,
        .org-chart .departments li:nth-child(2){
	        margin-left: 0;
	        clear: left;	
        }

        .org-chart .departments:after{
	        content: "";
	        display: block;
	        position: absolute;
	        width: 81.1%;
	        height: 22px;	
	        border-top: 4px solid #fff;
	        border-right: 4px solid #fff;
	        border-left: 4px solid #fff;
	        margin: 0 auto;
	        top: 130px;
	        left: 9.1%
        }

        @media all and (max-width: 767px){
	        .departments:after{
		        border-right: none;
		        left: 0;
		        width: 49.8%;
	        }  
        }

        @media all and (min-width: 768px){
	        .department:first-child:before,
           .department:last-child:before{
            border:none;
          }
        }

        .org-chart .department:before{
	        content: "";
	        display: block;
	        position: absolute;
	        width: 0;
	        height: 22px;
	        border-left: 4px solid white;
	        z-index: 1;
	        top: -22px;
	        left: 50%;
	        margin-left: -4px;
        }

        .org-chart .department{
	        border-left: 4px solid #fff;
	        width: 18.59894921190893%;
	        float: left;
	        margin-left: 1.751313485113835%;
	        margin-bottom: 60px;
        }

        .org-chart .lt-ie8 .department{
	        width: 18.25%;
        }

        @media all and (max-width: 767px){
	        .department{
		        float: none;
		        width: 100%;
		        margin-left: 0;
	        }

	        .department:before{
		        content: "";
		        display: block;
		        position: absolute;
		        width: 0;
		        height: 60px;
		        border-left: 4px solid white;
		        z-index: 1;
		        top: -60px;
		        left: 0%;
		        margin-left: -4px;
	        }

	        .department:nth-child(2):before{
		        display: none;
	        }
        }

        .org-chart .department > a{
	        margin: 0 0 -26px -4px;
	        z-index: 1;
        }

        .org-chart .department > a:hover{	
	        height: 80px;
        }

        .org-chart .department > ul{
	        margin-top: 0px;
	        margin-bottom: 0px;
        }

        .org-chart .department li{	
	        padding-left: 25px;
	        border-bottom: 4px solid #fff;
	        height: 80px;	
        }

        .org-chart .department li a{
	        background: #fff;
	        top: 48px;	
	        position: absolute;
	        z-index: 1;
	        width: 90%;
	        height: 60px;
	        vertical-align: middle;
	        right: -1px;
	        background-image: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIxMDAlIiB5Mj0iMTAwJSI+CiAgICA8c3RvcCBvZmZzZXQ9IjAlIiBzdG9wLWNvbG9yPSIjMDAwMDAwIiBzdG9wLW9wYWNpdHk9IjAuMjUiLz4KICAgIDxzdG9wIG9mZnNldD0iMTAwJSIgc3RvcC1jb2xvcj0iIzAwMDAwMCIgc3RvcC1vcGFjaXR5PSIwIi8+CiAgPC9saW5lYXJHcmFkaWVudD4KICA8cmVjdCB4PSIwIiB5PSIwIiB3aWR0aD0iMSIgaGVpZ2h0PSIxIiBmaWxsPSJ1cmwoI2dyYWQtdWNnZy1nZW5lcmF0ZWQpIiAvPgo8L3N2Zz4=);
	        background-image: -moz-linear-gradient(-45deg,  rgba(0,0,0,0.25) 0%, rgba(0,0,0,0) 100%) !important;
	        background-image: -webkit-gradient(linear, left top, right bottom, color-stop(0%,rgba(0,0,0,0.25)), color-stop(100%,rgba(0,0,0,0)))!important;
	        background-image: -webkit-linear-gradient(-45deg,  rgba(0,0,0,0.25) 0%,rgba(0,0,0,0) 100%)!important;
	        background-image: -o-linear-gradient(-45deg,  rgba(0,0,0,0.25) 0%,rgba(0,0,0,0) 100%)!important;
	        background-image: -ms-linear-gradient(-45deg,  rgba(0,0,0,0.25) 0%,rgba(0,0,0,0) 100%)!important;
	        background-image: linear-gradient(135deg,  rgba(0,0,0,0.25) 0%,rgba(0,0,0,0) 100%)!important;
	        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#40000000', endColorstr='#00000000',GradientType=1 );
        }

        .org-chart .department li a:hover{
	        box-shadow: 8px 8px 9px -4px rgba(0,0,0,0.1);
	        height: 80px;
	        width: 95%;
	        top: 39px;
	        background-image: none!important;
        }

        /* Department/ section colors */
        .org-chart .department.dep-a a{ background: #FFD600; }
        .org-chart .department.dep-b a{ background: #AAD4E7; }
        .org-chart .department.dep-c a{ background: #FDB0FD; }
        .org-chart .department.dep-d a{ background: #A3A2A2; }
        .org-chart .department.dep-e a{ background: #f0f0f0; }
    </style>

    <script type="text/javascript">
        
        var json = '<%= json %>';
        // DO NOT REMOVE : GLOBAL FUNCTIONS!
        pageSetUp();

        // PAGE RELATED SCRIPTS

        $(function () {
            $('.tree > ul').attr('role', 'group').find('ul').attr('role', 'group');
            $('.tree').find('li:has(ul)').addClass('parent_li').attr('role', 'treeitem').find(' > span').attr('title', 'Collapse this branch').on('click', function (e) {
                var children = $(this).parent('li.parent_li').find(' > ul > li');
                if (children.is(':visible')) {
                    children.hide('fast');
                    $(this).attr('title', 'Expand this branch').find(' > i').removeClass().addClass('fa fa-lg fa-plus-circle');
                } else {
                    children.show('fast');
                    $(this).attr('title', 'Collapse this branch').find(' > i').removeClass().addClass('fa fa-lg fa-minus-circle');
                }
                e.stopPropagation();
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        
    </form>
    <div>
        <section id="widget-grid">
            <div class="row">
                <!-- NEW WIDGET START -->
		        <article class="col-sm-12 col-md-12 col-lg-6">

			        <!-- Widget ID (each widget will need unique ID)-->
			        <div class="jarviswidget jarviswidget-color-orange" id="wid-id-0" data-widget-editbutton="false">
				        <!-- widget options:
				        usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

				        data-widget-colorbutton="false"
				        data-widget-editbutton="false"
				        data-widget-togglebutton="false"
				        data-widget-deletebutton="false"
				        data-widget-fullscreenbutton="false"
				        data-widget-custombutton="false"
				        data-widget-collapsed="true"
				        data-widget-sortable="false"

				        -->
				        <header>
					        <span class="widget-icon"> <i class="fa fa-lg fa-calendar"></i> </span>
					        <h2>Team Tree </h2>

				        </header>

				        <!-- widget div-->
				        <div>

					        <!-- widget edit box -->
					        <div class="jarviswidget-editbox">
						        <!-- This area used as dropdown edit box -->

					        </div>
					        <!-- end widget edit box -->

					        <!-- widget content -->
					        <div class="widget-body">

						        <%--<div class="widget-body-toolbar bg-color-white">

							        <form class="form-inline" role="form">

								        <div class="row">

									        <div class="col-sm-12 col-md-10">

										        <div class="form-group">
											        <label class="sr-only">Task title</label>
											        <input type="email" class="form-control input-sm" placeholder="My Task">
										        </div>
										        <div class="form-group">
											        <label class="sr-only">Pick Week</label>
											        <select class="form-control input-sm">
												        <option>Week 1</option>
												        <option>Week 2</option>
											        </select>
										        </div>
										        <div class="form-group">
											        <label class="sr-only">Days</label>
											        <select class="form-control input-sm">
												        <option>Monday</option>
												        <option>Tuesday</option>
												        <option>Wednesday</option>
												        <option>Thursday</option>
												        <option>Friday</option>
												        <option>Saturday</option>
												        <option>Sunday</option>
											        </select>
										        </div>

									        </div>

									        <div class="col-sm-12 col-md-2 text-align-right">

										        <button type="submit" class="btn btn-warning btn-xs">
											        <i class="fa fa-plus"></i> Add
										        </button>

									        </div>

								        </div>

							        </form>

						        </div>--%>

						        <div class="tree">
							        <ul>
								        <li>
									        <span><i class="fa fa-lg fa-calendar"></i> 2013, Week 2</span>
									        <ul>
										        <li>
											        <span class="label label-success"><i class="fa fa-lg fa-plus-circle"></i> Monday, January 7: 8.00 hours</span>
											        <ul>
												        <li>
													        <span class="label label-success"><i class="fa fa-lg fa-plus-circle"></i> Monday, January 7: 8.00 hours</span>
											                <ul>
												                <li>
													                <span><i class="fa fa-clock-o"></i> 8.00</span> &ndash; <a href="javascript:void(0);">Changed CSS to accomodate...</a>
												                </li>
											                </ul>
												        </li>
											        </ul>
										        </li>
										        <li>
											        <span class="label label-success"><i class="fa fa-lg fa-minus-circle"></i> Tuesday, January 8: 8.00 hours</span>
											        <ul>
												        <li>
													        <span><i class="fa fa-clock-o"></i> 6.00</span> &ndash; <a href="javascript:void(0);">Altered code...</a>
												        </li>
												        <li>
													        <span><i class="fa fa-clock-o"></i> 2.00</span> &ndash; <a href="javascript:void(0);">Simplified our approach to...</a>
												        </li>
											        </ul>
										        </li>
										        <li>
											        <span class="label label-warning"><i class="fa fa-lg fa-minus-circle"></i> Wednesday, January 9: 6.00 hours</span>
											        <ul>
												        <li>
													        <span><i class="fa fa-clock-o"></i> 3.00</span> &ndash; <a href="javascript:void(0);">Fixed bug caused by...</a>
												        </li>
												        <li>
													        <span><i class="fa fa-clock-o"></i> 3.00</span> &ndash; <a href="javascript:void(0);">Comitting latest code to Git...</a>
												        </li>
											        </ul>
										        </li>
										        <li>
											        <span class="label label-danger"><i class="fa fa-lg fa-minus-circle"></i> Wednesday, January 9: 4.00 hours</span>
											        <ul>
												        <li>
													        <span><i class="fa fa-clock-o"></i> 2.00</span> &ndash; <a href="javascript:void(0);">Create component that...</a>
												        </li>
											        </ul>
										        </li>
									        </ul>
								        </li>
								        <li>
									        <span><i class="fa fa-lg fa-calendar"></i> 2013, Week 3</span>
									        <ul>
										        <li>
											        <span class="label label-success"><i class="fa fa-lg fa-minus-circle"></i> Monday, January 14: 8.00 hours</span>
											        <ul>
												        <li>
													        <span><i class="fa fa-clock-o"></i> 7.75</span> &ndash; <a href="javascript:void(0);">Writing documentation...</a>
												        </li>
												        <li>
													        <span><i class="fa fa-clock-o"></i> 0.25</span> &ndash; <a href="javascript:void(0);">Reverting code back to...</a>
												        </li>
											        </ul>
										        </li>
									        </ul>
								        </li>
							        </ul>
						        </div>

					        </div>
					        <!-- end widget content -->

				        </div>
				        <!-- end widget div -->

			        </div>
			        <!-- end widget -->

		        </article>
		        <!-- WIDGET END -->

                <!-- NEW WIDGET START -->
		        <article class="col-sm-12 col-md-12 col-lg-6">

			        <!-- Widget ID (each widget will need unique ID)-->
			        <div class="jarviswidget jarviswidget-color-pink" id="wid-id-1" data-widget-editbutton="false">
				        <!-- widget options:
				        usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

				        data-widget-colorbutton="false"
				        data-widget-editbutton="false"
				        data-widget-togglebutton="false"
				        data-widget-deletebutton="false"
				        data-widget-fullscreenbutton="false"
				        data-widget-custombutton="false"
				        data-widget-collapsed="true"
				        data-widget-sortable="false"

				        -->
				        <header>
					        <span class="widget-icon"> <i class="fa fa-lg fa-calendar"></i> </span>
					        <h2>Team Tree </h2>

				        </header>

				        <!-- widget div-->
				        <div>

					        <!-- widget edit box -->
					        <div class="jarviswidget-editbox">
						        <!-- This area used as dropdown edit box -->

					        </div>
					        <!-- end widget edit box -->

					        <!-- widget content -->
					        <div class="widget-body">
                                <div class="content" >
                                  <h1>Responsive Organization Chart</h1>
                                  <figure class="org-chart cf">
                                    <ul class="administration">
                                      <li>					
                                        <ul class="director">
                                          <li>
                                            <a href="#"><span>Director</span></a>
                                            <ul class="subdirector">
                                              <li><a href="#"><span>Assistante Director</span></a></li>
                                            </ul>
                                            <ul class="departments cf">								
                                              <li><a href="#"><span>Administration</span></a></li>
              
                                              <li class="department dep-a">
                                                <a href="#"><span>Department A</span></a>
                                                <ul class="sections">
                                                  <li class="section"><a href="#"><span>Section A1</span></a></li>
                                                  <li class="section"><a href="#"><span>Section A2</span></a></li>
                                                  <li class="section"><a href="#"><span>Section A3</span></a></li>
                                                  <li class="section"><a href="#"><span>Section A4</span></a></li>
                                                  <li class="section"><a href="#"><span>Section A5</span></a></li>
                                                </ul>
                                              </li>
                                              <li class="department dep-b">
                                                <a href="#"><span>Department B</span></a>
                                                <ul class="sections">
                                                  <li class="section"><a href="#"><span>Section B1</span></a></li>
                                                  <li class="section"><a href="#"><span>Section B2</span></a></li>
                                                  <li class="section"><a href="#"><span>Section B3</span></a></li>
                                                  <li class="section"><a href="#"><span>Section B4</span></a></li>
                                                </ul>
                                              </li>
                                              <li class="department dep-c">
                                                <a href="#"><span>Department C</span></a>
                                                <ul class="sections">
                                                  <li class="section"><a href="#"><span>Section C1</span></a></li>
                                                  <li class="section"><a href="#"><span>Section C2</span></a></li>
                                                  <li class="section"><a href="#"><span>Section C3</span></a></li>
                                                  <li class="section"><a href="#"><span>Section C4</span></a></li>
                                                </ul>
                                              </li>
                                              <li class="department dep-d">
                                                <a href="#"><span>Department D</span></a>
                                                <ul class="sections">
                                                  <li class="section"><a href="#"><span>Section D1</span></a></li>
                                                  <li class="section"><a href="#"><span>Section D2</span></a></li>
                                                  <li class="section"><a href="#"><span>Section D3</span></a></li>
                                                  <li class="section"><a href="#"><span>Section D4</span></a></li>
                                                  <li class="section"><a href="#"><span>Section D5</span></a></li>
                                                  <li class="section"><a href="#"><span>Section D6</span></a></li>
                                                </ul>
                                              </li>
                                              <li class="department dep-e">
                                                <a href="#"><span>Department E</span></a>
                                                <ul class="sections">
                                                  <li class="section"><a href="#"><span>Section E1</span></a></li>
                                                  <li class="section"><a href="#"><span>Section E2</span></a></li>
                                                  <li class="section"><a href="#"><span>Section E3</span></a></li>
                                                </ul>
                                              </li>
                                            </ul>
                                          </li>
                                        </ul>	
                                      </li>
                                    </ul>			
                                  </figure>
                                </div>
					        </div>
					        <!-- end widget content -->

				        </div>
				        <!-- end widget div -->

			        </div>
			        <!-- end widget -->

		        </article>
		        <!-- WIDGET END -->
            </div>
        </section>
    </div>
</body>
</html>
