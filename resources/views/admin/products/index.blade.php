@extends('admin.layouts.app')
@section('content')
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
       <div class="row">
        <div class="col-md-12">
          <div class="card">
            <div class="card-header">
              <a href="{{route('admin.products.create')}}" class="btn btn-primary float-right">Create Products</a><br>
              <form method="get">
                  <div class="container">
                    <div class="row">
                      <div class="form-group col-md-3">
                        <label for="category_id">Category :</label>
                        <select id="category_id" name="category_id" class="form-control">
                          <?php $categories = \App\Models\Category::whereNull('parent_id')->get(); ?>
                            <option value="all" @if(@$_REQUEST['category_id'] == "all") selected @endif>All</option>
                            @foreach($categories as $category)
                              <option value="{{$category->id}}" @if(@$_REQUEST['category_id'] == $category->id) selected @endif>{{$category->name}}</option>
                            @endforeach
                        </select> 
                      </div>
                  
                      
                      <div class="form-group col-md-3">
                        <label for="txtToDate" style="color: white;">To:</label>
                        <input type="submit" name="filter" class="form-control btn btn-primary" value="Filter Products">
                      </div>
                    </div>
                </form>
            </div>
            @if(Session::has('flash_success'))
                <div class="alert alert-success">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                {{ Session::get('flash_success') }}
                </div>
            @endif
            <!-- /.card-header -->
            <div class="card-body">
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Category</th>
                     <th>MRP Price</th>
                    <th>Selling Price</th>
                    <th>Status</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach($data as $row)
                  <tr>
                    <?php
                    $product_image = \App\Models\ProductImage::where('product_id',$row->id)->where('is_featured',1)->first();
                    ?>
                    <td>
                      <img src="{{ URL::to('/') }}/uploads/product/{{ @$product_image->images }}" alt="" width="50%">
                    </td>
                    <?php
                    $category = \App\Models\Category::where('id',$row->category_id)->first();
                    $subcategory_arr = \App\Models\Category::where('id',$row->subcategory_id)->first();
                    ?>
                    <td>{{@$row->name}}</td>
                    <td>{{@$category->name}}</td>


                    <td>&#8377;{{@$row->mrp_price}}.00</td>
                    <td>&#8377;{{@$row->price}}.00</td>
                    <td>{{@$row->is_active}}</td>
                  
                    <td><a href="{{ url('admin/products/create') }}?id={{$row->id}}" class="btn"><i class="fas fa-edit" style="color: blue" ></i></a>
                      <button form="resource-delete-{{ $row->id }}"><i style="color: red;" class="fas fa-trash-alt"></i></button>
                      <form id="resource-delete-{{ $row->id }}" action="{{ route('admin.products.destroy', $row->id) }}" style="display: inline-block;" onSubmit="return confirm('Are you sure you want to delete this item?');" method="post">
                        @csrf
                        @method('DELETE')
                      </form></td>
                  </tr>
                  @endforeach
                </tbody>
              </table>
              <br>
              {!! $data->links() !!}
            </div>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->
        </div>
       </div>
      </div><!-- /.container-fluid -->
    </section>
@endsection
