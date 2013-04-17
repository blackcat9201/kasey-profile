<<<<<<< HEAD
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>

        <title>Sans | A Responsive, Single Page Portfolio Template</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, maximum-scale=1.0" />
        <meta name="description" content="Single page portfolio template" />
        <meta name="keywords" content="one-page, one page, portfolio, accordion, jquery, flexible, responsive, web design" />
        <link rel="stylesheet" type="text/css" href="css/styles.css" />
        <link rel="stylesheet" href="css/supersized.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="css/skeleton.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="theme/supersized.shutter.css" type="text/css" media="screen" />
        <link rel="stylesheet" type="text/css" href="css/prettyPhoto.css"/>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700|Anton' rel='stylesheet' type='text/css' />

        <script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="js/jquery.easing.min.js"></script>
        <script type="text/javascript" src="js/supersized.3.2.7.min.js"></script>
        <script type="text/javascript" src="theme/supersized.shutter.min.js"></script>
        <script type="text/javascript" src="js/jquery.prettyPhoto.js"></script> 
        <script type="text/javascript" src="js/jquery.quicksand.js"></script> 
        <script type="text/javascript" src="js/script.js"></script>
        <script type="text/javascript" src="js/jquery.ba-resize.min.js"></script>
        <script type="text/javascript" src="js/jquery.accordion.js"></script>

        <!--[if lt IE 8]>
        <script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE8.js"></script>
        <![endif]-->
        <!--[if lt IE 9]>
            <script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
        <![endif]-->
        <noscript>
            <style type="text/css">
                .st-accordion ul li > a span{
                    visibility: hidden;
                }
            </style>
        </noscript>
        <script type="text/javascript">
            $(function() {
			
                $('#st-accordion').accordion({
                    oneOpenedItem	: true
                });
                
                $('.list-expandable>li').click(function(){
                    if($(this).hasClass('active')){
                        $(this).removeClass('active')
                        $(this).children('ul.check-list').slideDown('fast');
                    } else {
                        $(this).addClass('active')
                        $(this).children('ul.check-list').slideUp('fast');
                    }
                });
            });
			
            jQuery(function($){
				
                $.supersized({
				
                    // Functionality for the Background Slideshow
                    slide_interval          :   7000,		// Length between transitions
                    transition              :   6, 			// 0-None, 1-Fade, 2-Slide Top, 3-Slide Right, 4-Slide Bottom, 5-Slide Left, 6-Carousel Right, 7-Carousel Left
                    transition_speed		:	1000,		// Speed of transition
															   
                    // Components							
                    slide_links				:	'blank',	// Individual links for each slide (Options: false, 'num', 'name', 'blank')
                    slides 					:  	[			// Slideshow Images
                        {image : 'images/slideshow_01.jpg', title : 'Image title'},
                        {image : 'images/slideshow_02.jpg', title : 'Image title'},
                        {image : 'images/slideshow_03.jpg', title : 'Image title'},
                        {image : 'images/slideshow_04.jpg', title : 'Image title'} // Be sure there is no comma after your last slide

                    ]
					
                });
                
            });
		    
            // Functionality for Recent Project Toggle
            function showonlyone(thechosenone) {
                var newsbox = document.getElementsByTagName("div");
                for(var x=0; x<newsbox.length; x++) {
                    name = newsbox[x].getAttribute("class");
                    if (name == 'news-description') {
                        if (newsbox[x].id == thechosenone) {
                            newsbox[x].style.display = 'block';
                        }
                        else {
                            newsbox[x].style.display = 'none';
                        }
                    }
                }
            }

            function unhide(element,divID) {
                var item = document.getElementById(divID);
                
                if (item) {
                    if($(item).hasClass('hidden')){
                        $(element).css('background','url("images/icon_sq_collapse.png") no-repeat #000');
                        $(item).removeClass('hidden');
                        $(item).addClass('unhidden');
                    } else {
                        $(item).removeClass('unhidden');
                        $(item).addClass('hidden');
                        $(element).css('background','url("images/icon_sq_expand.png") no-repeat #ff3c00');
                    }
                }
                
                adjustRespCaption();
            }
            function getURLParameter(name) {
                return decodeURI(
                (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]);
            }

            function submitContactForm(){
                $.post('contact.php', $('#contactform').serialize(), function(response){
                    $('#contactResponse').html(response);
                }, 'html');
            }

            function adjustPortfolioItems(){
                var containerWidth = $('ul.portfolio').width();
                if(containerWidth == 0)
                    return;
                var itemWidth = $('ul.portfolio').children('li.item').width();
                
                var remaining = containerWidth % itemWidth;
                var itemsCount = Math.floor(containerWidth/itemWidth);
                var itemMargin = remaining/(itemsCount-1);

                itemMargin = Math.floor(itemMargin);

                var i = 1;
                
                $('ul.portfolio li.item').each(function(){
                    if((i % itemsCount) != 0){
                        $(this).css('margin-right', itemMargin);
                    } else {
                        $(this).css('margin-right', 0);
                    }
                    i++;
                });
            }

            $(window).resize(function(){
                adjustPortfolioItems();
                adjustRespCaption();
//                $('ul.portfolio').addClass('portfolio-force-auto-height');
            }); 

            function adjustRespCaption(){
                $('.responsive-caption').each(function(){
                    $(this).height($(this).parent().height() 
                        - (parseInt($(this).css('padding-top'))+parseInt($(this).css('padding-bottom'))) - 7);
                });
                
            }

            $(document).ready(function(){
                adjustRespCaption();

                var section = getURLParameter('section');
                if(section.length !=0){
                    $('#'+section).siblings('a').click();
                }
                
                $('#portfolio').resize(function(){
                    adjustPortfolioItems();
                })
                
            });
        </script>
    </head>
    <body>

        <!--Transparent Overlay-->
        <div class="overlay" style="top: 0"></div>
        <!--END Transparent Overlay-->  

        <!--Logo-->
        <div class="logo">
            <img src="images/logo_circle.png" alt="logo" width="100" height="100" />
        </div>
        <!--End Logo-->

        <!--Begin Accordian-->
        <div class="container">
            <div class="wrapper">
                <div id="st-accordion" class="st-accordion">
                    <ul>
                        <!--Start About-->
                        <li class="nav-item">
                            <a href="#"><h1>About</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="about" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>A Little Bit About Sans</h2>
                                        <div class="one_third firstcols">
                                            <h3>Etiam dictum nisi libero. Et cura bitur eleifend ligula ac mauri mollis dict um. Nam quis tortor id ipsum dict um imperdiet. Integer et scele risque metus non orci sollicitudin tincidunt eu eg et tortor. </h3>
                                        </div>
                                        <div class="two_third lastcols">
                                            <div class="one_half firstcols">
                                                <ul> 
                                                    <li><h4 class="icon-eye">Vision</h4><p>Proin vitae tellus libero, vitae pretium sem. Proin id diam eu dui facilisis sagittis. Nunc tincidunt, odio at luctus aliquam, nisi lectus interdum neque, vel consequat augue libero et nisi.  </p></li>

                                                    <li class="margin-hack-top"><h4 class="icon-talk-bubbles">Approach</h4>
                                                        <p>Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula pretium eget libero odio at luctus aliquam. </p></li>
                                                </ul>
                                            </div>
                                            <div class="one_half lastcols">
                                                <ul> 
                                                    <li><h4 class="icon-flag">Motivation</h4>
                                                        <p>Sed turpis enim, vehicula et accumsan eget, cursus vel risus. Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula.</p></li>
                                                    <li class="margin-hack-top"><h4 class="icon-cards">Methodology</h4>
                                                        <p>Eget tortor ut neque scelerisque vehicula pretium eget libero. Aliquam hendrerit tincidunt dictum. Pellen tesque sit amet sed turpis enim, vehicula vitae suscipit sed.</p></li>
                                                </ul>
                                            </div>
                                        </div>

                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End About-->
                        <!--Begin Portfolio-->
                        <li class="nav-item">
                            <a href="#"><h1>Portfolio</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="portfolio" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>Check out Some of Our Work</h2>
                                        <div class="group">
                                            <ul class="filter group">
                                                <li class="current all"><a href="#">All</a></li>
                                                <li class="identity"><a href="#">Identity</a></li>
                                                <li class="print"><a href="#">Print</a></li>
                                                <li class="test"><a href="#">Logo</a></li>
                                            </ul>
                                        </div>
                                        <!-- Portfolio Items -->
                                        <ul class="portfolio group">
                                            <li class="item" data-id="id-1" data-type="logo">
                                                <a href="images/portfolio/port_image_the_bg.jpg" data-gal="prettyPhoto[portfolio_1]"><img src="images/portfolio/the_tn.jpg" width="173" height="173" alt="Portfolio Image 1" />
                                                    <h5>Adipiscing elit</h5>
                                                    <p class="caption">Pellentesque quis nisl eget</p>
                                                </a>
                                                <!-- Sub Portfolio Gallery -->
                                                 <a class="sub-port-gallery" href="images/portfolio/port_image_elephant_bg.jpg" data-gal="prettyPhoto[portfolio_1]"><img src="images/portfolio/the_tn.jpg" width="173" height="173" alt="Portfolio Image 1" /></a>
                                                <a class="sub-port-gallery" href="images/portfolio/port_image_circles_bg.jpg" data-gal="prettyPhoto[portfolio_1]"><img src="images/portfolio/the_tn.jpg" width="173" height="173" alt="Portfolio Image 1" /></a>
                                                <!-- END Sub Portfolio Gallery / delete these if you don't need one thumbnail to hold a gallery of multiple images -->
                                            </li>
                                            <li class="item" data-id="id-2" data-type="print">
                                                <a href="images/portfolio/port_image_oragami_bg.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/geo_3d_tn.jpg" width="173" height="173" alt="Portfolio Image 2" />
                                                    <h5>Venenatis </h5>
                                                    <p class="caption">Integer id urna sit amet</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-3" data-type="identity">
                                                <a href="images/portfolio/port_image_icon_bg.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/logo_icon_tn.jpg" width="173" height="173" alt="Portfolio Image 3" />
                                                    <h5>Hendrerit</h5>
                                                    <p class="caption">Fusce tempus massa mollis</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-4" data-type="print">
                                                <a href="images/portfolio/port_image_bcard_bg.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/bcard_01_tn.jpg" width="173" height="173" alt="Portfolio Image 4" />
                                                    <h5>In lobortis</h5>
                                                    <p class="caption">Pellentesque quis nisl eget</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-5" data-type="logo">
                                                <a href="images/portfolio/port_image_triangle_bg.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/logo_abstract_a_tn.jpg" width="173" height="173" alt="Portfolio Image 5" />
                                                    <h5>Turpis eu </h5>
                                                    <p class="caption">Fusce tempus massa mollis</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-6" data-type="print">
                                                <a href="images/portfolio/pattern_tn.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/pattern_tn.jpg" width="173" height="173" alt="Portfolio Image 6" />
                                                    <h5>Ac diam</h5>
                                                    <p class="caption">Integer id urna sit amet</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-7" data-type="identity">
                                                <a href="images/portfolio/logo_abstract_patt_tn.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/logo_abstract_patt_tn.jpg" width="173" height="173" alt="Portfolio Image 7" />
                                                    <h5>Vestibulum</h5>
                                                    <p class="caption">Pellentesque quis nisl eget </p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-8" data-type="logo">
                                                <a href="images/portfolio/bicycle_tn.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/bicycle_tn.jpg" width="173" height="173" alt="Portfolio Image 8" />
                                                    <h5>Tincidunt</h5>
                                                    <p class="caption">Fusce tempus massa mollis</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-9" data-type="print">
                                                <a href="images/portfolio/port_image_leaves_bg.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/leaves_tn.jpg" width="173" height="173" alt="Portfolio Image 9" />
                                                    <h5>Lorem nec</h5>
                                                    <p class="caption">Integer id urna sit amet</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-10" data-type="identity">
                                                <a href="images/portfolio/logo_icons_tn.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/logo_icons_tn.jpg" width="173" height="173" alt="Portfolio Image 10" />
                                                    <h5>Ipsum </h5>
                                                    <p class="caption">Pellentesque quis nisl eget </p>
                                                </a>
                                            </li>
                                        </ul>
                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End Portfolio-->
                        <!--Start Team-->
                        <li class="nav-item">
                            <a href="#"><h1>Team</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="team" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>Meet the Team</h2>
                                        <div class="one_fifth firstcols team-member">
                                            <div class="image-additional-info-wrapper">

                                                <div class="icon-more-info"><a onClick="unhide(this,'teammember01');">&nbsp;</a></div>
                                                <div id="teammember01" class="responsive-caption hidden"><span class="caption bold-white">Praesent pretium nibh eu nunc conse quat volut pat. Nulla tinci dunt tempus molestie. Fusce ut magna cursust</span></div>
                                                <img  src="images/team_01.jpg" alt="team" class="responsive-image"/>
                                            </div>

                                            <div class="name-jobtitle">
                                                <h5>Lukas Meryem</h5>
                                                <span class="caption">Founder</span>
                                            </div>
                                            <div class="equal-column-height">
                                                <p>Consequat non dui sed eget tortor ut neque scelerisque vehicula pretium eget libero. Aliquam hendrerit tincidunt dictum.</p>
                                            </div>
                                            <ul class="social-icon">
                                                <li><a href="#" class="email"></a></li>
                                                <li><a href="#" class="twitter"></a></li>
                                                <li><a href="#" class="facebook"></a></li>
                                                <li><a href="#" class="linkedin"></a></li>
                                            </ul>
                                        </div>
                                        <div class="one_fifth team-member">
                                            <div class="image-additional-info-wrapper">
                                                <img  src="images/team_02.jpg" alt="team" class="responsive-image"/>
                                                <div class="icon-more-info"><a onClick="unhide(this,'teammember02');">&nbsp;</a></div>
                                                <div id="teammember02" class="responsive-caption hidden"><span class="caption bold-white">Praesent pretium nibh eu nunc conse quat volut pat. Nulla tinci dunt tempus molestie. Fusce ut magna cursust</span></div>
                                            </div>

                                            <div class="name-jobtitle">
                                                <h5>Maria Alvarez</h5>
                                                <span class="caption">Creative Director</span>
                                            </div>
                                            <div class="equal-column-height">
                                                <p>Pellentesque sit amet nulla purus. Aliquam hendrerit tincidunt dictum. Nulla purus hendrerit vitae suscipit sed eget tortor.</p>
                                            </div>
                                            <ul class="social-icon">
                                                <li><a href="#" class="email"></a></li>
                                                <li><a href="#" class="twitter"></a></li>
                                                <li><a href="#" class="facebook"></a></li>
                                                <li><a href="#" class="linkedin"></a></li>
                                            </ul>
                                        </div>
                                        <div class="one_fifth team-member">
                                            <div class="image-additional-info-wrapper">
                                                <img src="images/team_03.jpg" alt="team" class="responsive-image"/>
                                                <div class="icon-more-info"><a onClick="unhide(this,'teammember03');">&nbsp;</a></div>
                                                <div id="teammember03" class="responsive-caption hidden"><span class="caption bold-white">Praesent pretium nibh eu nunc conse quat volut pat. Nulla tinci dunt tempus molestie. Fusce ut magna cursust</span></div>
                                            </div>

                                            <div class="name-jobtitle">
                                                <h5>Phil Taylor</h5>
                                                <span class="caption">Marketing</span> 
                                            </div>
                                            <div class="equal-column-height">
                                                <p>Hendrerit tellus sem hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula pretium eget libero.</p>
                                            </div>
                                            <ul class="social-icon">
                                                <li><a href="#" class="email"></a></li>
                                                <li><a href="#" class="twitter"></a></li>
                                                <li><a href="#" class="facebook"></a></li>
                                                <li><a href="#" class="linkedin"></a></li>
                                            </ul>
                                        </div>
                                        <div class="one_fifth team-member">
                                            <div class="image-additional-info-wrapper">
                                                <img  src="images/team_04.jpg" alt="team" class="responsive-image"/>
                                                <div class="icon-more-info"><a onClick="unhide(this,'teammember04');">&nbsp;</a></div>
                                                <div id="teammember04" class="responsive-caption hidden"><span class="caption bold-white">Praesent pretium nibh eu nunc conse quat volut pat. Nulla tinci dunt tempus molestie. Fusce ut magna cursust</span></div>
                                            </div>

                                            <div class="name-jobtitle">
                                                <h5>Nick Steiner</h5>
                                                <span class="caption">Senior Designer</span>
                                            </div>
                                            <div class="equal-column-height">
                                                <p> Aliquam hendrerit tincidunt dictum. Pellentesque sit amet nulla purus hendrerit vitae suscipit sed. Sed eget tortor ut.</p>
                                            </div>
                                            <ul class="social-icon">
                                                <li><a href="#" class="email"></a></li>
                                                <li><a href="#" class="twitter"></a></li>
                                                <li><a href="#" class="facebook"></a></li>
                                                <li><a href="#" class="linkedin"></a></li>
                                            </ul>
                                        </div>
                                        <div class="one_fifth lastcols team-member">
                                            <div class="image-additional-info-wrapper">
                                                <img  src="images/team_05.jpg" alt="team" class="responsive-image"/>
                                                <div class="icon-more-info"><a onClick="unhide(this,'teammember05');">&nbsp;</a></div>
                                                <div id="teammember05" class="responsive-caption hidden"><span class="caption bold-white">Praesent pretium nibh eu nunc conse quat volut pat. Nulla tinci dunt tempus molestie. Fusce ut magna cursust</span></div>
                                            </div>

                                            <div class="name-jobtitle">
                                                <h5>Anna Olsen</h5>
                                                <span class="caption">Designer</span>
                                            </div>
                                            <div class="equal-column-height">
                                                <p>Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula pretium eget libero.</p>
                                            </div>
                                            <ul class="social-icon">
                                                <li><a href="#" class="email"></a></li>
                                                <li><a href="#" class="twitter"></a></li>
                                                <li><a href="#" class="facebook"></a></li>
                                                <li><a href="#" class="linkedin"></a></li>
                                            </ul>
                                        </div>
                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End Team-->
                        <!--Start Services-->
                        <li class="nav-item">

                            <a href="#"><h1>Services</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="services" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>Here's what we do</h2>
                                        <div class="one_third firstcols">
                                            <ul>
                                                <li><h4 class="icon-print">Print Design</h4>
                                                    <p>Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula pretium eget libero. Aliquam hendrerit tincidunt dictum. Pellen tesque sit amet nulla purus.  </p>
                                                    <div class="list-container ">
                                                        <ul class="list-expandable grey-line-bottom">
                                                            <li class="active">
                                                                Services
                                                                <ul class="check-list">
                                                                    <li>Imperdiet Orci Tristique</li>
                                                                    <li>Nisi Sem Vitae</li>
                                                                    <li>Vitae Vulputate Ante</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                                <li class="margin-hack-top">
                                                    <h4 class="icon-web">Web Design</h4>
                                                    <p>Sed et eros sit amet elit gravida bibendum in eget lorem. Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula pretium eget libero. Aliquam hendrerit tincidunt.</p>
                                                    <div class="list-container">
                                                        <ul class="list-expandable no-margin">
                                                            <li class="active">
                                                                Services
                                                                <ul class="check-list">
                                                                    <li>Imperdiet Orci Tristique</li>
                                                                    <li>Nisi Sem Vitae</li>
                                                                    <li>Vitae Vulputate Ante</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="one_third ">
                                            <ul>
                                                <li>
                                                    <h4 class="icon-identity">Identity Design</h4>
                                                    <p>Pellentesque sit amet nulla purus. Sed laoreet rutrum iaculis. Pellentesque fringilla nisi sem, vitae vulputate ante. Fusce eget ligula neque, nec congue augue. Etiam at libero imperdiet orci tristique bibendum vitae vel est.</p>
                                                    <div class="list-container">
                                                        <ul class="list-expandable grey-line-bottom">
                                                            <li class="active">
                                                                Services
                                                                <ul class="check-list">
                                                                    <li>Imperdiet Orci Tristique</li>
                                                                    <li>Nisi Sem Vitae</li>
                                                                    <li>Vitae Vulputate Ante</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                                <li class="margin-hack-top">
                                                    <h4 class="icon-tag">Packaging Design</h4>
                                                    <p> Augue fringilla nisi sem, vitae vulputate ante. Fusce eget ligula neque, nec congue augue. Etiam at libero imperdiet orci tristique bibendum vitae vel est. Sed et eros sit amet elit gravida bibendum in eget lorem.</p>
                                                    <div class="list-container">
                                                        <ul class="list-expandable no-margin">
                                                            <li class="active">
                                                                Services
                                                                <ul class="check-list">
                                                                    <li>Imperdiet Orci Tristique</li>
                                                                    <li>Nisi Sem Vitae</li>
                                                                    <li>Vitae Vulputate Ante</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="one_third lastcols">
                                            <ul>
                                                <li>
                                                    <h4 class="icon-leaf">Branding</h4>
                                                    <p>Etiam at libero imperdiet orci tristique bibendum vitae vel est. Sed et eros sit amet elit gravida bibendum in eget lorem. Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque.</p>
                                                    <div class="list-container">
                                                        <ul class="list-expandable grey-line-bottom">
                                                            <li class="active">Services
                                                                <ul class="check-list">
                                                                    <li>Research & Analysis</li>
                                                                    <li>Brand Strategy</li>
                                                                    <li>Visual & Verbal Branding</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                                <li class="margin-hack-top"> 
                                                    <h4 class="icon-fast-forward ">3D Animation</h4>
                                                    <p>Aliquam hendrerit tincidunt dictum. Pellentesque sit amet nulla purus. Sed laoreet rutrum iaculis. Pellentesque fringilla nisi sem, vitae vulputate ante. Fusce eget ligula neque, nec congue augue.</p>
                                                    <div class="list-container">
                                                        <ul class="list-expandable no-margin">
                                                            <li class="active">Services
                                                                <ul class="check-list">
                                                                    <li>Imperdiet Orci Tristique</li>
                                                                    <li>Nisi Sem Vitae</li>
                                                                    <li>Vitae Vulputate Ante</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End Services-->
                        <!--Start News-->
                        <li class="nav-item">
                            <a href="#"><h1>News</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="news" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>Recently Completed Work</h2>
                                        <div class="one_third firstcols">
                                            <ul class="brief">
                                                <li>
                                                    <span class="tag">7/01/2012</span> 
                                                    <h5><a id="news_header1" onClick="javascript:showonlyone('news1');" >
                                                            Convallis Mollis</a></h5>
                                                    <span class="caption">Quam nulla ultrices sem id gravida lectus magna id libero.</span>
                                                </li>
                                                <li>
                                                    <span class="tag">7/16/2012</span> 
                                                    <h5><a id="news_header2" onClick="javascript:showonlyone('news2');" >
                                                            Etiam Fringilla Tellus</a></h5>
                                                    <span class="caption">Aenean velit nunc auctor eget rutrum eget bibendu.</span>
                                                </li>
                                                <li>
                                                    <span class="tag">8/04/2012</span> 
                                                    <h5><a id="news_header3" onClick="javascript:showonlyone('news3');" >
                                                            Blandit Tincidunt</a></h5>
                                                    <span class="caption"> Phasellus in nunc eget tortor interdum tincidunt ornare.</span>
                                                </li>
                                                <li>
                                                    <span class="tag">9/08/2012</span> 
                                                    <h5><a id="news_header4" onClick="javascript:showonlyone('news4');" >
                                                            Porta Massa Quis</a></h5>
                                                    <span class="caption">Quam nulla ultrices sem id gravida lectus magna id libero</span>
                                                </li>
                                            </ul>
                                        </div>

                                        <div class="two_third lastcols">
                                            <div class="news-description" id="news1">
                                                <div class="align-left grey-line-left">
                                                    <a href="?section=portfolio"><img src="images/portfolio/geo_3d_tn.jpg" alt="image" title="image"/></a>
                                                </div>
                                                <div class="align-right news-project-descrip-wrapper">
                                                    <div class="description">
                                                        <h4>Convallis Mollis</h4>
                                                        <p>Sed ullamcorper, orci ut convallis mollis, quam nulla ultrices sem, id gravida lectus magna id libero. Morbi accumsan nulla in quam pharetra non tristique massa suscipit. Praesent viverra tristiquetortor, ut tempus massa mollis ac. Sed eu justo velit, a consectetur erat.</p>
                                                    </div>
                                                    <div class="social-share">
                                                        <ul>
                                                            <li class="icon-fb"><h6>facebook</h6></li>
                                                            <li class="icon-twitter"><h6>twitter</h6></li>
                                                            <li class="icon-share"><h6>share</h6></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--End News Story 1-->
                                            <!--Start News Story 2-->
                                            <div class="news-description" id="news2" style="display:none;" >
                                                <div class="align-left grey-line-left">
                                                    <a href="#portfolio"><img src="images/portfolio/logo_abstract_a_tn.jpg" alt="image"
                                                                              width="222" height="222" title="image" /></a>
                                                </div>
                                                <div class="align-right news-project-descrip-wrapper">
                                                    <div class="description">
                                                        <h4>Etiam Fringilla Tellus</h4>
                                                        <p> Aenean velit nunc, auctor eget rutrum eget, dapibus quis arcu. Nam at rhoncus sem. Nunc sit amet arcu mi. Donec nec lectus est. Proin sollicitudin consectetur nunc placerat pharetra. Cras est odio, lacinia viverra fermentum vehicula, ornare facilisis nisi. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus in nunc eget tortor interdum tincidunt ornare vitae erat. Suspendisse potenti. </p>
                                                    </div>
                                                    <div class="social-share">
                                                        <ul>
                                                            <li class="icon-fb"><h6>facebook</h6></li>
                                                            <li class="icon-twitter"><h6>twitter</h6></li>
                                                            <li class="icon-share"><h6>share</h6></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--End News Story 2-->
                                            <!--Start News Story 3-->
                                            <div class="news-description" id="news3" style="display:none;" >
                                                <div class="align-left grey-line-left">
                                                    <a href="#portfolio"><img src="images/portfolio/logo_abstract_a_tn.jpg" alt="image"
                                                                              width="222" height="222" title="image" /></a>
                                                </div>
                                                <div class="align-right news-project-descrip-wrapper">
                                                    <div class="description">
                                                        <h4>Blandit Tincidunt</h4>
                                                        <p> Donec in dolor velit, et mattis purus. Sed a diam velit. Phasellus tempor est velit. Aenean velit nunc, auctor eget rutrum eget, dapibus quis arcu. Nam at rhoncus sem. Nunc sit amet arcu mi. Donec nec lectus est. Proin sollicitudin consectetur nunc.</p>
                                                    </div>
                                                    <div class="social-share">
                                                        <ul>
                                                            <li class="icon-fb"><h6>facebook</h6></li>
                                                            <li class="icon-twitter"><h6>twitter</h6></li>
                                                            <li class="icon-share"><h6>share</h6></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--End News Story 3-->
                                            <!--Start News Story 4-->
                                            <div class="news-description" id="news4" style="display:none;" >
                                                <div class="align-left grey-line-left">
                                                    <a href="#portfolio"><img src="images/portfolio/logo_abstract_a_tn.jpg" alt="image"
                                                                              width="222" height="222" title="image" /></a>
                                                </div>
                                                <div class="align-right news-project-descrip-wrapper">
                                                    <div class="description">
                                                        <h4>Porta Massa Quis</h4>
                                                        <p> Curabitur et elit augue, eu iaculis urna. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus in nunc eget tortor interdum tincidunt ornare vitae erat. Suspendisse potenti. Aliquam vel enim id ligula lobortis feugiat ut id urna. Nulla facilisi. Etiam rhoncus ipsum sed urna tincidunt pretium. Proin a diam eu ipsum malesuada malesuada nec non sapien. </p>
                                                    </div>
                                                    <div class="social-share">
                                                        <ul>
                                                            <li class="icon-fb"><h6>facebook</h6></li>
                                                            <li class="icon-twitter"><h6>twitter</h6></li>
                                                            <li class="icon-share"><h6>share</h6></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--End News Story 4-->
                                        </div>
                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End News-->
                        <!--Start Contact-->
                        <li class="nav-item">
                            <a href="#"><h1>Contact</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="contact" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>Get in touch with us</h2>
                                        <div class="two_third firstcols">
                                            <p id="contactResponse"></p>
                                            <form method="post" action="#" id="contactform" class="contactform">
                                                <span class="label">Name</span>
                                                <input type="text" id="name" name="name" class="field text" />
                                                <span class="label">Email</span>
                                                <input type="text" id="email" name="email" class="field text" value="" />
                                                <span class="label">Subject</span>
                                                <input type="text" id="subject" name="subject" class="field textbig" value="" />
                                                <span class="label">Message</span>
                                                <textarea rows="25" cols="45" id="comments" name="comments" class="field"></textarea>
                                                <input type="button" onClick="submitContactForm()" id="submitbtn" value="send it" class="field button" />
                                            </form>
                                        </div>
                                        <div class="one_third lastcols">
                                            <h4 class="with-icon">We're Available!</h4>
                                            <p>We are currently taking on new projects. Blandit ut aliquet nisi feugiat. Vivamus consectetur hendrerit libero, vitae cursus odio elementum quis. </p>
                                            <p>Curabitur tellus orci, condimentum non tincidunt nec, condimentum quis dui.</p>
                                            <h4 class="with-icon grey-line-top">Contact Information</h4>
                                            <ul>
                                                <li class="icon-address"><p class="bold">434 Main Street, NY NY</p></li>
                                                <li class="icon-phone"><p class="bold">Phone: +1 888 555 1234</p></li>
                                                <li class="icon-email-small"><p class="bold">Email: info@yoktemplates.com</p></li>
                                                <li class="icon-blog"><p class="bold">Blog: yoktemplates.com</p></li>
                                            </ul>
                                        </div>
                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End Contact-->
                        <!--Start Twitter-->
                        <li class="nav-item">
                            <div id="follow">
                                <div class="follow-me-icon"><span class="follow-me-text">follow us on twitter</span></div>                       
                            </div>
                        </li>
                        <!--End Twitter-->
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>


=======
<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>

        <title>Sans | A Responsive, Single Page Portfolio Template</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, maximum-scale=1.0" />
        <meta name="description" content="Single page portfolio template" />
        <meta name="keywords" content="one-page, one page, portfolio, accordion, jquery, flexible, responsive, web design" />
        <link rel="stylesheet" type="text/css" href="css/styles.css" />
        <link rel="stylesheet" href="css/supersized.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="css/skeleton.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="theme/supersized.shutter.css" type="text/css" media="screen" />
        <link rel="stylesheet" type="text/css" href="css/prettyPhoto.css"/>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700|Anton' rel='stylesheet' type='text/css' />

        <script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="js/jquery.easing.min.js"></script>
        <script type="text/javascript" src="js/supersized.3.2.7.min.js"></script>
        <script type="text/javascript" src="theme/supersized.shutter.min.js"></script>
        <script type="text/javascript" src="js/jquery.prettyPhoto.js"></script> 
        <script type="text/javascript" src="js/jquery.quicksand.js"></script> 
        <script type="text/javascript" src="js/script.js"></script>
        <script type="text/javascript" src="js/jquery.ba-resize.min.js"></script>
        <script type="text/javascript" src="js/jquery.accordion.js"></script>

        <!--[if lt IE 8]>
        <script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE8.js"></script>
        <![endif]-->
        <!--[if lt IE 9]>
            <script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
        <![endif]-->
        <noscript>
            <style type="text/css">
                .st-accordion ul li > a span{
                    visibility: hidden;
                }
            </style>
        </noscript>
        <script type="text/javascript">
            $(function() {
			
                $('#st-accordion').accordion({
                    oneOpenedItem	: true
                });
                
                $('.list-expandable>li').click(function(){
                    if($(this).hasClass('active')){
                        $(this).removeClass('active')
                        $(this).children('ul.check-list').slideDown('fast');
                    } else {
                        $(this).addClass('active')
                        $(this).children('ul.check-list').slideUp('fast');
                    }
                });
            });
			
            jQuery(function($){
				
                $.supersized({
				
                    // Functionality for the Background Slideshow
                    slide_interval          :   7000,		// Length between transitions
                    transition              :   6, 			// 0-None, 1-Fade, 2-Slide Top, 3-Slide Right, 4-Slide Bottom, 5-Slide Left, 6-Carousel Right, 7-Carousel Left
                    transition_speed		:	1000,		// Speed of transition
															   
                    // Components							
                    slide_links				:	'blank',	// Individual links for each slide (Options: false, 'num', 'name', 'blank')
                    slides 					:  	[			// Slideshow Images
                        {image : 'images/slideshow_01.jpg', title : 'Image title'},
                        {image : 'images/slideshow_02.jpg', title : 'Image title'},
                        {image : 'images/slideshow_03.jpg', title : 'Image title'},
                        {image : 'images/slideshow_04.jpg', title : 'Image title'} // Be sure there is no comma after your last slide

                    ]
					
                });
                
            });
		    
            // Functionality for Recent Project Toggle
            function showonlyone(thechosenone) {
                var newsbox = document.getElementsByTagName("div");
                for(var x=0; x<newsbox.length; x++) {
                    name = newsbox[x].getAttribute("class");
                    if (name == 'news-description') {
                        if (newsbox[x].id == thechosenone) {
                            newsbox[x].style.display = 'block';
                        }
                        else {
                            newsbox[x].style.display = 'none';
                        }
                    }
                }
            }

            function unhide(element,divID) {
                var item = document.getElementById(divID);
                
                if (item) {
                    if($(item).hasClass('hidden')){
                        $(element).css('background','url("images/icon_sq_collapse.png") no-repeat #000');
                        $(item).removeClass('hidden');
                        $(item).addClass('unhidden');
                    } else {
                        $(item).removeClass('unhidden');
                        $(item).addClass('hidden');
                        $(element).css('background','url("images/icon_sq_expand.png") no-repeat #ff3c00');
                    }
                }
                
                adjustRespCaption();
            }
            function getURLParameter(name) {
                return decodeURI(
                (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]);
            }

            function submitContactForm(){
                $.post('contact.php', $('#contactform').serialize(), function(response){
                    $('#contactResponse').html(response);
                }, 'html');
            }

            function adjustPortfolioItems(){
                var containerWidth = $('ul.portfolio').width();
                if(containerWidth == 0)
                    return;
                var itemWidth = $('ul.portfolio').children('li.item').width();
                
                var remaining = containerWidth % itemWidth;
                var itemsCount = Math.floor(containerWidth/itemWidth);
                var itemMargin = remaining/(itemsCount-1);

                itemMargin = Math.floor(itemMargin);

                var i = 1;
                
                $('ul.portfolio li.item').each(function(){
                    if((i % itemsCount) != 0){
                        $(this).css('margin-right', itemMargin);
                    } else {
                        $(this).css('margin-right', 0);
                    }
                    i++;
                });
            }

            $(window).resize(function(){
                adjustPortfolioItems();
                adjustRespCaption();
//                $('ul.portfolio').addClass('portfolio-force-auto-height');
            }); 

            function adjustRespCaption(){
                $('.responsive-caption').each(function(){
                    $(this).height($(this).parent().height() 
                        - (parseInt($(this).css('padding-top'))+parseInt($(this).css('padding-bottom'))) - 7);
                });
                
            }

            $(document).ready(function(){
                adjustRespCaption();

                var section = getURLParameter('section');
                if(section.length !=0){
                    $('#'+section).siblings('a').click();
                }
                
                $('#portfolio').resize(function(){
                    adjustPortfolioItems();
                })
                
            });
        </script>
    </head>
    <body>

        <!--Transparent Overlay-->
        <div class="overlay" style="top: 0"></div>
        <!--END Transparent Overlay-->  

        <!--Logo-->
        <div class="logo">
            <img src="images/logo_circle.png" alt="logo" width="100" height="100" />
        </div>
        <!--End Logo-->

        <!--Begin Accordian-->
        <div class="container">
            <div class="wrapper">
                <div id="st-accordion" class="st-accordion">
                    <ul>
                        <!--Start About-->
                        <li class="nav-item">
                            <a href="#"><h1>About</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="about" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>A Little Bit About Sans</h2>
                                        <div class="one_third firstcols">
                                            <h3>Etiam dictum nisi libero. Et cura bitur eleifend ligula ac mauri mollis dict um. Nam quis tortor id ipsum dict um imperdiet. Integer et scele risque metus non orci sollicitudin tincidunt eu eg et tortor. </h3>
                                        </div>
                                        <div class="two_third lastcols">
                                            <div class="one_half firstcols">
                                                <ul> 
                                                    <li><h4 class="icon-eye">Vision</h4><p>Proin vitae tellus libero, vitae pretium sem. Proin id diam eu dui facilisis sagittis. Nunc tincidunt, odio at luctus aliquam, nisi lectus interdum neque, vel consequat augue libero et nisi.  </p></li>

                                                    <li class="margin-hack-top"><h4 class="icon-talk-bubbles">Approach</h4>
                                                        <p>Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula pretium eget libero odio at luctus aliquam. </p></li>
                                                </ul>
                                            </div>
                                            <div class="one_half lastcols">
                                                <ul> 
                                                    <li><h4 class="icon-flag">Motivation</h4>
                                                        <p>Sed turpis enim, vehicula et accumsan eget, cursus vel risus. Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula.</p></li>
                                                    <li class="margin-hack-top"><h4 class="icon-cards">Methodology</h4>
                                                        <p>Eget tortor ut neque scelerisque vehicula pretium eget libero. Aliquam hendrerit tincidunt dictum. Pellen tesque sit amet sed turpis enim, vehicula vitae suscipit sed.</p></li>
                                                </ul>
                                            </div>
                                        </div>

                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End About-->
                        <!--Begin Portfolio-->
                        <li class="nav-item">
                            <a href="#"><h1>Portfolio</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="portfolio" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>Check out Some of Our Work</h2>
                                        <div class="group">
                                            <ul class="filter group">
                                                <li class="current all"><a href="#">All</a></li>
                                                <li class="identity"><a href="#">Identity</a></li>
                                                <li class="print"><a href="#">Print</a></li>
                                                <li class="test"><a href="#">Logo</a></li>
                                            </ul>
                                        </div>
                                        <!-- Portfolio Items -->
                                        <ul class="portfolio group">
                                            <li class="item" data-id="id-1" data-type="logo">
                                                <a href="images/portfolio/port_image_the_bg.jpg" data-gal="prettyPhoto[portfolio_1]"><img src="images/portfolio/the_tn.jpg" width="173" height="173" alt="Portfolio Image 1" />
                                                    <h5>Adipiscing elit</h5>
                                                    <p class="caption">Pellentesque quis nisl eget</p>
                                                </a>
                                                <!-- Sub Portfolio Gallery -->
                                                 <a class="sub-port-gallery" href="images/portfolio/port_image_elephant_bg.jpg" data-gal="prettyPhoto[portfolio_1]"><img src="images/portfolio/the_tn.jpg" width="173" height="173" alt="Portfolio Image 1" /></a>
                                                <a class="sub-port-gallery" href="images/portfolio/port_image_circles_bg.jpg" data-gal="prettyPhoto[portfolio_1]"><img src="images/portfolio/the_tn.jpg" width="173" height="173" alt="Portfolio Image 1" /></a>
                                                <!-- END Sub Portfolio Gallery / delete these if you don't need one thumbnail to hold a gallery of multiple images -->
                                            </li>
                                            <li class="item" data-id="id-2" data-type="print">
                                                <a href="images/portfolio/port_image_oragami_bg.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/geo_3d_tn.jpg" width="173" height="173" alt="Portfolio Image 2" />
                                                    <h5>Venenatis </h5>
                                                    <p class="caption">Integer id urna sit amet</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-3" data-type="identity">
                                                <a href="images/portfolio/port_image_icon_bg.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/logo_icon_tn.jpg" width="173" height="173" alt="Portfolio Image 3" />
                                                    <h5>Hendrerit</h5>
                                                    <p class="caption">Fusce tempus massa mollis</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-4" data-type="print">
                                                <a href="images/portfolio/port_image_bcard_bg.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/bcard_01_tn.jpg" width="173" height="173" alt="Portfolio Image 4" />
                                                    <h5>In lobortis</h5>
                                                    <p class="caption">Pellentesque quis nisl eget</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-5" data-type="logo">
                                                <a href="images/portfolio/port_image_triangle_bg.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/logo_abstract_a_tn.jpg" width="173" height="173" alt="Portfolio Image 5" />
                                                    <h5>Turpis eu </h5>
                                                    <p class="caption">Fusce tempus massa mollis</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-6" data-type="print">
                                                <a href="images/portfolio/pattern_tn.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/pattern_tn.jpg" width="173" height="173" alt="Portfolio Image 6" />
                                                    <h5>Ac diam</h5>
                                                    <p class="caption">Integer id urna sit amet</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-7" data-type="identity">
                                                <a href="images/portfolio/logo_abstract_patt_tn.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/logo_abstract_patt_tn.jpg" width="173" height="173" alt="Portfolio Image 7" />
                                                    <h5>Vestibulum</h5>
                                                    <p class="caption">Pellentesque quis nisl eget </p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-8" data-type="logo">
                                                <a href="images/portfolio/bicycle_tn.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/bicycle_tn.jpg" width="173" height="173" alt="Portfolio Image 8" />
                                                    <h5>Tincidunt</h5>
                                                    <p class="caption">Fusce tempus massa mollis</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-9" data-type="print">
                                                <a href="images/portfolio/port_image_leaves_bg.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/leaves_tn.jpg" width="173" height="173" alt="Portfolio Image 9" />
                                                    <h5>Lorem nec</h5>
                                                    <p class="caption">Integer id urna sit amet</p>
                                                </a>
                                            </li>
                                            <li class="item" data-id="id-10" data-type="identity">
                                                <a href="images/portfolio/logo_icons_tn.jpg" data-gal="prettyPhoto[portfolio]"><img src="images/portfolio/logo_icons_tn.jpg" width="173" height="173" alt="Portfolio Image 10" />
                                                    <h5>Ipsum </h5>
                                                    <p class="caption">Pellentesque quis nisl eget </p>
                                                </a>
                                            </li>
                                        </ul>
                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End Portfolio-->
                        <!--Start Team-->
                        <li class="nav-item">
                            <a href="#"><h1>Team</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="team" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>Meet the Team</h2>
                                        <div class="one_fifth firstcols team-member">
                                            <div class="image-additional-info-wrapper">

                                                <div class="icon-more-info"><a onClick="unhide(this,'teammember01');">&nbsp;</a></div>
                                                <div id="teammember01" class="responsive-caption hidden"><span class="caption bold-white">Praesent pretium nibh eu nunc conse quat volut pat. Nulla tinci dunt tempus molestie. Fusce ut magna cursust</span></div>
                                                <img  src="images/team_01.jpg" alt="team" class="responsive-image"/>
                                            </div>

                                            <div class="name-jobtitle">
                                                <h5>Lukas Meryem</h5>
                                                <span class="caption">Founder</span>
                                            </div>
                                            <div class="equal-column-height">
                                                <p>Consequat non dui sed eget tortor ut neque scelerisque vehicula pretium eget libero. Aliquam hendrerit tincidunt dictum.</p>
                                            </div>
                                            <ul class="social-icon">
                                                <li><a href="#" class="email"></a></li>
                                                <li><a href="#" class="twitter"></a></li>
                                                <li><a href="#" class="facebook"></a></li>
                                                <li><a href="#" class="linkedin"></a></li>
                                            </ul>
                                        </div>
                                        <div class="one_fifth team-member">
                                            <div class="image-additional-info-wrapper">
                                                <img  src="images/team_02.jpg" alt="team" class="responsive-image"/>
                                                <div class="icon-more-info"><a onClick="unhide(this,'teammember02');">&nbsp;</a></div>
                                                <div id="teammember02" class="responsive-caption hidden"><span class="caption bold-white">Praesent pretium nibh eu nunc conse quat volut pat. Nulla tinci dunt tempus molestie. Fusce ut magna cursust</span></div>
                                            </div>

                                            <div class="name-jobtitle">
                                                <h5>Maria Alvarez</h5>
                                                <span class="caption">Creative Director</span>
                                            </div>
                                            <div class="equal-column-height">
                                                <p>Pellentesque sit amet nulla purus. Aliquam hendrerit tincidunt dictum. Nulla purus hendrerit vitae suscipit sed eget tortor.</p>
                                            </div>
                                            <ul class="social-icon">
                                                <li><a href="#" class="email"></a></li>
                                                <li><a href="#" class="twitter"></a></li>
                                                <li><a href="#" class="facebook"></a></li>
                                                <li><a href="#" class="linkedin"></a></li>
                                            </ul>
                                        </div>
                                        <div class="one_fifth team-member">
                                            <div class="image-additional-info-wrapper">
                                                <img src="images/team_03.jpg" alt="team" class="responsive-image"/>
                                                <div class="icon-more-info"><a onClick="unhide(this,'teammember03');">&nbsp;</a></div>
                                                <div id="teammember03" class="responsive-caption hidden"><span class="caption bold-white">Praesent pretium nibh eu nunc conse quat volut pat. Nulla tinci dunt tempus molestie. Fusce ut magna cursust</span></div>
                                            </div>

                                            <div class="name-jobtitle">
                                                <h5>Phil Taylor</h5>
                                                <span class="caption">Marketing</span> 
                                            </div>
                                            <div class="equal-column-height">
                                                <p>Hendrerit tellus sem hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula pretium eget libero.</p>
                                            </div>
                                            <ul class="social-icon">
                                                <li><a href="#" class="email"></a></li>
                                                <li><a href="#" class="twitter"></a></li>
                                                <li><a href="#" class="facebook"></a></li>
                                                <li><a href="#" class="linkedin"></a></li>
                                            </ul>
                                        </div>
                                        <div class="one_fifth team-member">
                                            <div class="image-additional-info-wrapper">
                                                <img  src="images/team_04.jpg" alt="team" class="responsive-image"/>
                                                <div class="icon-more-info"><a onClick="unhide(this,'teammember04');">&nbsp;</a></div>
                                                <div id="teammember04" class="responsive-caption hidden"><span class="caption bold-white">Praesent pretium nibh eu nunc conse quat volut pat. Nulla tinci dunt tempus molestie. Fusce ut magna cursust</span></div>
                                            </div>

                                            <div class="name-jobtitle">
                                                <h5>Nick Steiner</h5>
                                                <span class="caption">Senior Designer</span>
                                            </div>
                                            <div class="equal-column-height">
                                                <p> Aliquam hendrerit tincidunt dictum. Pellentesque sit amet nulla purus hendrerit vitae suscipit sed. Sed eget tortor ut.</p>
                                            </div>
                                            <ul class="social-icon">
                                                <li><a href="#" class="email"></a></li>
                                                <li><a href="#" class="twitter"></a></li>
                                                <li><a href="#" class="facebook"></a></li>
                                                <li><a href="#" class="linkedin"></a></li>
                                            </ul>
                                        </div>
                                        <div class="one_fifth lastcols team-member">
                                            <div class="image-additional-info-wrapper">
                                                <img  src="images/team_05.jpg" alt="team" class="responsive-image"/>
                                                <div class="icon-more-info"><a onClick="unhide(this,'teammember05');">&nbsp;</a></div>
                                                <div id="teammember05" class="responsive-caption hidden"><span class="caption bold-white">Praesent pretium nibh eu nunc conse quat volut pat. Nulla tinci dunt tempus molestie. Fusce ut magna cursust</span></div>
                                            </div>

                                            <div class="name-jobtitle">
                                                <h5>Anna Olsen</h5>
                                                <span class="caption">Designer</span>
                                            </div>
                                            <div class="equal-column-height">
                                                <p>Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula pretium eget libero.</p>
                                            </div>
                                            <ul class="social-icon">
                                                <li><a href="#" class="email"></a></li>
                                                <li><a href="#" class="twitter"></a></li>
                                                <li><a href="#" class="facebook"></a></li>
                                                <li><a href="#" class="linkedin"></a></li>
                                            </ul>
                                        </div>
                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End Team-->
                        <!--Start Services-->
                        <li class="nav-item">

                            <a href="#"><h1>Services</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="services" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>Here's what we do</h2>
                                        <div class="one_third firstcols">
                                            <ul>
                                                <li><h4 class="icon-print">Print Design</h4>
                                                    <p>Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula pretium eget libero. Aliquam hendrerit tincidunt dictum. Pellen tesque sit amet nulla purus.  </p>
                                                    <div class="list-container ">
                                                        <ul class="list-expandable grey-line-bottom">
                                                            <li class="active">
                                                                Services
                                                                <ul class="check-list">
                                                                    <li>Imperdiet Orci Tristique</li>
                                                                    <li>Nisi Sem Vitae</li>
                                                                    <li>Vitae Vulputate Ante</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                                <li class="margin-hack-top">
                                                    <h4 class="icon-web">Web Design</h4>
                                                    <p>Sed et eros sit amet elit gravida bibendum in eget lorem. Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque scelerisque vehicula pretium eget libero. Aliquam hendrerit tincidunt.</p>
                                                    <div class="list-container">
                                                        <ul class="list-expandable no-margin">
                                                            <li class="active">
                                                                Services
                                                                <ul class="check-list">
                                                                    <li>Imperdiet Orci Tristique</li>
                                                                    <li>Nisi Sem Vitae</li>
                                                                    <li>Vitae Vulputate Ante</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="one_third ">
                                            <ul>
                                                <li>
                                                    <h4 class="icon-identity">Identity Design</h4>
                                                    <p>Pellentesque sit amet nulla purus. Sed laoreet rutrum iaculis. Pellentesque fringilla nisi sem, vitae vulputate ante. Fusce eget ligula neque, nec congue augue. Etiam at libero imperdiet orci tristique bibendum vitae vel est.</p>
                                                    <div class="list-container">
                                                        <ul class="list-expandable grey-line-bottom">
                                                            <li class="active">
                                                                Services
                                                                <ul class="check-list">
                                                                    <li>Imperdiet Orci Tristique</li>
                                                                    <li>Nisi Sem Vitae</li>
                                                                    <li>Vitae Vulputate Ante</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                                <li class="margin-hack-top">
                                                    <h4 class="icon-tag">Packaging Design</h4>
                                                    <p> Augue fringilla nisi sem, vitae vulputate ante. Fusce eget ligula neque, nec congue augue. Etiam at libero imperdiet orci tristique bibendum vitae vel est. Sed et eros sit amet elit gravida bibendum in eget lorem.</p>
                                                    <div class="list-container">
                                                        <ul class="list-expandable no-margin">
                                                            <li class="active">
                                                                Services
                                                                <ul class="check-list">
                                                                    <li>Imperdiet Orci Tristique</li>
                                                                    <li>Nisi Sem Vitae</li>
                                                                    <li>Vitae Vulputate Ante</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="one_third lastcols">
                                            <ul>
                                                <li>
                                                    <h4 class="icon-leaf">Branding</h4>
                                                    <p>Etiam at libero imperdiet orci tristique bibendum vitae vel est. Sed et eros sit amet elit gravida bibendum in eget lorem. Quisque tellus sem, hendrerit vitae suscipit sed, consequat non dui. Sed eget tortor ut neque.</p>
                                                    <div class="list-container">
                                                        <ul class="list-expandable grey-line-bottom">
                                                            <li class="active">Services
                                                                <ul class="check-list">
                                                                    <li>Research & Analysis</li>
                                                                    <li>Brand Strategy</li>
                                                                    <li>Visual & Verbal Branding</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                                <li class="margin-hack-top"> 
                                                    <h4 class="icon-fast-forward ">3D Animation</h4>
                                                    <p>Aliquam hendrerit tincidunt dictum. Pellentesque sit amet nulla purus. Sed laoreet rutrum iaculis. Pellentesque fringilla nisi sem, vitae vulputate ante. Fusce eget ligula neque, nec congue augue.</p>
                                                    <div class="list-container">
                                                        <ul class="list-expandable no-margin">
                                                            <li class="active">Services
                                                                <ul class="check-list">
                                                                    <li>Imperdiet Orci Tristique</li>
                                                                    <li>Nisi Sem Vitae</li>
                                                                    <li>Vitae Vulputate Ante</li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End Services-->
                        <!--Start News-->
                        <li class="nav-item">
                            <a href="#"><h1>News</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="news" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>Recently Completed Work</h2>
                                        <div class="one_third firstcols">
                                            <ul class="brief">
                                                <li>
                                                    <span class="tag">7/01/2012</span> 
                                                    <h5><a id="news_header1" onClick="javascript:showonlyone('news1');" >
                                                            Convallis Mollis</a></h5>
                                                    <span class="caption">Quam nulla ultrices sem id gravida lectus magna id libero.</span>
                                                </li>
                                                <li>
                                                    <span class="tag">7/16/2012</span> 
                                                    <h5><a id="news_header2" onClick="javascript:showonlyone('news2');" >
                                                            Etiam Fringilla Tellus</a></h5>
                                                    <span class="caption">Aenean velit nunc auctor eget rutrum eget bibendu.</span>
                                                </li>
                                                <li>
                                                    <span class="tag">8/04/2012</span> 
                                                    <h5><a id="news_header3" onClick="javascript:showonlyone('news3');" >
                                                            Blandit Tincidunt</a></h5>
                                                    <span class="caption"> Phasellus in nunc eget tortor interdum tincidunt ornare.</span>
                                                </li>
                                                <li>
                                                    <span class="tag">9/08/2012</span> 
                                                    <h5><a id="news_header4" onClick="javascript:showonlyone('news4');" >
                                                            Porta Massa Quis</a></h5>
                                                    <span class="caption">Quam nulla ultrices sem id gravida lectus magna id libero</span>
                                                </li>
                                            </ul>
                                        </div>

                                        <div class="two_third lastcols">
                                            <div class="news-description" id="news1">
                                                <div class="align-left grey-line-left">
                                                    <a href="?section=portfolio"><img src="images/portfolio/geo_3d_tn.jpg" alt="image" title="image"/></a>
                                                </div>
                                                <div class="align-right news-project-descrip-wrapper">
                                                    <div class="description">
                                                        <h4>Convallis Mollis</h4>
                                                        <p>Sed ullamcorper, orci ut convallis mollis, quam nulla ultrices sem, id gravida lectus magna id libero. Morbi accumsan nulla in quam pharetra non tristique massa suscipit. Praesent viverra tristiquetortor, ut tempus massa mollis ac. Sed eu justo velit, a consectetur erat.</p>
                                                    </div>
                                                    <div class="social-share">
                                                        <ul>
                                                            <li class="icon-fb"><h6>facebook</h6></li>
                                                            <li class="icon-twitter"><h6>twitter</h6></li>
                                                            <li class="icon-share"><h6>share</h6></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--End News Story 1-->
                                            <!--Start News Story 2-->
                                            <div class="news-description" id="news2" style="display:none;" >
                                                <div class="align-left grey-line-left">
                                                    <a href="#portfolio"><img src="images/portfolio/logo_abstract_a_tn.jpg" alt="image"
                                                                              width="222" height="222" title="image" /></a>
                                                </div>
                                                <div class="align-right news-project-descrip-wrapper">
                                                    <div class="description">
                                                        <h4>Etiam Fringilla Tellus</h4>
                                                        <p> Aenean velit nunc, auctor eget rutrum eget, dapibus quis arcu. Nam at rhoncus sem. Nunc sit amet arcu mi. Donec nec lectus est. Proin sollicitudin consectetur nunc placerat pharetra. Cras est odio, lacinia viverra fermentum vehicula, ornare facilisis nisi. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus in nunc eget tortor interdum tincidunt ornare vitae erat. Suspendisse potenti. </p>
                                                    </div>
                                                    <div class="social-share">
                                                        <ul>
                                                            <li class="icon-fb"><h6>facebook</h6></li>
                                                            <li class="icon-twitter"><h6>twitter</h6></li>
                                                            <li class="icon-share"><h6>share</h6></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--End News Story 2-->
                                            <!--Start News Story 3-->
                                            <div class="news-description" id="news3" style="display:none;" >
                                                <div class="align-left grey-line-left">
                                                    <a href="#portfolio"><img src="images/portfolio/logo_abstract_a_tn.jpg" alt="image"
                                                                              width="222" height="222" title="image" /></a>
                                                </div>
                                                <div class="align-right news-project-descrip-wrapper">
                                                    <div class="description">
                                                        <h4>Blandit Tincidunt</h4>
                                                        <p> Donec in dolor velit, et mattis purus. Sed a diam velit. Phasellus tempor est velit. Aenean velit nunc, auctor eget rutrum eget, dapibus quis arcu. Nam at rhoncus sem. Nunc sit amet arcu mi. Donec nec lectus est. Proin sollicitudin consectetur nunc.</p>
                                                    </div>
                                                    <div class="social-share">
                                                        <ul>
                                                            <li class="icon-fb"><h6>facebook</h6></li>
                                                            <li class="icon-twitter"><h6>twitter</h6></li>
                                                            <li class="icon-share"><h6>share</h6></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--End News Story 3-->
                                            <!--Start News Story 4-->
                                            <div class="news-description" id="news4" style="display:none;" >
                                                <div class="align-left grey-line-left">
                                                    <a href="#portfolio"><img src="images/portfolio/logo_abstract_a_tn.jpg" alt="image"
                                                                              width="222" height="222" title="image" /></a>
                                                </div>
                                                <div class="align-right news-project-descrip-wrapper">
                                                    <div class="description">
                                                        <h4>Porta Massa Quis</h4>
                                                        <p> Curabitur et elit augue, eu iaculis urna. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus in nunc eget tortor interdum tincidunt ornare vitae erat. Suspendisse potenti. Aliquam vel enim id ligula lobortis feugiat ut id urna. Nulla facilisi. Etiam rhoncus ipsum sed urna tincidunt pretium. Proin a diam eu ipsum malesuada malesuada nec non sapien. </p>
                                                    </div>
                                                    <div class="social-share">
                                                        <ul>
                                                            <li class="icon-fb"><h6>facebook</h6></li>
                                                            <li class="icon-twitter"><h6>twitter</h6></li>
                                                            <li class="icon-share"><h6>share</h6></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--End News Story 4-->
                                        </div>
                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End News-->
                        <!--Start Contact-->
                        <li class="nav-item">
                            <a href="#"><h1>Contact</h1><span class="st-arrow">Open or Close</span></a>
                            <div id="contact" class="st-content-container">
                                <div class="st-content">
                                    <div class="fill">
                                        <h2>Get in touch with us</h2>
                                        <div class="two_third firstcols">
                                            <p id="contactResponse"></p>
                                            <form method="post" action="#" id="contactform" class="contactform">
                                                <span class="label">Name</span>
                                                <input type="text" id="name" name="name" class="field text" />
                                                <span class="label">Email</span>
                                                <input type="text" id="email" name="email" class="field text" value="" />
                                                <span class="label">Subject</span>
                                                <input type="text" id="subject" name="subject" class="field textbig" value="" />
                                                <span class="label">Message</span>
                                                <textarea rows="25" cols="45" id="comments" name="comments" class="field"></textarea>
                                                <input type="button" onClick="submitContactForm()" id="submitbtn" value="send it" class="field button" />
                                            </form>
                                        </div>
                                        <div class="one_third lastcols">
                                            <h4 class="with-icon">We're Available!</h4>
                                            <p>We are currently taking on new projects. Blandit ut aliquet nisi feugiat. Vivamus consectetur hendrerit libero, vitae cursus odio elementum quis. </p>
                                            <p>Curabitur tellus orci, condimentum non tincidunt nec, condimentum quis dui.</p>
                                            <h4 class="with-icon grey-line-top">Contact Information</h4>
                                            <ul>
                                                <li class="icon-address"><p class="bold">434 Main Street, NY NY</p></li>
                                                <li class="icon-phone"><p class="bold">Phone: +1 888 555 1234</p></li>
                                                <li class="icon-email-small"><p class="bold">Email: info@yoktemplates.com</p></li>
                                                <li class="icon-blog"><p class="bold">Blog: yoktemplates.com</p></li>
                                            </ul>
                                        </div>
                                        <div class="clear-float"></div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!--End Contact-->
                        <!--Start Twitter-->
                        <li class="nav-item">
                            <div id="follow">
                                <div class="follow-me-icon"><span class="follow-me-text">follow us on twitter</span></div>                       
                            </div>
                        </li>
                        <!--End Twitter-->
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>


>>>>>>> 9d627ff772428be16ff92f75085fbfddde391561
