@extends('layouts.app')
@section('content')
<style type="text/css">
  .error,span{
      color:red;
      font-size: 13px;
  }
.container1 {
  display: block;
  position: relative;
  padding-left: 35px;
  margin-bottom: 12px;
  cursor: pointer; 
  font-size: 15px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* Hide the browser's default radio button */
.container1 input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
}

/* Create a custom radio button */
.checkmark {
  position: absolute;
  top: 0;
  left: 0;
  height: 25px;
  width: 25px;
  background-color: #eee;
  border-radius: 50%;
}

/* On mouse-over, add a grey background color */
.container1:hover input ~ .checkmark {
  background-color: #ccc;
}

/* When the radio button is checked, add a blue background */
.container1 input:checked ~ .checkmark {
  background-color: #2196F3;
}

/* Create the indicator (the dot/circle - hidden when not checked) */
.checkmark:after {
  content: "";
  position: absolute;
  display: none;
}

/* Show the indicator (dot/circle) when checked */
.container1 input:checked ~ .checkmark:after {
  display: block;
}

/* Style the indicator (dot/circle) */
.container1 .checkmark:after {
  top: 9px;
  left: 9px;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: white;
}
</style>
<div class="innerpage-banner">
    <img src="{{ URL::to('/') }}/images/iner-bnr1.jpg" alt="" class="w-100">
    <div class="breadcrum">
        <div class="container">
            <h2>Customize Your Cake</h2>
            <ul>
                <li>Home  >></li>
                <li><a href="#">Customize Your Cake</a> </li>
            </ul>
        </div>
    </div>
</div>
<form method="post" action="{{url('saveCustomizedImage')}}" enctype='multipart/form-data'>
@csrf
<input type="hidden" name="product_id" value="{{$_REQUEST['product_id']}}">
<input type="hidden" name="return_url" value="{{$_REQUEST['return_url']}}">
<div class="occasion">
    <div class="container">
         <div class="row">
            @if(count($customize_shapes))
            <div class="col-md-6">
                <h4 class="h2">Select Shapes</h4>
                <div class="form-group">
                    <select class="form-control" name="customize_shape_id">
                        @foreach($customize_shapes as $customize_shape)
                            <option value="{{$customize_shape->id}}">{{$customize_shape->name}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            @endif
            @if(count($customize_flavours))
            <div class="col-md-6">
                <h4 class="h2">Select Flavour</h4>
                <div class="form-group">
                    <select class="form-control" name="customize_flavour_id">
                        @foreach($customize_flavours as $customize_flavour)
                            <option value="{{$customize_flavour->id}}">{{$customize_flavour->name}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            @endif

            <div class="col-md-12">
                <h4 class="h2">Message on your cake</h4>
                <div class="form-group">
                <input type="text" name="message_on_cake" class="form-control" maxlength="25" placeholder="Enter your message" required />
                </div>
            </div>
            <div class="col-md-12 form-group" style="margin-top:5px;">
              <p>It is recomended to set the charecter limit as follows :</p>
                <ul>
                  <li>500 Grams - 10 Characters</li>
                  <li>1 Kg - 20 Characters</li>
                  <li>2 Kgs - 25 Characters</li>
                </ul>
                <p>Character size may vary depending on the design & size of the cake. Please keep in mind while typing your message to avoid overlapping issue.</p>
              </div>
            <?php $product = \App\Models\Product::where('id',$_REQUEST['product_id'])->first();?>
            @if($product->is_photocake == 1)
            <div class="col-sm-12">
                <h2 class="h2">Upload your photo cake:</h2>
                <input class="form-control" name="photo_cake" type="file"/>
            </div>
            @endif

            <div class="col-sm-12"> 
                <input type="submit" name="submit" class="cart-btn" />
            </div>
         </div>
    </div>
</div>
</form>
@endsection