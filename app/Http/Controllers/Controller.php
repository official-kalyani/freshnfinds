<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use App\Models\Obcoin;

$obcoin = Obcoin::where('id',1)->first();
define('CBCOIN_PRECENTAGE',$obcoin ->precentage);
define('CBCOIN_PAISA',$obcoin ->paisa);
define('DELIVERY_CHARGE',$obcoin ->deliveryCharge);

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;
}
