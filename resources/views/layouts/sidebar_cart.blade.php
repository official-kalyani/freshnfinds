<div id="refresh-sidebar-cart">
<div class="cd-cart-container">
	<a href="#0" class="cd-cart-trigger">
		<ul class="count"> 
			<li class="sidebar_cartCounter">{{ count((array) session('cart')) }}</li>
			<li>0</li>
		</ul>
	</a>

	<div class="cd-cart">
		<div class="wrapper">
			<div class="body">
			<ul>
				<li class="product">
				@if(session('cart'))
			        <?php $total = 0; ?>
			        @foreach((array) session('cart') as $id => $details)
			        <?php
                       $product =  \App\Models\Product::where('id',$id)->first();           
                       $product_image = \App\Models\ProductImage::where('product_id',$product->id)->where('is_featured',1)->first();
			           $total += $product->price * $details['quantity']
			        ?>
                    <div class="product-image">
                        <img class="w-100" src="{{ URL::to('/') }}/uploads/product/{{ @$product_image->images }}" alt="{{ $product->name }}">
                    </div>
                    <div class="product-details"><h3><a href="#0">{{ $product->name }}</a></h3><span class="price">&#8377; {{ $product->price }}.00</span><div class="actions">
                        <div class="quantity">
                        <div class="quantity-cart">
                 	    <button class="minus<?php echo $details['id']; ?>" type="button">
                                <i class="fa fa-minus">&nbsp;</i>
                                <input type="hidden" class="session_id{{$details['id']}}" value="{{ $details['id'] }}"> 
                            </button>
                            <input type="hidden" class="count{{$details['id']}} update-cart-quantity qty" name="qty" value="{{ $details['quantity'] }}">
                           	<div class="cq">{{ $details['quantity'] }}</div>
                                <button class="plus<?php echo $details['id']; ?>" type="button">
                                    <i class="fa fa-plus">&nbsp;</i>
                                <input type="hidden" class="price{{$details['id']}}" value="{{ $details['price'] }}"> 
                                </button> 
                            </div>
                        </div>
                        </div>
                    </div>
                    <script type="text/javascript">
                    	$(".plus<?php echo $details['id']; ?>").click(function (e) {
			                e.preventDefault();
			                var quantity = parseInt($('.count<?php echo $details['id']; ?>').val());
			                var id = parseInt($('.session_id<?php echo $details['id']; ?>').val());
			                var price = parseInt($('.price<?php echo $details['id']; ?>').val());
							
			                if (quantity>=1) {
			                    $(this).attr('disabled', true);
			                    $('.count<?php echo $details['id']; ?>').val(quantity+1);
			                    var quantity = quantity+1;
			                    $.ajax({
			                        url: '{{ url('update-cart') }}',
			                        method: "PATCH",
			                        data: {_token: '{{ csrf_token() }}', id: id, quantity: quantity,price:price},
			                        dataType: "json",
			                        success: function (response) {
			                            
			                            $("#refresh-sidebar-cart").html(response.data);
			                            var cartWrapper = $('.cd-cart-container');
			                            cartWrapper.addClass('cart-open');
			                            $("#cartCounter").html(response.cartCounter);
			                            $(this).attr('disabled', false);
			                            $(".sidebar_cartCounter").html(response.cartCounter);
			                        }
			                    });
			                }
			            });
			            $(".minus<?php echo $details['id']; ?>").click(function (e) {
			                e.preventDefault();
			                var quantity = parseInt($('.count<?php echo $details['id']; ?>').val());
			                var id = parseInt($('.session_id<?php echo $details['id']; ?>').val());
			                var price = parseInt($('.price<?php echo $details['id']; ?>').val());

			                if (quantity>1) {
			                    $(this).attr('disabled', true);
			                    $('.count<?php echo $details['id']; ?>').val(quantity-1);
			                    var quantity = quantity-1;
			                    $.ajax({
			                        url: '{{ url('update-cart') }}',
			                        method: "PATCH",
			                        data: {_token: '{{ csrf_token() }}', id: id, quantity: quantity,price:price},
			                        dataType: "json",
			                        success: function (response) {
			                            
			                            $("#refresh-sidebar-cart").html(response.data);
			                            var cartWrapper = $('.cd-cart-container');
			                            cartWrapper.addClass('cart-open');
			                            $("#cartCounter").html(response.cartCounter);
			                            $(".sidebar_cartCounter").html(response.cartCounter);
			                            $(this).attr('disabled', false);
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
			                            var cartWrapper = $('.cd-cart-container');
			                            cartWrapper.addClass('cart-open');
			                            $("#cartCounter").html(response.cartCounter);
			                            $(this).attr('disabled', false);
			                            $(".sidebar_cartCounter").html(response.cartCounter);
			                        }
			                    });
			                }
			            });
                    </script>
                    <style>
                    	.cd-cart .minus<?php echo $details['id']; ?>, .cd-cart .plus<?php echo $details['id']; ?> {
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
                    <div class="clearfix py-1"></div>
                    @endforeach
                    @else
                     <img style="width: 100%;" class="img-responsive" src="{{url('/images/cart-empty.png')}}">
                    @endif
                    
                </li>
			</ul>
			</div>

			<footer>
				<a href="{{url('/cart')}}" class="checkout btn"><em>Checkout - &#8377;<span id="totalPrice">@if(session('cart'))<?php echo @$total; ?>.00 @else 0 @endif</span></em></a>
			</footer>
		</div>
	</div> <!-- .cd-cart -->
</div> <!-- cd-cart-container -->
<script type="text/javascript">
	jQuery(document).ready(function($){
	var cartWrapper = $('.cd-cart-container');
	var productId = 0;

	if( cartWrapper.length > 0 ) {
		//store jQuery objects
		var cartTrigger = cartWrapper.children('.cd-cart-trigger');
		//open/close cart
		cartTrigger.on('click', function(event){
			event.preventDefault();
			toggleCart();
		});
	}

	function toggleCart(bool) {
		var cartIsOpen = ( typeof bool === 'undefined' ) ? cartWrapper.hasClass('cart-open') : bool;
		
		if( cartIsOpen ) {
			cartWrapper.removeClass('cart-open');
		} else {
			cartWrapper.addClass('cart-open');
			//$('.cart-open .cd-cart .checkout em').css('font-size: 17px !important;');
		}
	}
});
</script>
</div>