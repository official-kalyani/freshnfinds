<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class RedirectIfParcelboy
{
	/**
	 * Handle an incoming request.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @param  \Closure  $next
	 * @param  string|null  $guard
	 * @return mixed
	 */
	public function handle($request, Closure $next, $guard = 'parcelboy')
	{
	    if (Auth::guard($guard)->check()) {
	        return redirect('parcelboy/home');
	    }

	    return $next($request);
	}
}