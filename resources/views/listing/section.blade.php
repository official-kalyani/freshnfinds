@extends('layouts.app')
@section('content')
<?php $actual_link = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]"; ?>
<div class="innerpage-banner">
    <img src="{{ URL::to('/') }}/images/iner-bnr1.jpg" alt="" class="w-100">
    <div class="breadcrum">
        <div class="container">
            <h2>{{$section->name}}</h2>
            <ul>
                <li>Home  >></li>
                <li><a href="{{url('/bestseller')}}">{{$section->name}}</a> </li>
            </ul>
        </div>
    </div> 
</div>
<div class="sellerslide" style="padding-top: 100px; padding-bottom: 100px;">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
            <div class="row">
                @if(count($products))
                    <?php  
                      foreach($products as $product){
                        $discountPrice = $product->mrp_price - $product->price;
                        $discountPercentage = ($product->price / $product->mrp_price)*100; 
                       ?>                    
                        <div class="col-md-3">
                            <div class="product-box text-center mb-3">
                                <div class="p-img">
                                    <a style="color: black;" href="{{url('/')}}/products/{{$product->slug}}"><img src="{{ URL::to('/') }}/uploads/product/{{ @$product->images }}" alt="{{$product->name}}" class="w-100"></a>
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
            </div>

                    {{$products->links()}}
                @endif
            </div>
        </div>
    </div>
</div>

@endsection