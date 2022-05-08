<?php

Route::get('/home', function () {
    $users[] = Auth::user();
    $users[] = Auth::guard()->user();
    $users[] = Auth::guard('parcelboy')->user();

    //dd($users);

    return view('parcelboy.home');
})->name('home');

