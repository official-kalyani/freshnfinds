@extends('layouts.app')
@section('content')
<div class="innerpage-banner">
    <img src="{{ URL::to('/') }}/images/iner-bnr1.jpg" alt="" class="w-100">
    <div class="breadcrum">
        <div class="container">
            <h2>Thank You</h2>
            <ul>
                <li>Home  >></li>
                <li><a href="{{url('/thank-you')}}">Thank You</a> </li>
            </ul>
        </div>
    </div>
</div>
<div class="cart-secion my-5">
    <div class="container">
        <h2 class="text-center">Thank You for your order.</h2>
        <div class="text-center">
            <a href="{{url('user/orders')}}" class="btn cart-btn">View Orders</a>
        </div>
    </div>
</div>
@endsection