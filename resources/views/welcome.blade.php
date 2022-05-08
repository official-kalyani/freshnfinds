@extends('layouts.app')
@section('content')
<link rel="stylesheet" href="{{ asset('css/testimonial.css') }}">
<?php $actual_link = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]"; ?>
<div class="hero-banner">
    <div id="sliders" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <?php $banner=0; ?>
            @foreach($sliders as $slider)
                <li data-target="#sliders" data-slide-to="{{$banner++}}" @if($banner == 0) class="active" @endif ></li>
            @endforeach
        </ol>
        <div class="carousel-inner">
            <?php $banner1=0; ?>
            @foreach($sliders as $slider)
            <?php $banner1++; ?>
            <div class="carousel-item @if($banner1 == 1) active @else @endif">
                <img class="d-block w-100" src="{{ URL::to('/') }}/uploads/sliders/{{ @$slider->image }}" alt="First slide">
            </div>
            @endforeach
        </div>
        <a class="carousel-control-prev" href="#sliders" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#sliders" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
<div class="carousel-caption">
<div class="col-md-5 offset-md-7 text-left">
    <div class="banner-content">
        <h1>Fresh vegetables delivered to your door</h1>
    </div>
</div>
</div>

</div>
<div class="category mt-4">
    <div class="container">
        <div class="row">
            <div class="col-12"> 
               <h2 class="h2">Explore Menu</h2>
            </div>
        </div>
        <div class="row">
           @foreach($categories as $category)
                   <div class="col-md-3 col-6 mb-3">
       <div class="c-box text-center">
       <a href="{{url('/')}}/category/{{$category->slug}}">
                            <img src="{{ URL::to('/') }}/uploads/category/{{ @$category->image }}" alt="{{$category->name}}" class="w-100">
                    </a>
                    <div  class="m-2 pb-2">
                            <a href="{{url('/')}}/category/{{$category->slug}}">  {{$category->name}}
                               </a></div>
                        </div>
                    </div>
            @endforeach
        </div>
    </div>
</div>
@foreach($sections as $section)
<div class="sellerslide">
    <div class="container">
        <div class="row">
           <div class="col-12">
            @if($section->type == "Product")
              <?php 
                $products = DB::table('products')
                    ->join('section_items','section_items.product_id','products.id')
                    ->join('product_images','product_images.product_id','products.id')
                    ->where('products.steps_completed',3)
                    ->where('product_images.is_featured',1)
                    ->where('section_items.section_id',$section->id)
                    ->orderBy('section_items.id','asc')
                    ->select('products.*','product_images.images')->get();
              ?>
              
              <h2 class="h2" style="display:inline-block">{{$section->name}}</h2>
              <a href="{{url('/')}}/section/{{$section->id}}" class="btn cart-btn float-right">View All</a>
              <section class="best-seller slider">
                 @foreach($products as $product)
                 <?php 
                    $discountPrice = $product->mrp_price - $product->price;
                    $discountPercentage = ($product->price / $product->mrp_price)*100;
                 ?>
                 <div class="slide"> 
                        <div class="product-box text-center">
                            <div class="p-img">
                                <a style="color: black;" href="{{url('/')}}/products/{{$product->slug}}">
                                <img src="{{ URL::to('/') }}/uploads/product/{{ @$product->images }}" alt="{{$product->name}}" class="w-100"></a>
                            </div>
                            <div class="product-text">
                                <p class="product-name"><a href="{{url('/')}}/products/{{$product->slug}}">{{$product->name}}</a></p>
                                    <p class="product-name">{{$product->weight}}</p>
                                    <div class="price py-3">
                                    <div class="selling_price text-right">
                                        ₹{{@$product->price}}.00
                                    </div>
                                    <div class="mrp_price text-center">
                                        <del>
                                            ₹{{@$product->mrp_price}}.00
                                        </del>
                                    </div>
                                    <div class="percent text-left">
                                        <span >
                                        {{100-round($discountPercentage)}}% off
                                        </span>
                                    </div>
                                    <div class="clearfix"></div> 
                                </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            @guest
                                            <button data-toggle="modal" data-target="#loginModal" class="btn cart-btn a_btn">Buy Now</button>                                
                                            @else
                                            <a href="javascript:void(0);" data-id="{{ $product->id }}" data-title="{{ $product->name }}" data-price="<?php echo @$product->price; ?>" class="btn cart-btn a_btn obBuyNow">Buy Now</a>
                                            @endguest
                                        </div>
                                        <div class="col-md-6">
                                            <a href="javascript:void(0);" data-id="{{ $product->id }}" data-title="{{ $product->name }}" data-price="<?php echo @$product->price; ?>" class="btn cart-btn a_btn obcart">Add To Cart</a>
                                        </div>
                                    </div>
                            </div>
                        </div> 
                    </div>
                 @endforeach
              </section>
            @else 
            <div class="col-md-12">
                <img src="{{ URL::to('/') }}/uploads/offers/{{ @$section->image }}" alt="{{ @$section->name }}" class="w-100">
            </div>
            @endif
        </div>
       </div>
    </div>
  </div>
@endforeach

<?php $testimonials = \App\Models\Testimonial::where('show_in_website_home','yes')->get(); ?>
<?php $testimonial_banner=$testimonial_banner1=0; ?>
<section id="testim" class="testim">
    <div class="wrap">
        <span id="right-arrow" class="arrow right fa fa-chevron-right"></span>
        <span id="left-arrow" class="arrow left fa fa-chevron-left "></span>
        <ul id="testim-dots" class="dots">
            @foreach($testimonials as $testimonial)
            <?php $testimonial_banner1++; ?>
                <li class="dot @if($testimonial_banner1 == 1) active @else @endif"></li>
            @endforeach
        </ul>
        <div id="testim-content" class="cont">
            @foreach($testimonials as $testimonial)
            <?php $testimonial_banner++; ?>
            <div class="@if($testimonial_banner == 1) active @else @endif">
                <div class="img"><img src="{{ URL::to('/') }}/uploads/testimonials/{{ @$testimonial->image }}" alt=""></div>
                <h2>{{$testimonial->title}}</h2>
                <p>{{$testimonial->description}}</p>                   
            </div>
            @endforeach
        </div>
    </div>
    @if(count($testimonials))
    <div class="text-center pb-5">
        <a href="{{url('/')}}/testimonials" class="btn cart-btn">View All Testimonials</a>
    </div>
    @endif
</section>
<script src="https://use.fontawesome.com/1744f3f671.js"></script>
<div class="download-app">
    <div class="container-fluid">
        <div class="col-md-4">
            <h5>Unlock Exclusive Offers</h5>
            <p>For lightning fast ordering experience download the cake app
            </p>
            <div class="row">
                <div class="col-md-6">
                    <a target="_blank" href="https://play.google.com/store/apps/details?id=com.orangebakeryshop"><img src="{{ URL::to('/') }}/images/gplay.png" alt="" class="img-fluid"></a>   
                </div>
                <!-- <div class="col-md-6">
                    <img src="images/appl.png" alt="" class="w-100">
                </div> -->
            </div>
        </div>
    </div>
</div>
<script>
    
'use strict'
var testim = document.getElementById("testim"),
    testimDots = Array.prototype.slice.call(document.getElementById("testim-dots").children),
    testimContent = Array.prototype.slice.call(document.getElementById("testim-content").children),
    testimLeftArrow = document.getElementById("left-arrow"),
    testimRightArrow = document.getElementById("right-arrow"),
    testimSpeed = 4500,
    currentSlide = 0,
    currentActive = 0,
    testimTimer,
        touchStartPos,
        touchEndPos,
        touchPosDiff,
        ignoreTouch = 30;
;

window.onload = function() {

    // Testim Script
    function playSlide(slide) {
        for (var k = 0; k < testimDots.length; k++) {
            testimContent[k].classList.remove("active");
            testimContent[k].classList.remove("inactive");
            testimDots[k].classList.remove("active");
        }

        if (slide < 0) {
            slide = currentSlide = testimContent.length-1;
        }

        if (slide > testimContent.length - 1) {
            slide = currentSlide = 0;
        }

        if (currentActive != currentSlide) {
            testimContent[currentActive].classList.add("inactive");            
        }
        testimContent[slide].classList.add("active");
        testimDots[slide].classList.add("active");

        currentActive = currentSlide;
    
        clearTimeout(testimTimer);
        testimTimer = setTimeout(function() {
            playSlide(currentSlide += 1);
        }, testimSpeed)
    }

    testimLeftArrow.addEventListener("click", function() {
        playSlide(currentSlide -= 1);
    })

    testimRightArrow.addEventListener("click", function() {
        playSlide(currentSlide += 1);
    })    

    for (var l = 0; l < testimDots.length; l++) {
        testimDots[l].addEventListener("click", function() {
            playSlide(currentSlide = testimDots.indexOf(this));
        })
    }

    playSlide(currentSlide);

    // keyboard shortcuts
    document.addEventListener("keyup", function(e) {
        switch (e.keyCode) {
            case 37:
                testimLeftArrow.click();
                break;
                
            case 39:
                testimRightArrow.click();
                break;

            case 39:
                testimRightArrow.click();
                break;

            default:
                break;
        }
    })
        
        testim.addEventListener("touchstart", function(e) {
                touchStartPos = e.changedTouches[0].clientX;
        })
    
        testim.addEventListener("touchend", function(e) {
                touchEndPos = e.changedTouches[0].clientX;
            
                touchPosDiff = touchStartPos - touchEndPos;
            
                console.log(touchPosDiff);
                console.log(touchStartPos); 
                console.log(touchEndPos);   

            
                if (touchPosDiff > 0 + ignoreTouch) {
                        testimLeftArrow.click();
                } else if (touchPosDiff < 0 - ignoreTouch) {
                        testimRightArrow.click();
                } else {
                    return;
                }
            
        })
}
</script>
@endsection