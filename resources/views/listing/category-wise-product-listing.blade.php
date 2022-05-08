@extends('layouts.app')
@section('content')
<?php 
$actual_link = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
$type = Request::cookie('type');
$store_id = Request::cookie('store_id');
?>
@if(count($sliders))
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
                <img class="d-block w-100" src="{{ URL::to('/') }}/uploads/category/{{ @$slider->image }}" alt="First slide">
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
@else
<div class="hero-banner">
    <img class="d-block w-100" src="{{ URL::to('/') }}/images/iner-bnr1.jpg" alt="First slide">
</div>

@endif




<div class="container">
    <h2 class="h2">{{$category->name}}</h2>
    <span id="status"></span>
    @if(count($products) > 0)
     <div class="row">
        @foreach($products as $product)
            <?php
           
                $discountPrice = $product->mrp_price - $product->price;
                $discountPercentage = ($product->price / $product->mrp_price)*100;
            ?>
             <div class="col-md-3">
                <div class="product-box text-center mb-3">
                    <div class="p-img">
                        <a style="color: black;" href="{{url('/')}}/products/{{$product->slug}}"><img src="{{ URL::to('/') }}/uploads/product/{{ @$product->images }}" alt="" class="w-100"></a>
                    </div>
                    <div class="product-text">
                        <p class="product-name"><a href="{{url('/')}}/products/{{$product->slug}}">{{$product->name}}</a></p>
                         <div class="price py-3">
                            
                            <div class="text-center">
                                <span>
                                   {{@$product->weight}}
                                </spn>
                            </div>
                           
                            <div class="clearfix"></div> 
                        </div>
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
    </div>
    @else
    <div class="row">
        <div class="col-md-12">
            <h4 class="text-center" style="padding-top: 20px; padding-bottom: 20px;">No {{$category->name}} Found</h4>
        </div>
    </div>
    @endif
    <div class="text-center py-3">
        {{$products->links()}}
    </div>
</div>


@endsection
