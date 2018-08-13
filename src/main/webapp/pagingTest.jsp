<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <meta name="csrf-param" content="authenticity_token" />
<meta name="csrf-token" content="9fiDYsKwG1z/+w1AGQMIMrK7Um7HCEnUze7XQeilNE91vhMXTrOAHoPUrl5GSKNNtp/njXQ2r4Kee6Qk2n2wzg==" />
  
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.js"
	integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
	crossorigin="anonymous">
	
</script>

<script>
//-------------------------------------//
// init Masonry

var $grid = $('.grid').masonry({
  itemSelector: 'none', // select none at first
  columnWidth: '.grid__col-sizer',
  gutter: '.grid__gutter-sizer',
  percentPosition: true,
  stagger: 30,
  // nicer reveal transition
  visibleStyle: { transform: 'translateY(0)', opacity: 1 },
  hiddenStyle: { transform: 'translateY(100px)', opacity: 0 },
});

// get Masonry instance
var msnry = $grid.data('masonry');

// initial items reveal
$grid.imagesLoaded( function() {
  $grid.removeClass('are-images-unloaded');
  $grid.masonry( 'option', { itemSelector: '.grid__item' });
  var $items = $grid.find('.grid__item');
  $grid.masonry( 'appended', $items );
});

var itemClasses =[
  'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height3',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item',
'grid__item grid__item--height1',
'grid__item grid__item--height3',
'grid__item grid__item--height1',
'grid__item grid__item--height3',
'grid__item grid__item--height1',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height3',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height1',
'grid__item grid__item--height3',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height3',
'grid__item',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height1',
'grid__item grid__item--height3',
'grid__item grid__item--height3',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height1',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height1',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item grid__item--height1',
'grid__item grid__item--height1',
'grid__item grid__item--height3',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height1',
'grid__item grid__item--height3',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height3',
'grid__item grid__item--height2',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
'grid__item grid__item--height2',
'grid__item grid__item--height1',
'grid__item grid__item--height3',
'grid__item grid__item--height3',
'grid__item grid__item--height1',
'grid__item grid__item--height2',
]

//-------------------------------------//
// init Infinte Scroll

$grid.infiniteScroll({
  path: 'page{{#}}', // hack
  loadOnScroll: false, // disable loading
  history: false,
});

$grid.on( 'scrollThreshold.infiniteScroll', function() {
  // add grid items
  var pageItemClasses = itemClasses.splice( 0, 15 );
  if ( !pageItemClasses.length ) {
    return;
  }
  var itemsHTML = pageItemClasses.map( function( itemClass ) {
    return '<div class="' + itemClass + '"></div>';
  });
  var $items = $( itemsHTML.join('') );
  // add $items to masonry
  $items.imagesLoaded( function() {
    $grid.append( $items );
    $grid.masonry( 'appended', $items );
  });
});

</script>
</head>
<style>
body {
  font-family: sans-serif;
  line-height: 1.4;
  font-size: 18px;
  padding: 20px;
  max-width: 640px;
  margin: 0 auto;
}

.grid {
  max-width: 1200px;
}

/* reveal grid after images loaded */
.grid.are-images-unloaded {
  opacity: 0;
}

.grid__item,
.grid__col-sizer {
  width: 32%;
}

.grid__gutter-sizer { width: 2%; }

/* hide by default */
.grid.are-images-unloaded .image-grid__item {
  opacity: 0;
}

.grid__item {
  margin-bottom: 20px;
  float: left;
}

.grid__item--height1 { height: 140px; background: #EA0; }
.grid__item--height2 { height: 220px; background: #C25; }
.grid__item--height3 { height: 300px; background: #19F; }

.grid__item--width2 { width: 66%; }

.grid__item img {
  display: block;
  max-width: 100%;
}


.page-load-status {
  display: none; /* hidden by default */
  padding-top: 20px;
  border-top: 1px solid #DDD;
  text-align: center;
  color: #777;
}

/* loader ellips in separate pen CSS */

</style>
<body>
<h1>Infinite Scroll - scrollThreshold add</h1>

<div class="grid are-images-unloaded">
  <div class="grid__col-sizer"></div>
  <div class="grid__gutter-sizer"></div>
  <div class="grid__item grid__item--height2"></div>
  <div class="grid__item grid__item--width2">
    <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/82/orange-tree.jpg" alt="orange tree" />
  </div>
  <div class="grid__item grid__item--height3"></div>
  <div class="grid__item grid__item--height1"></div>
  <div class="grid__item grid__item--height2"></div>
  <div class="grid__item">
    <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/82/look-out.jpg" alt="look out" />
  </div>

  <div class="grid__item grid__item--height1"></div>
  <div class="grid__item grid__item--height3"></div>
  <div class="grid__item grid__item--height1"></div>
  <div class="grid__item grid__item--height3"></div>
  <div class="grid__item grid__item--height1"></div>
  <div class="grid__item grid__item--height1"></div>
  <div class="grid__item grid__item--width2">
    <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/82/raspberries.jpg" alt="rasberries" />
  </div>
  <div class="grid__item grid__item--height2"></div>
  <div class="grid__item grid__item--height2"></div>
  <div class="grid__item grid__item--height3"></div>
  <div class="grid__item grid__item--height1"></div>
  <div class="grid__item grid__item--height2"></div>
</div>



</body>
</html>