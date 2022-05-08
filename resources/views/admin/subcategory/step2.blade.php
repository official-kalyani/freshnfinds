@extends('admin.layouts.app')
@section('content')
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/croppie/2.6.2/croppie.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/croppie/2.6.2/croppie.js"></script>
<section class="content">
  <div class="container-fluid">
   <div class="row">
    <div class="col-md-12">
      <div class="card card-primary">
          <div class="card-header">
            <div class="row">
              <div class="col-md-6">
                <h3 class="card-title">Update Subcategory Banners</h3>
              </div>
              <div class="col-md-6">
                <a href="{{ URL::to('/') }}/admin/subcategory/<?php echo $_REQUEST['id']; ?>/edit" class="float-right" >Back to Step 1</a>
              </div>
            </div>
          </div>
          <!-- /.card-header -->
          <!-- form start -->
            <div class="card-body">
              <div class="form-group">
                <label for="imagename">Image Name : </label>
                <input name="imagename" type="text" class="form-control" id="imagename" placeholder="Enter Image Name">
              </div>
              <div class="row">
                <div class="col-md-3">
                  <label for="image">SubCategory Banners : </label>
                  <div class="custom-file">
                    <input name="image" type="file" class="custom-file-input" id="image">
                    <label class="custom-file-label" for="image">Choose Image</label>
                  </div>
                </div>
                <div class="col-md-9">
                  <div id="upload-demo"></div>
                </div>
                <input type="hidden" id="id" value="{{$_REQUEST['id']}}">
              </div>
              <div class="form-group">
                <button type="submit" class="btn btn-primary upload-image">Upload</button>
              </div>
            </div>
            <h2>Banners</h2>
            <div class="row">
              @foreach($banners as $row)
              <div class="col-sm-3">
                <div style="position: relative;">
                  <img src="{{ URL::to('/') }}/uploads/category/{{ @$row->image }}" style="width: 100%;" />
                  <button style="position: absolute; right: 0px;
                    font-size: 18px;" id="delete-multiple-image{{ $row->id }}" form="resource-delete-{{ $row->id }}"><i style="color: red;" class="fas fa-trash-alt"></i>
                  </button> 
                  </div>
                <div>
                  
                  <form action="{{url('admin/category/delete-category-sliders')}}?id={{$row->id}}" id="resource-delete-{{ $row->id }}" style="display: inline-block;" onSubmit="return confirm('Are you sure you want to delete this item?');" method="post">
                  @csrf
                  </form>
                </div>
              </div>
              @endforeach
            </div>
      </div>
    </div>
   </div>
  </div><!-- /.container-fluid -->
</section>

<script type="text/javascript">

var resize = $('#upload-demo').croppie({
    enableExif: true,
    enableOrientation: true,    
    viewport: { // Default { width: 100, height: 100, type: 'square' } 
        width: 900,
        height: 267,
        type: 'square' //square
    },
    boundary: {
        width: 1000,
        height: 367
    }
});



$('#image').on('change', function () { 
  var reader = new FileReader();
    reader.onload = function (e) {
      resize.croppie('bind',{
        url: e.target.result
      }).then(function(){
        console.log('jQuery bind complete');
      });
    }
    reader.readAsDataURL(this.files[0]);
});


$('.upload-image').on('click', function (ev) {
  $(this).html('Uploading...');
  $(this).attr('disabled', true);
  resize.croppie('result', {
    type: 'canvas',
    size: 'viewport'
  }).then(function (img) {
    var imagename = $('#imagename').val();
    var id = $('#id').val();
    $.ajax({
      headers: {
        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
      },
      url: "{{url('admin/category/multipleimage')}}",
      type: "POST",
      data: {"image":img,"id":id,"imagename":imagename},
      success: function (data) {
        location.reload();
        console.log(data);
      }
    });
  });
});


</script>

@endsection
