@extends('admin.layouts.app')
@section('content')
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
       <div class="row">
        <div class="col-md-12">
          <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Update Delivery Boy</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              @if(Session::has('flash_success'))
                  <div class="alert alert-success">
                      <button type="button" class="close" data-dismiss="alert">×</button>
                  {{ Session::get('flash_success') }}
                  </div>
              @endif
              <form method="post" action="{{route('admin.delivery-boy.update',$data->id)}}">
                @csrf
                @method('PATCH')
                <div class="card-body">
                  <div class="form-group {{ $errors->has('shop_name') ? ' has-error' : '' }}
                    ">
                   <div class="form-group {{ $errors->has('name') ? ' has-error' : '' }}">
                    <label for="name">Name <span class="required">*</span></label>
                    <input name="name" type="text" class="form-control" id="name" placeholder="Enter Name" value="{{$data->name}}">
                     @if ($errors->has('name'))
                        <span class="required">
                            <strong>{{ $errors->first('name') }}</strong>
                        </span>
                    @endif  
                  </div>
                  <div class="form-group {{ $errors->has('phone') ? ' has-error' : '' }}">
                    <label for="phone">Phone <span class="required">*</span></label>
                    <input name="phone" type="number" class="form-control" id="phone" placeholder="Enter Phone" value="{{$data->phone}}" readonly>
                     @if ($errors->has('phone'))
                        <span class="required">
                            <strong>{{ $errors->first('phone') }}</strong>
                        </span>
                    @endif  
                  </div>
                  <div class="form-group {{ $errors->has('email') ? ' has-error' : '' }}">
                    <label for="email">Email <span class="required">*</span></label>
                    <input name="email" type="email" class="form-control" id="email" placeholder="Enter Email" value="{{$data->email}}" readonly>
                     @if ($errors->has('email'))
                        <span class="required">
                            <strong>{{ $errors->first('email') }}</strong>
                        </span>
                    @endif  
                  </div>
                   <div class="form-group {{ $errors->has('address') ? ' has-error' : '' }}">
                    <label for="address">Address <span class="required">*</span></label>
                    <input name="address" type="text" class="form-control" id="address" placeholder="Enter Address" value="{{$data->address}}">
                     @if ($errors->has('address'))
                        <span class="required">
                            <strong>{{ $errors->first('address') }}</strong>
                        </span>
                    @endif  
                  </div>
                  <div class="form-group {{ $errors->has('address') ? ' has-error' : '' }}">
                    <label for="education">Education <span class="required">*</span></label>
                    <input name="education" type="text" class="form-control" id="education" placeholder="Enter Education" value="{{$data->education}}">
                     @if ($errors->has('education'))
                        <span class="required">
                            <strong>{{ $errors->first('education') }}</strong>
                        </span>
                    @endif  
                  </div>
                  <div class="form-group {{ $errors->has('password') ? ' has-error' : '' }}">
                    <label for="password">Password <span class="required">*</span></label>
                    <input name="password" type="password" class="form-control" id="password" placeholder="">
                     @if ($errors->has('password'))
                        <span class="required">
                            <strong>{{ $errors->first('password') }}</strong>
                        </span>
                    @endif  
                  </div>
                  <div class="form-group">
                    <button type="submit" class="btn btn-primary">Update</button>
                  </div>
                </div>
              </form>
          </div>
        </div>
       </div>
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
@endsection
