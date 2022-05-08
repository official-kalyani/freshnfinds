<?php 
if (Auth::check()) {
    $user = Auth::user();
    $plusCoins = \App\Models\Cbcoin::where('user_id',$user->id)->where('type','PLUS')->where('status',1)->get();
    $minusCoins = \App\Models\Cbcoin::where('user_id',$user->id)->where('type','MINUS')->where('status',3)->get();
    if (count($minusCoins) > 0) {
        foreach ($minusCoins as $minusCoin) {
            $totalMinusCoin[] = $minusCoin->coins;
        }
        $minuscoin = array_sum($totalMinusCoin);
    }
    else{
        $minuscoin = 0;
    }
    foreach ($plusCoins as $plusCoin) {
        $totalPlusCoin[] = $plusCoin->coins;
    }
    $coins = array_sum($totalPlusCoin) - $minuscoin;
}       
?>

<div id="maincart">
<div class="row">
    <?php $total = 0; $shippingCharge = DELIVERY_CHARGE; ?> 
    @if(session('cart'))
    <div class="col-sm-8">
     <?php 
        // echo "<pre>";
        // print_r(session('cart'));
        // exit();
     ?>
        <div class="card">
            <div class="card-body">
                @foreach((array) session('cart') as $id => $details)
                <div class="row b-border">
                    <?php
                    $product =  \App\Models\Product::where('id',$id)->first();	                    
                    $product_image = \App\Models\ProductImage::where('product_id',$product->id)->where('is_featured',1)->first();

                      $product->description = preg_replace("/^<p.*?>/", "",$product->description);
                      $product->description = preg_replace("|</p>$|", "",$product->description);
                      $total += @$product->price * $details['quantity'];
                    ?>
                    <div class="col-xs-2 col-md-3">
                      <img class="w-100" src="{{ URL::to('/') }}/uploads/product/{{ @$product_image->images }}" alt="{{ $product->name }}">
                    </div>
                    <div class="col-xs-4 col-md-4 mt-5 col-sm-6 col-6">
                        <h6 class="product-name"><strong>{{ $product->name }} </strong> {{$product->price}}.00 INR</h6>
                    </div>
                    <div class="col-xs-6 col-md-2 mt-5 col-sm-6 col-6">
                        <button class="minus_cart<?php echo $details['id']; ?>" type="button">
                            <i class="fa fa-minus">&nbsp;</i>
                        </button>
                        <div class="cq">{{ $details['quantity'] }}</div>
                        <button class="plus_cart<?php echo $details['id']; ?>" type="button">
                            <i class="fa fa-plus">&nbsp;</i>
                        </button>
                    </div>
                    <input type="hidden" class="session_id{{$details['id']}}" value="{{ $details['id'] }}"> 
                    <input type="hidden" class="count_cart{{$details['id']}} update-cart-quantity" name="qty" value="{{ $details['quantity'] }}">
                    <input type="hidden" class="price{{$details['id']}}" value="{{ $details['price'] }}"> 
                    <div class="col-xs-6 col-md-3 col-sm-6 col-6">
                      <div class="qty mt-5">
                          <h5 class="subTotal<?php echo $details['id']; ?>">
                            &#8377;{{ $product->price * $details['quantity'] }}.00 INR
                          </h5>
                        </div>
                    </div>
                    <hr>
                     <script type="text/javascript">
                        $(".plus_cart<?php echo $details['id']; ?>").click(function (e) {
                            e.preventDefault();
                            var quantity = parseInt($('.count_cart<?php echo $details['id']; ?>').val());
                            var id = parseInt($('.session_id<?php echo $details['id']; ?>').val());
                            var price = $('.price<?php echo $details['id']; ?>').val();
                            
                            if (quantity>=1) {
                                $(this).attr('disabled', true);
                                $('.count_cart<?php echo $details['id']; ?>').val(quantity+1);
                                var quantity = quantity+1;
                                $.ajax({
                                    url: '{{ url('update-cart') }}',
                                    method: "PATCH",
                                    data: {_token: '{{ csrf_token() }}', id: id, quantity: quantity,price:price},
                                    dataType: "json",
                                    success: function (response) {                                        
                                        $("#refresh-sidebar-cart").html(response.data);
                                        $('#maincart').html(response.maincart);
                                        $("#cartCounter").html(response.cartCounter);
                                        $(this).attr('disabled', false);
                                        $(".sidebar_cartCounter").html(response.cartCounter);
                                        var total_price_text = parseInt($('#shipping_charge').val())+parseInt($('#init_payable_price_static').val());
                                        $('#total_price_text').html('&#8377;'+total_price_text+'.00');
                                    }
                                });
                            }
                        });
                        $(".minus_cart<?php echo $details['id']; ?>").click(function (e) {
                            e.preventDefault();
                            var quantity = parseInt($('.count_cart<?php echo $details['id']; ?>').val());
                            var id = parseInt($('.session_id<?php echo $details['id']; ?>').val());
                            var price = parseInt($('.price<?php echo $details['id']; ?>').val());

                            if (quantity>1) {
                                $(this).attr('disabled', true);
                                $('.count_cart<?php echo $details['id']; ?>').val(quantity-1);
                                var quantity = quantity-1;
                                $.ajax({
                                    url: '{{ url('update-cart') }}',
                                    method: "PATCH",
                                    data: {_token: '{{ csrf_token() }}', id: id, quantity: quantity,price:price},
                                    dataType: "json",
                                    success: function (response) {
                                        
                                        $("#refresh-sidebar-cart").html(response.data);
                                        $('#maincart').html(response.maincart);
                                        $("#cartCounter").html(response.cartCounter);
                                        $(".sidebar_cartCounter").html(response.cartCounter);
                                        $(this).attr('disabled', false);
                                        var total_price_text = parseInt($('#shipping_charge').val())+parseInt($('#init_payable_price_static').val());
                                        $('#total_price_text').html('&#8377;'+total_price_text+'.00');
                                    }
                                });
                            }
                            else{
                                $(this).attr('disabled', true);
                                $.ajax({
                                    url: '{{ url('remove-from-cart') }}',
                                    method: "DELETE",
                                    data: {_token: '{{ csrf_token() }}', id: id},
                                    dataType: "json",
                                    success: function (response) {
                                        $("#refresh-sidebar-cart").html(response.data);
                                        $('#maincart').html(response.maincart);
                                        cartWrapper.addClass('cart-open');
                                        $("#cartCounter").html(response.cartCounter);
                                        $(this).attr('disabled', false);
                                        var total_price_text = parseInt($('#shipping_charge').val())+parseInt($('#init_payable_price_static').val());
                                        $('#total_price_text').html('&#8377;'+total_price_text+'.00');
                                        $(".sidebar_cartCounter").html(response.cartCounter);
                                    }
                                });
                            }
                        });
                    </script>
                    <style>
                        .minus_cart<?php echo $details['id']; ?>,.plus_cart<?php echo $details['id']; ?> {
                            background-color: #fff;
                            border: none;
                            color: #999;
                            border-radius: 100px;
                            font-size: 12px;
                            line-height: 0px;
                            height: 30px;
                            width: 30px;
                            outline: none;
                            float: left;
                        }
                    </style>
                </div>
                @endforeach
                <div class="col-md-12 text-center">
                    @guest
                    <button data-toggle="modal" data-target="#loginModal" class="btn cart-btn a_btn">Continue To Checkout</button>                                
                    @else
                    <a href="{{ url('/checkout') }}" class="btn btn-warning">Continue To Checkout <i class="fa fa-angle-right"></i></a>
                    @endguest
                    
                </div>
            </div>
        </div>
    </div>
    
    @else
    <a href="{{ url('/') }}" class="btn btn-warning"><i class="fa fa-angle-left"></i> Continue Shopping</a>
    @endif
</div>
</div>

