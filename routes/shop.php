<?php

Route::get('/home', function () {
    $users[] = Auth::user();
    $users[] = Auth::guard()->user();
    $users[] = Auth::guard('shop')->user();

    //dd($users);

    return view('shop.home');
})->name('home');

Route::resource('products','Store\ProductController');
Route::get('master-products','Store\ProductController@masterProducts');
Route::get('clone-master-products','Store\ProductController@cloneMasterProducts');

Route::resource('cakes','Store\CakeController');
Route::get('master-cakes','Store\CakeController@masterCakes');
Route::get('clone-master-cakes','Store\CakeController@cloneMasterCakes');


 
Route::get('change-password','Store\ShopController@changePassword');
Route::post('changepassword','Store\ShopController@updatePassword');
