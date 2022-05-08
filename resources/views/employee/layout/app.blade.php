<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="x-ua-compatible" content="ie=edge">

  <title>Deliveryboy Panel</title>

  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="{{asset('/admin/css/all.min.css')}}">
  <!-- Theme style -->
  <link rel="stylesheet" href="{{asset('/admin/css/style.min.css')}}">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="{{asset('/admin/css/style.css')}}">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"></script>
  <meta name="csrf-token" content="{{ csrf_token() }}">
  @if(request()->is('admin/coupons/create') || request()->is('admin/orders'))
  
  @else
    <script src="{{asset('/admin/js/jquery.min.js')}}"></script>
  @endif
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="{{url('/employee/home')}}" class="nav-link">Home</a>
      </li>
    </ul>

    <!-- SEARCH FORM -->
    <form class="form-inline ml-3">
      <div class="input-group input-group-sm">
        
      </div>
    </form>

    <ul class="navbar-nav ml-auto">
      <!-- Messages Dropdown Menu -->
      <li class="nav-item">
        <div class="row">
          <div class="col-md-8">
            <a href="{{ url('/admin/change-password') }}" class="nav-link">Change Password</a>
          </div>
          <div class="col-md-4">
            <a href="{{ route('logout') }}"
                onclick="event.preventDefault();
                         document.getElementById('logout-form').submit();" class="nav-link">
                Logout
            </a>
            <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                                        @csrf
                                    </form>
          </div>
        </div>
      </li>
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <!-- <a href="index3.html" class="brand-link">
      <img src="{{asset('/admin/images/AdminLTELogo.png')}}" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">Admin Panel</span>
    </a> -->

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="{{asset('/admin/images/user2-160x160.jpg')}}" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">{{Auth::user()->name}}</a>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item">
            <a href="{{url('/employee/home')}}" class="nav-link ">
            <!-- <a href="{{url('/employee/home')}}" class="nav-link {{ request()->is('shop/home') ? 'active' : '' }}"> -->
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
              </p>
            </a>
          </li>
          
          <li class="nav-item">
            <a href="{{url('/employee/upcomingdelivery')}}" class="nav-link {{ request()->is('/employee/upcomingdelivery') ? 'active' : '' }}">
              <i class="nav-icon fas fa-th"></i>
              <p>
                Upcoming Delivery
              </p>
            </a>
          </li>
          <!-- <li class="nav-item">
            <a href="{{url('/employee/delivery-boy')}}" class="nav-link {{ request()->is('employee/delivery-boy') ? 'active' : '' }}">
              <i class="nav-icon fas fa-th"></i>
              <p>
                Cancelled Delivery
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="{{url('/employee/delivery-boy')}}" class="nav-link {{ request()->is('employee/delivery-boy') ? 'active' : '' }}">
              <i class="nav-icon fas fa-th"></i>
              <p>
                Past Delivery
              </p>
            </a>
          </li>
          
          <li class="nav-item">
            <a href="{{url('/employee/orders')}}" class="nav-link {{ request()->is('employee/orders') ? 'active' : '' }}">
              <i class="nav-icon fas fa-th"></i>
              <p>
                Order Details
              </p>
            </a>
          </li> -->
          
         
         
          
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->
   @yield('content')
  </div>
  <!-- /.content-wrapper -->
  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="float-right d-none d-sm-inline">
      Anything you want
    </div>

  </footer>
</div>
<script src="{{asset('/admin/js/bootstrap.bundle.min.js')}}"></script>
<!-- AdminLTE App -->
<script src="{{asset('/admin/js/adminlte.min.js')}}"></script>
</body>
</html>
