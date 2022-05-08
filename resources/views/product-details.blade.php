@extends('layouts.app')
@section('content')
<?php 
    $product->description = preg_replace("/^<p.*?>/", "",$product->description);
    $product->description = preg_replace("|</p>$|", "",$product->description);
    $actual_link = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
?>
<div class="innerpage-banner">
    <img src="{{ URL::to('/') }}/images/iner-bnr1.jpg" alt="" class="w-100">
    <div class="breadcrum">
        <div class="container">
            <h2>Product Details</h2>
            <ul>
                <li>Home  >></li>
                <li><a href="#">Product Details</a> </li>
            </ul>
        </div>
    </div>
</div>
<div class="product-details-info mt-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12">
            <script type="text/javascript" src="https://res.cloudinary.com/dxfq3iotg/raw/upload/v1565190285/Scripts/xzoom.min.js"></script>
            <link rel="stylesheet" type="text/css" href="https://res.cloudinary.com/dxfq3iotg/raw/upload/v1565190284/Scripts/xzoom.css" media="all" />
                
            <div class="container d-flex justify-content-center">
            <section id="default" class="padding-top0">

                <div class="row">
                    <div class="large-5 column">
                        <div class="xzoom-container"> 
                            <img class="xzoom" id="xzoom-default" src="{{ URL::to('/') }}/uploads/product/{{ @$product_first_images->images }}" xoriginal="{{ URL::to('/') }}/uploads/product/{{ @$product_first_images->images }}" />
                            <div class="xzoom-thumbs">
                            <br><br> 
                                @foreach($product_images as $row)
                                    <a href="{{ URL::to('/') }}/uploads/product/{{ @$row->images }}"><img class="xzoom-gallery" width="80" src="{{ URL::to('/') }}/uploads/product/{{ @$row->images }}" xpreview="{{ URL::to('/') }}/uploads/product/{{ @$row->images }}"></a>
                                @endforeach
                            </div>
                        </div>
                    </div>
                    <p style="font-style:italic; font-weight:bold;"><span style="color:red;">*</span>The image shown above is for reference purpose only. The actual product may vary.</p>
                </div>
                
            </section>
        </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-12">
                <div class="detcont">
                    <h3>{{$product->name}}</h3>                                        
                    
                     <div class="product_meta">
                        <p>{{@$product->weight}}</p>
                    </div>
                    <hr>
                    <div class="product_meta">
                        <span class="enon_wrapper">{{@$product->cat_name}}</span>
                    </div>
                    <hr/>
                   
                    <div class="row">
                        <div class="col-md-6">
                            <p class="price">
                                <del><span class="amount">
                                    <span id="var_mrp_price"> &#8377;{{@$product->mrp_price}}.00</span>
                                </del>                            
                                <ins><span class="amount">
                                    <span id="var_price">&#8377;{{@$product->price}}.00</span>
                                </ins>
                            </p>
                        </div>
                        <!-- <div class="col-md-12" style="margin-top:5px; font-style:italic;font-weight:bold;">
                          <label>Please order before 12PM for today delivery</label>
                        </div> -->
                    </div>
                    <hr>
                    <div class="shares">
                        <ul class="socialul">
                            <li><a href="https://www.facebook.com/sharer/sharer.php?u={{$actual_link}}"><i class="fab fa-facebook-square"></i></a></li>
                            <li><a href="https://twitter.com/home?status={{$actual_link}}"><i class="fab fa-twitter-square"></i></a></li>
                            <li><a href="https://www.linkedin.com/shareArticle?mini=true&url={{$actual_link}}/&title=&summary=&source="><i class="fab fa-linkedin"></i></a></li>
                            <li><a href="https://pinterest.com/pin/create/button/?url={{$actual_link}}/&media=&description="><i class="fab fa-pinterest-square"></i></a></li>
                        </ul>
                    </div>
                    <hr>
                    <div class="description">
                        <h5>Description</h5>
                        <p>{{@$product->description}}</p>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="container">
            <div class="row1">
                <div class="col-12">
                    <h2 class="h2">Related Products</h2>
                    <section class="best-seller slider">
                        <?php foreach($relatedProducts as $product) { 
                            $discountPrice = $product->mrp_price - $product->price;
                            $discountPercentage = ($product->price / $product->mrp_price)*100;
                            ?>
                            <div class="slide"> 
                                <div class="product-box text-center">
                                    <div class="p-img">
                                        <a style="color: black;" href="{{url('/')}}/products/{{$product->slug}}"><img src="{{ URL::to('/') }}/uploads/product/{{ @$product->images }}" alt="" class="w-100"></a>
                                    </div>
                                    <div class="product-text">
                                        <p class="product-name"><a href="{{url('/')}}/products/{{$product->slug}}">{{$product->name}}</a></p>
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
                        <?php } ?>
                    </section>
                </div>
            </div>
        </div>
</div>


<script>


    $(function () {
        $(".add-to-cart").click(function (e) {
            e.preventDefault();
            var id = $(this).data('id');
            var message = $('#message').val();
            var ele = $(this);
            var price = $('#price').val();
            var title = $(this).data('title');
            $.ajax({
                url: '{{ url('add-to-cart') }}' + '/' + ele.attr("data-id"),
                method: "get",
                data: {_token: '{{ csrf_token() }}', "price": price, "message": message},
                dataType: "json",
                success: function (response) {

                    ele.siblings('.btn-loading').hide();
                    Swal.fire(
                            'Added!',
                            title + ' Added to Cart',
                            'success'
                            )
                    $("#cartCounter").html(response.cartCounter);
                    $("#refresh-sidebar-cart").html(response.data);
                    $(".sidebar_cartCounter").html(response.cartCounter);
                }
            });
        });


        $('.xzoom, .xzoom-gallery').xzoom({zoomWidth: 400, title: true, tint: '#333', Xoffset: 15});
        $('.xzoom2, .xzoom-gallery2').xzoom({position: '#xzoom2-id', tint: '#ffa200'});
        $('.xzoom3, .xzoom-gallery3').xzoom({position: 'lens', lensShape: 'circle', sourceClass: 'xzoom-hidden'});
        $('.xzoom4, .xzoom-gallery4').xzoom({tint: '#006699', Xoffset: 15});
        $('.xzoom5, .xzoom-gallery5').xzoom({tint: '#006699', Xoffset: 15});

        //Integration with hammer.js
        var isTouchSupported = 'ontouchstart' in window;

        if (isTouchSupported) {
            //If touch device
            $('.xzoom, .xzoom2, .xzoom3, .xzoom4, .xzoom5').each(function () {
                var xzoom = $(this).data('xzoom');
                xzoom.eventunbind();
            });

            $('.xzoom, .xzoom2, .xzoom3').each(function () {
                var xzoom = $(this).data('xzoom');
                $(this).hammer().on("tap", function (event) {
                    event.pageX = event.gesture.center.pageX;
                    event.pageY = event.gesture.center.pageY;
                    var s = 1, ls;

                    xzoom.eventmove = function (element) {
                        element.hammer().on('drag', function (event) {
                            event.pageX = event.gesture.center.pageX;
                            event.pageY = event.gesture.center.pageY;
                            xzoom.movezoom(event);
                            event.gesture.preventDefault();
                        });
                    }

                    xzoom.eventleave = function (element) {
                        element.hammer().on('tap', function (event) {
                            xzoom.closezoom();
                        });
                    }
                    xzoom.openzoom(event);
                });
            });

            $('.xzoom4').each(function () {
                var xzoom = $(this).data('xzoom');
                $(this).hammer().on("tap", function (event) {
                    event.pageX = event.gesture.center.pageX;
                    event.pageY = event.gesture.center.pageY;
                    var s = 1, ls;

                    xzoom.eventmove = function (element) {
                        element.hammer().on('drag', function (event) {
                            event.pageX = event.gesture.center.pageX;
                            event.pageY = event.gesture.center.pageY;
                            xzoom.movezoom(event);
                            event.gesture.preventDefault();
                        });
                    }

                    var counter = 0;
                    xzoom.eventclick = function (element) {
                        element.hammer().on('tap', function () {
                            counter++;
                            if (counter == 1)
                                setTimeout(openfancy, 300);
                            event.gesture.preventDefault();
                        });
                    }

                    function openfancy() {
                        if (counter == 2) {
                            xzoom.closezoom();
                            $.fancybox.open(xzoom.gallery().cgallery);
                        } else {
                            xzoom.closezoom();
                        }
                        counter = 0;
                    }
                    xzoom.openzoom(event);
                });
            });

            $('.xzoom5').each(function () {
                var xzoom = $(this).data('xzoom');
                $(this).hammer().on("tap", function (event) {
                    event.pageX = event.gesture.center.pageX;
                    event.pageY = event.gesture.center.pageY;
                    var s = 1, ls;

                    xzoom.eventmove = function (element) {
                        element.hammer().on('drag', function (event) {
                            event.pageX = event.gesture.center.pageX;
                            event.pageY = event.gesture.center.pageY;
                            xzoom.movezoom(event);
                            event.gesture.preventDefault();
                        });
                    }

                    var counter = 0;
                    xzoom.eventclick = function (element) {
                        element.hammer().on('tap', function () {
                            counter++;
                            if (counter == 1)
                                setTimeout(openmagnific, 300);
                            event.gesture.preventDefault();
                        });
                    }

                    function openmagnific() {
                        if (counter == 2) {
                            xzoom.closezoom();
                            var gallery = xzoom.gallery().cgallery;
                            var i, images = new Array();
                            for (i in gallery) {
                                images[i] = {src: gallery[i]};
                            }
                            $.magnificPopup.open({items: images, type: 'image', gallery: {enabled: true}});
                        } else {
                            xzoom.closezoom();
                        }
                        counter = 0;
                    }
                    xzoom.openzoom(event);
                });
            });

        } else {
            //If not touch device

            //Integration with fancybox plugin
            $('#xzoom-fancy').bind('click', function (event) {
                var xzoom = $(this).data('xzoom');
                xzoom.closezoom();
                $.fancybox.open(xzoom.gallery().cgallery, {padding: 0, helpers: {overlay: {locked: false}}});
                event.preventDefault();
            });

            //Integration with magnific popup plugin
            $('#xzoom-magnific').bind('click', function (event) {
                var xzoom = $(this).data('xzoom');
                xzoom.closezoom();
                var gallery = xzoom.gallery().cgallery;
                var i, images = new Array();
                for (i in gallery) {
                    images[i] = {src: gallery[i]};
                }
                $.magnificPopup.open({items: images, type: 'image', gallery: {enabled: true}});
                event.preventDefault();
            });
        }
    });

</script>
@endsection