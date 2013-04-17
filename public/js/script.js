/*
* Quicksand + PrettyPhoto: Reorder and filter items, Initialize PrettyPhoto Plugin
* 
*/

function initPrettyPhoto(){
    // Initialize prettyPhoto plugin
    $(".portfolio a[data-gal^='prettyPhoto']").prettyPhoto({
        theme:'light_square', 
        autoplay_slideshow: false, 
        overlay_gallery: false, 
        show_title: false
    });
}

$(document).ready(function(){

    //Thumbnail mouse over
    $(".portfolio a").hover( function(){ 
        $(this).children("img").animate({
            opacity: 0.25
        }, "fast"); 
    }, function(){ 
        $(this).children("img").animate({
            opacity: 1.0
        }, "slow"); 
    }); 

    //set bg color for odd checklist items
    $('ul.check-list li:odd').css('background-color','#DBDBDB');
    
    //Initialize pretty photo
    initPrettyPhoto();

    // Clone portfolio items 
    var $data = $(".portfolio").clone();
	
    // Attempt to call Quicksand on every click event handler
    $(".filter a").click(function(e){
		
        $(".filter li").removeClass("current");	
		
        // Get the class attribute value of the clicked link
        var $filterClass = $(this).parent().attr("class");

        if ( $filterClass == "all" ) {
            var $filteredPortfolio = $data.find("li");
        } else {
            var $filteredPortfolio = $data.find("li[data-type~=" + $filterClass + "]");
        }
		
        // Call quicksand
        $(".portfolio").quicksand( $filteredPortfolio, { 
            duration: 800,
            easing: 'easeInOutQuad' 
        }, function(){
            initPrettyPhoto();
	
        });


        $(this).parent().addClass("current");

        // Prevent the browser jump to the link anchor
        e.preventDefault();
    })
});