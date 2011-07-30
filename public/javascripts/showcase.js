/* js/jquery script for a simple slideshow using nivo slider */

$(window).ready(function() {
	$("[id$='-images']").nivoSlider({
				slices:10,
		    effect:'fade',
				startSlide:0,
				manualAdvance:true
	    }
		);
});