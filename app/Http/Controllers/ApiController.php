<?php

namespace App\Http\Controllers;
//namespace App\Http\Controllers\EmployeeAuth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Input;
use Razorpay\Api\Api;
use App\Models\Category;
use App\Models\Address;
use App\Models\Occasion;
use App\Models\ProductImage;
use App\Models\Product;
use App\Models\ProductPrice;
use App\Models\SectionItem;
use App\Models\Section;
use App\Models\CustomizeCake;
use App\Models\Contact;
use App\Models\Newsletter;
use App\Models\ProductRating;
use App\Models\Location;
use App\Models\Orderlist;
use App\Models\UserCoupon;
use App\Models\CustomizeImage;
use App\Models\Coupon;
use App\Models\Cbcoin;
use App\Models\Order;
use Carbon\Carbon;
use App\Models\Transaction;
use App\User;
use App\Employee;
use App\Shop;
use DB; 
use Auth;
//use App\EmployeeAuth;
use App\Models\Notification;
use App\Mail\LoginOtpEmail;
use App\Mail\SignupOtpEmail;
use Mail;
use App\Models\Testimonial;
use App\Models\Slider;
use App\Models\CategoryImage;


// 0 - expired
// 1 - active
// 2 - pending
// 3 - used

class ApiController extends Controller
{
    public function signUp(Request $request)
	{
		$ret = array(); 
		$validator = Validator::make($request->all(), [
			"name" => 'required|string|max:191',
            "email" => 'required|string|email|max:191|unique:users',
            "password" => 'required|string|min:6',
			'phone' => 'required|max:10',
		]);

			$validateEmail = User::where('email',$request->email)->first();
			$validatePhone = User::where('phone',$request->phone)->first();
			if ($validatePhone) 
			{
				$ret['user_id'] = $validatePhone->id;
				$ret['statusCode'] = (string) 200;
				$ret['status'] = "success";
				$ret['message'] = "Phone number already registered with us, please try another phone number";				
				return response()->json($ret, $ret['statusCode']);
			}
			else if ($validateEmail) 
			{
				$ret['user_id'] = $validateEmail->id;
				$ret['statusCode'] = (string) 200;
				$ret['status'] = "success";
				$ret['message'] = "Email already registered with us, please try another email";				
				return response()->json($ret, $ret['statusCode']);
			}
			else
			{
				$otp_code = mt_rand(100000, 999999);
				$user = new User;
				$user->name = $request->name;
				$user->email = $request->email;
				$user->phone = $request->phone;
				$user->password = $request->password;
				$user->access_token = md5(uniqid(rand().time(), true));
				$user->last_used_platform = "APP";
				$user->has_verified = 1;
				$user->otp = $otp_code;
				$user->save();
 				
 				$cbCoin = new Cbcoin;
		        $cbCoin->user_id = $user->id;
		        $cbCoin->coins = 10;
		        $cbCoin->type = "PLUS";
		        $cbCoin->save();
		        $cbCoin->expiry_at = Carbon::now()->addMonth();
		        $cbCoin->save();
				
				if (isset($user->id)) 
				{
					$user = User::where('id','=',$user->id)->first();
					$ret['user_id'] = $user->id;
					$ret['user_name'] = $user->name;
					$ret['access_token'] = $user->access_token;
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "success";
					$ret['message'] = "User Signed Up";
					$ret['has_verified'] = $user->has_verified;
					return response()->json($ret, $ret['statusCode']);
				}
				else
				{
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "failure";
					$ret['message'] = "Something went wrong";
					return response()->json($ret, $ret['statusCode']);
				}
			}
	}

	public function otpVerify(Request $request){
		
		$ret = array();
		
		$validator = Validator::make($request->all(), [
			'otp' => 'required|max:6',
			'user_id' => 'required',
			'type' => 'required', 
		]);
		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}

		$otp = $request->otp;
		$user_id = $request->user_id;

		$validateuser = User::where('id','=',$user_id)->first();

		if ($validateuser) {		
			if ($request->type == "forgotpass") {
				$user = User::where('id','=',$user_id)->first();

				if($user->otp == $request->otp)
				{
					$user->save();
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "success";
					$ret['message'] = "Verified";
					$ret['access_token'] = $user->access_token;
					$ret['user_id'] = $user->id;
					$ret['has_verified'] = $user->has_verified;
				}
				else
				{
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "failure";
					$ret['message'] = "Otp Mismatched!";
				}
			}

			else if ($request->type == "signup") {
				$user = User::where('id','=',$user_id)->first();

				if($user->otp == $request->otp)
				{
					$user->has_verified = 1;
					$user->access_token = md5(uniqid(rand().time(), true));
					$user->save();
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "success";
					$ret['message'] = "Verified";
					$ret['access_token'] = $user->access_token;
					$ret['token_type'] = "Bearer";
					$ret['expires_at'] = "2021-03-01 06:31:09";
					$ret['user_id'] = $user->id;
					$ret['phone'] = $user->phone;
					$ret['name'] = $user->name;
					$ret['has_verified'] = $user->has_verified;

				}
				else
				{
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "failure";
					$ret['message'] = "Otp Mismatched!";
				}
			}

			else if ($request->type == "login") {
				$user = User::where('id','=',$user_id)->first();

				if($user->otp == $request->otp)
				{
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "success";
					$ret['message'] = "Verified";
					$ret['access_token'] = $user->access_token;
					$ret['user_id'] = $user->id;
					$ret['has_verified'] = $user->has_verified;
				}
				else
				{
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "failure";
					$ret['message'] = "Otp Mismatched!";
				}
			}

			else{
				$ret['statusCode'] = (string) 200;
				$ret['status'] = "failure";
				$ret['message'] = "Type error!";
			}
		}
		else{
				$ret['statusCode'] = (string) 200;
				$ret['status'] = "failure";
				$ret['message'] = "User id not found!";
			}
	   return response()->json($ret, $ret['statusCode']);
	}

	public function login(Request $request)
	{
		$ret = array();

		$validator = Validator::make($request->all(), [
			'email' => 'required',
			//"password" => 'required|string|min:6',
			'type' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
				if(is_numeric($request->email)){
					$user = User::where('phone',$request->email)->where('password',$request->password)->first();
				}

				elseif (filter_var($request->email, FILTER_VALIDATE_EMAIL)) {
					$user = User::where('email',$request->email)->where('password',$request->password)->first();
				}
				
				if ($user) 
				{
					$ret['user_id'] = $user->id;
					$ret['name'] = $user->name;
					$ret['email'] = $user->email;
					$ret['phone'] = $user->phone;
					$ret['access_token'] = $user->access_token;
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "success";
					$ret['message'] = "Logged In";
					$ret['has_verified'] = $user->has_verified;
					return response()->json($ret, $ret['statusCode']);
				}
				else
				{
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "failure";
					$ret['message'] = "Your login details is incorrect, please enter correct password";
					return response()->json($ret, $ret['statusCode']);
				}
		
 		}
	}

	public function chanagePassword(Request $request)
	{
		$ret = array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
			'password' => 'required',
            'confirm_password' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {
				if ($request->password != $request->confirm_password) {
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "failure";
					$ret['message'] = "Password and Confirm Password Must be same!";
					return response()->json($ret, $ret['statusCode']);
		        }
		        else{
		            $user->password = $request->password;
		            $user->save();
		            $ret['statusCode'] = (string) 200;
					$ret['status'] = "success";
					$ret['message'] = "Password Changed!";
					return response()->json($ret, $ret['statusCode']);
		        }
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;
			}
		}
	}

	public function forgotPassword(Request $request)
    {
      	$ret = array();

		$validator = Validator::make($request->all(), [
			'email' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			if(is_numeric($request->email)){
		        if (strlen($request->email) > 10) {
		          $ret['statusCode'] = (string) 200;
				  $ret['status'] = "failure";
				  $ret['message'] = "Mobile Number must be 10 charachters";
		          return response()->json($ret);
		        }
		        elseif (strlen($request->email) < 10) {
		          $ret['statusCode'] = (string) 200;
				  $ret['status'] = "failure";
		          $ret['message'] = "Mobile Number must be 10 charachters";
		          return response()->json($ret);
		        }
		        elseif (strlen($request->email) == 10) {
		          $user = User::where('phone',$request->email)->first();
		          $phone = $user->phone;
		          $user = User::where('phone',$phone)->first();
		          if ($user) {
		            $curl = curl_init();
		            $otp_code = mt_rand(100000, 999999);
		            $msg = urlencode("Your Verification code is ".$otp_code);
		            $mobileno = "91".$user->phone;
		            $authkey = '324839AfzulCKGe5e7de4baP1';
		            $senderid = 'RIXOSY';
		            curl_setopt_array($curl, array(
		            CURLOPT_URL => "https://api.msg91.com/api/sendhttp.php?mobiles=$mobileno&authkey=$authkey&route=4&sender=$senderid&message=$msg&country=91",
		                   CURLOPT_RETURNTRANSFER => true,
		                   CURLOPT_ENCODING => "",
		                   CURLOPT_MAXREDIRS => 10,
		                   CURLOPT_TIMEOUT => 30,
		                   CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		                   CURLOPT_CUSTOMREQUEST => "GET",
		                   CURLOPT_SSL_VERIFYHOST => 0,
		                   CURLOPT_SSL_VERIFYPEER => 0,
		            ));
		            $response = curl_exec($curl);
		            $err = curl_error($curl);
		            curl_close($curl);
		            $arr = array();
		            if(!$err){
		               $arr['status'] = true;
		               $arr['otp_code'] = $otp_code;
		               $arr['otp_response'] = $response;
		            } else {
		               $arr['status'] = false;
		               $arr['otp_code'] = $otp_code;
		               $arr['otp_response'] = $response;
		            }
		            $user->otp = $arr['otp_code'];
		            if ($user->save()) 
		            {
		              $ret['user_id'] = $user->id;
		              $ret['statusCode'] = (string) 200;
				  	  $ret['status'] = "success";
				  	  $ret['otp_code'] = $user->otp;
		              $ret['message'] = "Otp Sent";
		              $ret['has_verified'] = $user->has_verified;
		              return response()->json($ret);
		            }
		            else
		            {
		               $ret['statusCode'] = (string) 200;
				       $ret['status'] = "failure";
		               $ret['message'] = "Something Went Wrong";
		               return response()->json($ret);
		            }
		          }
		          else
		          {
		            $ret['statusCode'] = (string) 200;
				    $ret['status'] = "failure";
		            $ret['message'] = "This mobile number is not registered with us, please sign up to enjoy with cakes.";
		            return response()->json($ret);
		          }
		        }
		      }

		      elseif (filter_var($request->email, FILTER_VALIDATE_EMAIL)) {
		        $user = User::where('email',$request->email)->first();
		        if ($user) {
		          $otp_code = mt_rand(100000, 999999);
		          $data = ['name' => $user->name , 'otp' => $otp_code];;
		              Mail::to($user->email)->send(new LoginOtpEmail($data));
		          $user->otp = $otp_code;
		          if ($user->save()) 
		          {
		            $ret['user_id'] = $user->id;
		            $ret['statusCode'] = (string) 200;
				  	$ret['status'] = "success";
				  	$ret['otp_code'] = $user->otp;
		            $ret['message'] = "Otp Sent";
		            $ret['has_verified'] = $user->has_verified;
		            return response()->json($ret);
		          }
		          else
		          {
		            $ret['statusCode'] = (string) 200;
					$ret['status'] = "failure";
		            $ret['message'] = "Something Went Wrong";
		            return response()->json($ret);
		          }
		        }
		        else{
			        $ret['statusCode'] = (string) 200;
					$ret['status'] = "failure";
			        $ret['message'] = "This email is not registered with us, please sign up to enjoy with cakes.";
			        return response()->json($ret);
		        }
		      }
		}
    }

    public function updateProfile(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
			'name' => 'required',
			//'email' => 'required',
			//'phone' => 'required'
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {
				$user->name = $request->name;
				//$user->email = $request->email;
				//$user->phone = $request->phone;
				if($request->has('avatar') && $request->avatar!=''){
					@unlink('storage/user/'.$user->avatar); 
	                $img = $request->avatar;
	                $uniqueid=md5(uniqid(rand().time(), true));
	                $image_base64 = base64_decode($img);
	                $extension = 'jpeg';

	                $filename=Carbon::now()->format('Ymd').'_'.$uniqueid.'.'.$extension;
	                $file_url=url('/storage/user/'.$filename);
	               \Storage::disk('public')->put('user/'.$filename, $image_base64);
	               $user->avatar = $filename ;
				}

				$user->save();
		        $ret = array();
		        $ret['status'] = "success";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Profile Updated";
				$ret['name'] = $user->name;
				$ret['email'] = $user->email;
				$ret['phone'] = $user->phone;
				$ret['avatar'] = url('/')."/storage/user/".$user->avatar;
				return $ret;
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;
			}
		}
    }

	public function home(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = "Required Validation Errors";
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$validate = User::where('access_token',$access_token)->first();
			if ($validate) {
					$categories = Category::whereNull('parent_id')->get();
					foreach($categories as $val){
						$category[] = array(
							'id'=>$val->id,
							'name'=>$val->name,
							'image'=> url('/')."/uploads/category/".$val->image,
						);
					}

			    	$sections = Section::all();						        
			        foreach ($sections as $section) {
			        	if($section->type == "Product"){
		        			$products = DB::table('section_items')
									->join('products','products.id','section_items.product_id')
									->join('product_images','product_images.product_id','products.id')
									->where('product_images.is_featured',1)		        					
		        					->where('section_items.section_id',$section->id)
									->select('products.*','product_images.images')
		        					->get();
			       
			        		$product_arr = array();
			        		if (count($products) > 0) {
			        			foreach ($products as $product) {
									$discountPrice = $product->mrp_price - $product->price;
									$discountPercentage = ($product->price / $product->mrp_price)*100;
				        			$product_arr[] = array(
				        				'id'=>$product->id,
						                'name'=>$product->name,
						                'mrp_price'=>$product->mrp_price,
						                'selling_price' => $product->price,
						                'discount_price'=> $discountPrice,
						                'weight'=> $product->weight,
						                'discount_percentage' => 100-round($discountPercentage),
										'image'=> url('/')."/uploads/product/".@$product->images,
				        			);
				        		}
			        		}
			        		else{
			        			$product_arr = null;
			        		}

			        	}else{
			        		$product_arr = url('/')."/uploads/offers/".$section->image;
			        	}
			        	$section_arr[] = array(
			        		'id' => $section->id,
			        		'section_name'=>$section->name,
			        		'section_type'=>$section->type,
			        		'products'=> $product_arr,
			        	);
			        }
		        
		        	$dashbord = array(
						"category" => $category,
						"section" => $section_arr,
					);
	
		        $ret = array();
				$ret['dashbord'] = $dashbord;
				$ret['status'] = "success";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "All dashbord products are here";
				return $ret;
			}
			else{
				$ret['status'] = "failure";
        		$ret['statusCode'] = (string) 200;
        		$ret['message'] = "Access Token Mismatched";
        		return $ret;
			}
		}
    }

    
    public function category(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
			'category_id' => 'required',
			'access_token' => 'required'
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {
				$products = DB::table('products')
					->join('product_images','product_images.product_id','products.id')
					->where('products.category_id',$request->category_id)
					->where('products.steps_completed',3)
					->where('product_images.is_featured',1)
					->orderBy('products.id','desc')
					->select('products.*','product_images.images')->get();
					$product_arr = array();
					if (count($products) > 0) {
						foreach ($products as $product) {
							$discountPrice = $product->mrp_price - $product->price;
							$discountPercentage = ($product->price / $product->mrp_price)*100;
							$product_arr[] = array(
								'id'=>$product->id,
								'name'=>$product->name,
								'mrp_price'=>$product->mrp_price,
								'selling_price' => $product->price,
								'weight' => $product->weight,
								'discount_price'=> $discountPrice,
								'discount_percentage' => 100-round($discountPercentage),
								'image'=> url('/')."/uploads/product/".@$product->images,
							);
						}
					}
					else{
						$product_arr = null;
					}
					$ret['products'] = $product_arr;
					$ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "All category are here";
					return $ret;

			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;
				

			}
		}
    }

    public function sections(Request $request)
    {
    	$ret = $product_arr = array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
			'section_id' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$validate = User::where('access_token',$access_token)->first();
			if ($validate) {
				$CheckSection_item = Section::where('id',$request->section_id)->first();
				if ($CheckSection_item) {
					$products = DB::table('section_items')
								->join('products','products.id','section_items.product_id')
								->join('product_images','product_images.product_id','products.id')
								->where('product_images.is_featured',1)		        					
								->where('section_items.section_id',$request->section_id)
								->select('products.*','product_images.images')
								->get();
					$product_arr = array();
					if (count($products) > 0) {
						foreach ($products as $product) {
							$discountPrice = $product->mrp_price - $product->price;
							$discountPercentage = ($product->price / $product->mrp_price)*100;
							$product_arr[] = array(
								'id'=>$product->id,
								'name'=>$product->name,
								'mrp_price'=>$product->mrp_price,
								'selling_price' => $product->price,
								'discount_price'=> $discountPrice,
								'discount_percentage' => 100-round($discountPercentage),
								'image'=> url('/')."/uploads/product/".@$product->images,
							);
						}
					}
					else{
						$product_arr = array();
					}				
			        $ret = array();
					$ret['section_id'] = $CheckSection_item->id;
					$ret['section_name'] = $CheckSection_item->name;
					$ret['products'] = $product_arr;
					$ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "All products are here";
					return $ret;
				}
				else
				{
					$ret = array();
					$ret['sections'] = "No Section Id Found";
					$ret['status'] = "failure";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "No Products Found";
					return $ret;
				}
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;

			}
		}
    }

    public function productDetails(Request $request)
    {
        $product_images_arr = $product_images = $related_product_arr = $ret = $totalRating = $rating_arr = $totalReview =array();
        $prductRating = 0;
		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
			'product_id' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{

			$access_token = $request->access_token;
			$validate = User::where('access_token',$access_token)->first();
			if ($validate)
			{
				$product = Product::where('id',$request->product_id)->where('steps_completed',3)->first();			
				$product->description = preg_replace("/^<p.*?>/", "",$product->description);
				$product->description = preg_replace("|</p>$|", "",$product->description);

				$product_images = ProductImage::where('product_id',$product->id)->get();
				if (count($product_images)) {
					foreach ($product_images as $product_image) {
						$product_images_arr[] = array(
							'image'=> url('/')."/uploads/product/".@$product_image->images,
						);
					}
				}		
				$discountPrice = $product->mrp_price - $product->price;
				$discountPercentage = ($product->price / $product->mrp_price)*100;		
				$productJson = array(
					'id'=>$product->id,
					'name'=>$product->name,
					'description' => $product->description,
					'mrp_price' => $product->mrp_price,
					'selling_price' => $product->price,
					'weight' => $product->weight,
					'discount_price'=> $discountPrice,
					'discount_percentage' => 100-round($discountPercentage),
					'images'=> $product_images_arr,
				);
				$related_products = array();
				if (isset($product->category_id)) {
					$products = DB::table('products')
					->join('product_images','product_images.product_id','products.id')
					->where('products.category_id',$product->category_id)
					->where('products.steps_completed',3)
					->where('product_images.is_featured',1)
					->orderBy('products.id','desc')
					->select('products.*','product_images.images')->paginate(12);
					if (count($products) > 0) {
						foreach ($products as $product) {
							$discountPrice = $product->mrp_price - $product->price;
							$discountPercentage = ($product->price / $product->mrp_price)*100;

							$related_products[] = array(
								'id'=>$product->id,
								'name'=>$product->name,
								'mrp_price'=>$product->mrp_price,
								'selling_price' => $product->price,
								'weight' => $product->weight,
								'discount_price'=> $discountPrice,
								'discount_percentage' => 100-round($discountPercentage),
								'image'=> url('/')."/uploads/product/".@$product->images,
							);
						}
					}
					else{
						$product_arr = array();
					}
				}                   
		    		$productDetails = array(
		        		'product'=>$productJson,
		        		'related_products'=>$related_products,
		        	);

                    $ret['productDetails'] = $productDetails;
					$ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "All products are here";
					return $ret;	
           		}
           		else{
					$ret['status'] = "failure";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "Product not found";
					return $ret;
				}
		}
    }

    public function allProducts(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
			'type' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$validate = User::where('access_token',$access_token)->first();
			if ($validate)
			{
				if ($request->type == "delivery") {
		        	$products = Product::whereNull('parent_product_id')->where('steps_completed',3)->get();
		    	}
		    	if ($request->type == "takeaway") {
		        	$products = Product::wherenotNull('parent_product_id')->where('products.store_id',$request->store_id)->where('steps_completed',3)->get();
		    	}
        		if (count($products)>0){
        			foreach ($products as $product) {
        				if ($request->type == "delivery") {
	        				$product_price = ProductPrice::where('product_id',$product->id)->where('show_price',1)->first();
	        			}
	        			if ($request->type == "takeaway") {
				        	$product_price = ProductPrice::where('product_id',$product->parent_product_id)->where('show_price',1)->first();
				    	}

	        			$product_image = ProductImage::where('product_id',$product->id)->where('is_featured',1)->first();
	        			$allratings = ProductRating::where('product_id',$product->id)->get();

	        			$discountPrice = $product_price->mrp_price - $product_price->price;
						$discountPercentage = ($product_price->price / $product_price->mrp_price)*100;
	        			$totalRating = array();
	        			foreach ($allratings as $allrating) {
	        				$totalRating[] = $allrating->rating;
	        			}
	        			$totalRatingcount = count($allratings);
	        			if ($totalRatingcount != 0) {
	        				$prductRating = array_sum($totalRating) / $totalRatingcount;
	        			}
	        			else{
	        				$prductRating = 0;
	        			}

	        			$product_arr[] = array(
	        				'id'=>$product->id,
			                'name'=>$product->name,
			                'mrp_price'=>$product_price->mrp_price,
			                'selling_price' => $product_price->price,
			                'discount_price'=> $discountPrice,
			                'discount_percentage' => 100-round($discountPercentage),
							'image'=> url('/')."/uploads/product/".@$product_image->images,
							'is_customize' => $is_customize,
							'rating'=> round($prductRating, 1),
	        			);
	        		}
        		}
        		else{
        			$product_arr = "";
        		}
		    	$ret = array();
				$ret['product'] = $product_arr;
				$ret['status'] = "success";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "All products are here";
				return $ret;
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;

			}
		}
    }

    public function location(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
          	'access_token' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$validate = User::where('access_token',$access_token)->first();
			if ($validate)
			{
				$locations = Location::all();
				foreach($locations as $location){
					$stores = Shop::where('location', $location->id)->get();
					foreach ($stores as $store) {
						$store_arr[] = array(
			                'id'=>$store->id,
			                'name'=>$store->name,
			                'short_address' => $store->short_address,
			                'long_address' => $store->long_address,
			            );
					}
		        	$location_arr[] = array(
		                'id'=>$location->id,
		                'name'=>$location->name,
		                'store'=> $store_arr,
		            );
		        }
	
		        $ret = array();
				$ret['location'] = $location_arr;
				$ret['status'] = "success";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "All dashbord products are here";
				return $ret;
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;
			}
		}
    }

	public function address(Request $request)
	{
		$ret = $address_arr= array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
			'type' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = "Required Validation Errors";
			return response()->json($ret, $ret['statusCode']);
		}
		else{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {
				if ($request->type == "add") {
					$address = new Address;
					$address->name = $request->name;
					$address->email = $request->email;
					$address->phone = $request->phone;
					$address->address_type = $request->address_type;
					$address->pincode = $request->pincode;
					$address->location = $request->address;
					$address->additional_address = $request->additional_address;
					$address->longitude = $request->longitude;
					$address->latitude = $request->latitude;
					$address->user_id = $user->id;
					$address->save();
					if ($request->has_default == 1) {
		                DB::statement("
		                    UPDATE addresses SET has_default = 0 WHERE user_id = $user->id
		                ");
			            $address->has_default = $request->has_default;
			        }
			        else{
			            $address->has_default = $request->has_default;
			        }
			        $address->save();

					$ret['status'] = "success";
					$ret['address_id'] = $address->id;
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "Address Added";
					return response()->json($ret, $ret['statusCode']);
				}
				else if ($request->type == "update") {
					$address = Address::where('id',$request->address_id)->where('user_id',$user->id)->first();
					if ($address) {
						$address->name = $request->name;
						$address->email = $request->email;
						$address->phone = $request->phone;
						$address->address_type = $request->address_type;
						$address->pincode = $request->pincode;
						$address->location = $request->address;
						$address->additional_address = $request->additional_address;
						$address->longitude = $request->longitude;
						$address->latitude = $request->latitude;
						$address->save();
						if ($request->has_default == 1) {
			                DB::statement("
			                    UPDATE addresses SET has_default = 0 WHERE user_id = $user->id
			                ");
				            $address->has_default = $request->has_default;
				        }
				        else{
				            $address->has_default = $request->has_default;
				        }
				        $address->save();

						$ret['status'] = "success";
						$ret['address_id'] = $address->id;
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "Address Updated";
						return response()->json($ret, $ret['statusCode']);
					}
					else{
						$ret['status'] = "failure";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "Address id not found for user";
						return response()->json($ret, $ret['statusCode']);
					}
					
				}
				else if ($request->type == "delete") {
					$address = Address::where('id',$request->address_id)->where('user_id',$user->id)->first();
					$address->delete();

					$ret['status'] = "success";
					$ret['address_id'] = $address->id;
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "Address Deleted";
					return response()->json($ret, $ret['statusCode']);
				}
				else if ($request->type == "all") {
					$address = Address::where('user_id',$user->id)->get();
					if (count($address)) {
						foreach($address as $val){
				        	$address_arr[] = array(
				                'id'=>$val->id,
				                'name'=>$val->name,
				                'email'=>$val->email,
				                'phone'=>$val->phone,
				                'address_type'=>$val->address_type,
				                'has_default'=>$val->has_default,
				                'pincode'=>$val->pincode,
				                'location'=>$val->location,
				                'additional_address'=>$val->additional_address,
				                'longitude'=>$val->longitude,
				                'latitude'=>$val->latitude,
				            );
				        }
					}
					$ret['status'] = "success";
					$ret['address'] = $address_arr;
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "All Address";
					return response()->json($ret, $ret['statusCode']);
				}
				else{
					$ret['status'] = "failure";
	        		$ret['statusCode'] = (string) 200;
	        		$ret['message'] = "Type Error";
	        		return $ret;
				}
			}
			else{
				$ret['status'] = "failure";
        		$ret['statusCode'] = (string) 200;
        		$ret['message'] = "Access Token Mismatched";
        		return $ret;
			}
		}
	}

	public function coupon(Request $request)
	{
		$ret = array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
			'type' => 'required'
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = "Required Validation Errors";
			return response()->json($ret, $ret['statusCode']);
		}
		else{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {
				if ($request->type == "all") {
					$coupons = Coupon::all();

					foreach ($coupons as $coupon) {
						$coupon_arr[] = array(
							'id' => $coupon->id,
							'coupon_code' => $coupon->coupon_code,
							'coupon_heading' => $coupon->coupon_heading,
							'coupon_desc' => $coupon->coupon_desc,
							'discount_type' => $coupon->discount_type,
							'discount_amount' => $coupon->discount_amount,
							'minimum_order' => $coupon->minimum_order,
							'validity_till' => $coupon->validity_till,
						);
					}

					$ret['coupons'] = $coupon_arr;
					$ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "Address Deleted";
					return response()->json($ret, $ret['statusCode']);
				}

				else if ($request->type == "apply") {
					$user_id = $user->id;
					$order_amount = $request->order_amount;
					$coupon = Coupon::where('coupon_code','=',$request->coupon_code)->first();
					if (isset($coupon->id) && $coupon->coupon_code === $request->coupon_code) {
						if ($coupon->minimum_order <= $order_amount) {
								$ret['status'] = "success";
								$ret['statusCode'] = (string) 200;
								$ret['message'] = "Coupon Applied Successful";
								return response()->json($ret, $ret['statusCode']);
							}
							else{
								$ret['status'] = "failure";
								$ret['statusCode'] = (string) 200;
								$ret['message'] = "Coupon Not Applicable on Order Amount";
								return response()->json($ret, $ret['statusCode']);
							}
						}
					else{
						$ret['status'] = "failure";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "Coupon Code Not Found";
						return response()->json($ret, $ret['statusCode']);
					}
				}

				else{
					$ret['status'] = "failure";
	        		$ret['statusCode'] = (string) 200;
	        		$ret['message'] = "Type Error";
	        		return $ret;
				}
				
			}

			else{
				$ret['status'] = "failure";
        		$ret['statusCode'] = (string) 200;
        		$ret['message'] = "Access Token Mismatched";
        		return $ret;
			}
		}
	}

	public function search(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
          	'access_token' => 'required',
          	'name' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$validate = User::where('access_token',$request->access_token)->first();
			if ($validate)
			{
				$products = DB::table('products')
						->join('product_images','product_images.product_id','products.id')
						->where('products.steps_completed',3)
						->where('product_images.is_featured',1)
						->where('name', 'like', '%' . $request->name . '%')
						->select('products.*','product_images.images')->get();
						if (count($products) > 0) {
							foreach ($products as $product) {
								$discountPrice = $product->mrp_price - $product->price;
								$discountPercentage = ($product->price / $product->mrp_price)*100;
								$product_arr[] = array(
									'id'=>$product->id,
									'name'=>$product->name,
									'mrp_price'=>$product->mrp_price,
									'selling_price' => $product->price,
									'discount_price'=> $discountPrice,
									'discount_percentage' => 100-round($discountPercentage),
									'image'=> url('/')."/uploads/product/".@$product->images,
								);
							}
						}
						else{
							$product_arr = array();
						}
				

				$ret['products'] = $product_arr;
				$ret['status'] = "success";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Product Lists";
				return response()->json($ret, $ret['statusCode']);
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched!";
				return $ret;

			}
		}
    }
	

    public function placeOrder(Request $request)
    {
		$data = file_get_contents("php://input");
		$json = json_decode($data);
    	$items = $json->{'items'};
    	$ret = array();
		$validator = Validator::make($request->all(), [
          	'access_token' => 'required',
          	'payment_type' => 'required',
          	'address_id' => 'required',
          	'items' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$coupon_id = $json->{'coupon_id'};
			$address_id = $json->{'address_id'};
			$access_token = $json->{'access_token'};
			$user = User::where('access_token',$access_token)->first();
			if ($user)
			{
				$deliveryCharge = $json->{'delivery_charge'};
				$coupon_amount = $json->{'coupon_amount'};
				$cbcoinsDiscount = $json->{'cbcoinsDiscount'};
				foreach ($items as $item) {
					$product_price = Product::where('id',$item->id)->first();
					$totalAmount[] = $product_price->price*$item->quantity;
				}
				$finalAmount = $deliveryCharge+array_sum($totalAmount)-$coupon_amount-$cbcoinsDiscount;
				$order_id = uniqid('FNFORD');
				$order = new Order;
				$order->user_id = $user->id;
				
				$order->order_price = array_sum($totalAmount);
				$order->payable_price = $finalAmount;
				$order->coupon_amount = $coupon_amount;
				$order->delivery_charge = $deliveryCharge;
				$order->cbcoin_amount = $cbcoinsDiscount;
				$order->type = "delivery";
				$order->countdowm_time = Carbon::now()->addMinutes(5);
				if (isset($coupon_id) && $coupon_id !='') {
					$order->coupon_id = $coupon_id; 
				} else{
					$order->coupon_id = NULL; 
				}
				$order->user_address_id = $address_id;
				$order->status = "order_received";
				
				$order->save();
				
			    if ($request->payment_type == "online") {
					$api = new Api(config('custom.razor_key'), config('custom.razor_secret'));
					$razor = $api->order->create(array(
						'receipt' => uniqid(),
						'amount' => $finalAmount*100,
						'payment_capture' => 1,
						'currency' => 'INR'
						)
					  );
					$order->razorpay_order_id = $razor->id;
					$order->order_id = $razor->id;
					$order->payment_type = "online";
					$ret['payment_type'] = "online";
					$ret['razorpay_order_id'] = $razor->id;
					$ret['order_id'] = $razor->id;
				} else {			
					$order->order_id = $order_id;		
					$order->payment_type = "cod";
					$ret['payment_type'] = "offline";
					$ret['order_id'] = $order_id;
				}
				$order->save();
				if (isset($order->id) && $order->id > 0) {				
					foreach ($items as $item) {
						$product_price = Product::where('id',$item->id)->first();
						$orderList = new Orderlist;
						$orderList->user_id = $user->id;
						$orderList->order_id = $order->order_id;
						$orderList->item_id = $item->id;
						$orderList->price_id = $product_price->id;
						$orderList->item_selling_price = $product_price->price*$item->quantity;
						$orderList->item_mrp_price = $product_price->mrp_price*$item->quantity;
						$orderList->item_quantity = $item->quantity;
						$orderList->cart_status = "1";
						$orderList->save();
					}
				}

				$cbcoins_used = $json->{'cbcoins_used'};
				if (isset($cbcoins_used) && $cbcoins_used!='') {
					$cbCoin = new Cbcoin;
					$cbCoin->order_id = $order->order_id;
					$cbCoin->coins = $cbcoins_used;
					$cbCoin->user_id = $user->id;
					$cbCoin->type = "MINUS";
					$cbCoin->status = 3;//Used
					$cbCoin->expiry_at = Carbon::now()->addMonth();
					$cbCoin->save();
				}
				$coinswillAdded = (array_sum($totalAmount)-$deliveryCharge-$coupon_amount-$cbcoinsDiscount)/CBCOIN_PRECENTAGE;
				if ($coinswillAdded && $coinswillAdded!='') {
					$cbCoin = new Cbcoin;
					$cbCoin->order_id = $order->order_id;
					$cbCoin->coins = $coinswillAdded;
					$cbCoin->user_id = $user->id;
					$cbCoin->type = "PLUS";
					$cbCoin->status = 2;//Pedning
					$cbCoin->expiry_at = Carbon::now()->addMonth();
					$cbCoin->save();
				}
				$user_info = array(
					'id' => $user->id,
					'name' => $user->name,
					'email' => $user->email,
					'phone' => $user->phone,
				);

				$ret['total_price'] = $order->order_price;
				$ret['payable_price'] = $order->payable_price;
				
				$ret['user_info'] = $user_info;
				$ret['type'] = 'delivery';
			    $ret['store_id'] = null;
				$ret['status'] = "success";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Order Successful";
				return response()->json($ret, $ret['statusCode']);
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;

			}
		}
    }

    public function orderHistory(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
          	'access_token' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {
				$user_id = $user->id;
				$orders = DB::table('orders')
				->select('orders.*')
				->where('orders.user_id','=',$user_id)
				->get();
				if (count($orders)) {
					foreach($orders as $val){
			        	if ($val->status == "order_received") {
							$status = "Order Received";
						}
						else if ($val->status == "order_preparing") {
							$status = "Order Preparing";
						}
						else if ($val->status == "ontheway") {
							$status = "Ontheway";
						}
						else if ($val->status == "delivered") {
							$status = "Delivered";
						}
						else if ($val->status == "cancelled") {
							$status = "Cancelled";
						}
			        	$orderHistory[] = array(
			        		'order_id' => $val->order_id,
			        		'order_status'=> $status,
			                'order_price'=>$val->order_price,
			                'payable_price'=>$val->payable_price,
		        			'delivery_charge'=>$val->delivery_charge,
		        			'coupon_discount'=>$val->coupon_amount,
		        			'cbcoin_discount'=>$val->cbcoin_amount,
		        			'used_cbcoin'=>$val->cbcoin_amount*2,
			                'order_date'=> Carbon::parse($val->created_at)->format('jS M Y'),
			            );
			        }
			        
				}
		       	else{
					$orderHistory = array();
				}
				$ret['orderHistory'] = $orderHistory;
				$ret['statusCode'] = (string) 200;
				$ret['status'] = "success";
				$ret['message'] = "Order History";
				return $ret;
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !!";
				return $ret;

			}
		}
    }

	public function orderdetails(Request $request)
	{
		$ret = array();
		$validator = Validator::make($request->all(), [
			'order_id' => 'required',
			'access_token' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 422;
			$ret['status'] = "failure";
			$ret['message'] = "Required Validation Errors";
			return response()->json($ret, $ret['statusCode']);
		}
		else{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {
				$order = Order::where('order_id',$request->order_id)->first();

				$orderitems = DB::table('orderlists')
	                ->join('products','products.id','orderlists.item_id')
	                ->select('orderlists.*','products.name as itemname')
	                ->where('orderlists.order_id',$request->order_id)
	                ->get();

	            
	            //print_r($order_summary);
	            //exit();

	            foreach ($orderitems as $orderitem) {
	            	if ($orderitem->customize_image != NULL) {
	            		$product_image = CustomizeImage::where('id',$orderitem->customize_image)->first();
	            		$orderitems_arr[] = array(
			        		'itemname' => $orderitem->itemname,
			        		'mrp_price'=>$orderitem->item_mrp_price,
			        		'selling_price' => $orderitem->item_selling_price,
			        		'image' => url('/')."/uploads/customized/".@$product_image->image,
			        	);
	            	}
	            	else{
	            		$product_image = ProductImage::where('product_id',$orderitem->item_id)->where('is_featured',1)->first();
	            		$orderitems_arr[] = array(
			        		'itemname' => $orderitem->itemname,
			        		'mrp_price'=>$orderitem->item_mrp_price,
			        		'selling_price' => $orderitem->item_selling_price,
			        		'image' => url('/')."/uploads/product/".@$product_image->images,
			        	);
	            	}
	            	

	            	
	            }

	            if ($order->payment_type == "cod") {
            		$payment_type = "Cash On Delivery";
            	}
            	else{
            		$payment_type = "Online";
            	}

            	$orderstatus = array(
					array(
						"title" => "Order Received"
					),
					array(
						"title" => "Order Preparing",
					),
					array(
						"title" => "On the way",
					),
					array(
						"title" => "Delivered",
					),
				);

				$current_status = 1;
				if ($order->status == "order_received") {
					$current_status = 1;
				}
				if ($order->status == "order_preparing") {
					$current_status = 2;
				}
				if ($order->status == "ontheway") {
					$current_status = 3;
				}
				if ($order->status == "delivered") {
					$current_status = 4;
				}
				if ($order->status == "cancelled") {
					$current_status = 5;
				}
				$orderAddress = Address::where('id',$order->user_address_id)->first();
				if (isset($orderAddress)) {
					$order_summary_arr = array(
		        		'order_id'=>$order->order_id,
		        		'order_price'=>$order->order_price,
		        		'payable_price'=>$order->payable_price,
		        		'delivery_charge'=>$order->delivery_charge,
		        		'coupon_discount'=>$order->coupon_amount,
		        		'cbcoin_discount'=>$order->cbcoin_amount,
		        		'used_cbcoin'=>$order->cbcoin_amount*2,
		        		'orderstatus'=>$orderstatus,
		        		'current_status'=>$current_status,
		        		'payment_type' => $payment_type,
		        		'name' => $orderAddress->name,
		        		'email' => $orderAddress->email,
		        		'phone' => $orderAddress->phone,
		        		'address' => $orderAddress->location,
		        		'additional_address' => $orderAddress->additional_address,
		        		'address_type' => $orderAddress->address_type,
		        		'pincode' => $orderAddress->pincode,
		        	);
				}
				else{
					$orderAddress = array();
					$order_summary_arr = array(
		        		'order_id'=>$order->order_id,
		        		'order_price'=>$order->order_price,
		        		'payable_price'=>$order->payable_price,
		        		'delivery_charge'=>$order->delivery_charge,
		        		'coupon_discount'=>$order->coupon_amount,
		        		'cbcoin_discount'=>$order->cbcoin_amount,
		        		'used_cbcoin'=>$order->cbcoin_amount*2,
		        		'orderstatus'=>$orderstatus,
		        		'current_status'=>$current_status,
		        		'payment_type' => $payment_type,
		        		'name' => NULL,
		        		'email' => NULL,
		        		'phone' => NULL,
		        		'address' => NULL,
		        		'additional_address' => NULL,
		        		'address_type' => NULL,
		        		'pincode' => NULL,
		        	);
				}
	            

	            $orderdetails = array(
	            	"order_summary" => $order_summary_arr,
					"orderitems" => $orderitems_arr,
				);

	            $ret['orderdetails'] = $orderdetails;
	            $ret['status'] = "success";
        		$ret['statusCode'] = (string) 200;
        		$ret['message'] = "Access Token Mismatched";
        		return $ret;
			}
			else{
				$ret['status'] = "failure";
        		$ret['statusCode'] = (string) 200;
        		$ret['message'] = "Access Token Mismatched";
        		return $ret;
			}	
		}
	}

	public function myCoins(Request $request)
    {
    	$totalPlusCoin = $totalMinusCoin = $ret = $coins_arr = array();
		$validator = Validator::make($request->all(), [
          	'access_token' => 'required',
          	'type' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user)
			{
				$coins = Cbcoin::where('user_id',$user->id)->get();
				if (count($coins)) {
					$plusCoins = Cbcoin::where('user_id',$user->id)->where('type','PLUS')->where('status',1)->get();
		        	$minusCoins = Cbcoin::where('user_id',$user->id)->where('type','MINUS')->where('status',3)->get();
		        	if (count($plusCoins) > 0) {
			        	foreach ($plusCoins as $plusCoin) {
				            $totalPlusCoin[] = $plusCoin->coins;
				        }
			        }
		        	if (count($minusCoins) > 0) {
			            foreach ($minusCoins as $minusCoin) {
			                $totalMinusCoin[] = $minusCoin->coins;
			            }
			        }
			        foreach ($coins as $coin) {
			        	$order = Order::where('order_id',$coin->order_id)->first();
	                    if (isset($order)) {
	                        $order_price = $order->order_price;
	                    }
	                    else{
	                        $order_price = "SIGNUP BONOUS";
	                    }

	                    if($coin->status == 0){
	            			$status = "Expired";
	                    }
	            		else if($coin->status == 1){
	            			$status = "Active";
	            		}
	            		else if($coin->status == 2){
	            			$status = "Comming Soon";
	            		}
	            		else if($coin->status == 3){
	            			$status = "Used";
	            		}
	            		if ($coin->type == "PLUS") {
	            			$type = "+";
	            		}
	            		else if ($coin->type == "MINUS") {
	            			$type = "-";
	            		}

			        	$coins_arr[] = array(
			        		'coins' => $coin->coins,
			        		'order_id' => $coin->order_id,
			        		'status' => $status,
			        		'type' => $type,
			        		'received_on' => Carbon::parse($coin->created_at)->format('jS M Y'),
			        		'expire_on' => Carbon::parse($coin->expiry_at)->format('jS M Y')
			        	);
			        }
			        if ($request->type == "allcoins") {
						$ret['avilableCoins'] = array_sum($totalPlusCoin) - array_sum($totalMinusCoin);
						$ret['coins'] = $coins_arr;
						$ret['status'] = "success";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "All Coins";
						return response()->json($ret, $ret['statusCode']);
				    }
			        else if ($request->type == "avilableCoins") {
						$ret['avilableCoins'] = array_sum($totalPlusCoin) - array_sum($totalMinusCoin);
						$ret['paisa'] = (array_sum($totalPlusCoin) - array_sum($totalMinusCoin))*CBCOIN_PAISA;
						$ret['delivery_charge'] = 50;
						$ret['status'] = "success";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "All Coins";
						return response()->json($ret, $ret['statusCode']);
			        }
			        else{
			        	$ret['status'] = "failure";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "Type Error !!!";
						return $ret;
			        }

				}
		
		        else{
		        	$ret['status'] = "failure";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "No Coins";
					return $ret;
		        }
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;

			}
		}
    }

    public function payment(Request $request)
	{
		$ret = array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
			'razorpay_signature' => 'required',
			'razorpay_payment_id' => 'required',
			'razorpay_order_id' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 422;
			$ret['status'] = "failure";
			$ret['message'] = "Required Validation Errors";
			return response()->json($ret, $ret['statusCode']);
		}
		else{
			$access_token = $request->access_token;
			$validate = User::where('access_token',$access_token)->first();
			if ($validate) {
				$user_id = $validate->id;
				$razorpay_order_id = $request->razorpay_order_id;
				$order = Order::where('razorpay_order_id',$razorpay_order_id)->first();
				if ($order) {
					$order->razorpay_signature = $request->razorpay_signature;
					$order->razorpay_payment_id = $request->razorpay_payment_id;
					$api = new Api(config('custom.razor_key'), config('custom.razor_secret'));
					$payment = $api->payment->fetch($request->razorpay_payment_id);
					if(($payment['status']=='captured' && $request->razorpay_payment_id==$payment['id']) && ($payment['amount'] / 100) == $order->payable_price){                  
						$order->payment_status = "success";
						$ret['status'] = "success";
					    $ret['message'] = "Payment Successful";
					}else {
						$order->payment_status = "failed";
						$ret['status'] = "failure";
					    $ret['message'] = "Payment Failed";
					}
					$order->save();
					$ret['txnid'] = $order->id;
					$ret['order_id'] = $order->order_id;
					$ret['statusCode'] = (string) 200;					
					return response()->json($ret, $ret['statusCode']);
				}
				else{
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "failure";
					$ret['message'] = "Order Id Not Found";
					return response()->json($ret, $ret['statusCode']);
				}
			}
			else{
				$ret['status'] = "failure";
        		$ret['statusCode'] = (string) 200;
        		$ret['message'] = "Access Token Mismatched";
        		return $ret;
			}
		}
	}

	public function subcategory(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
			'subcategory_id' => 'required',
			'access_token' => 'required',
			'type' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {

				if ($request->type == "delivery") {
					$checkCategory = Category::where('id',$request->subcategory_id)->first();

		        	if ($checkCategory) {
		        		$category_id = $checkCategory->id;
				        $products = Product::whereNull('parent_product_id')->where('subcategory_id',$category_id)->where('steps_completed',3)->get();
		        		if (count($products)>0){
		        			foreach ($products as $product) {
			        			$product_price = ProductPrice::where('product_id',$product->id)->where('show_price',1)->first();
			        			$product_image = ProductImage::where('product_id',$product->id)->where('is_featured',1)->first();
			        			$customize = \App\Models\ProductImage::where('product_id',$product->id)->where('customize',1)->first();

			        			if (isset($customize->customize)) {
									$is_customize = "yes";
								}
								else{
									$is_customize = "no";
								}

			        			
			        			$allratings = ProductRating::where('product_id',$product->id)->get();
			        			
			        			$discountPrice = $product_price->mrp_price - $product_price->price;
								$discountPercentage = ($product_price->price / $product_price->mrp_price)*100;
			        			$totalRating = array();
			        			foreach ($allratings as $allrating) {
			        				$totalRating[] = $allrating->rating;
			        			}
			        			$totalRatingcount = count($allratings);
			        			if ($totalRatingcount != 0) {
			        				$prductRating = array_sum($totalRating) / $totalRatingcount;
			        			}
			        			else{
			        				$prductRating = 0;
			        			}

			        			$product_arr[] = array(
			        				'id'=>$product->id,
					                'name'=>$product->name,
					                'mrp_price'=>$product_price->mrp_price,
					                'selling_price' => $product_price->price,
					                'discount_price'=> $discountPrice,
					                'discount_percentage' => 100-round($discountPercentage),
									'image'=> url('/')."/uploads/product/".@$product_image->images,
									'is_customize' => $is_customize,
									'customize' => url('/')."/uploads/product/".@$customize->images,
									'rating'=> round($prductRating, 1),
			        			);
			        		}
		        		}
		        		else{
		        			$product_arr = array();
		        		}
			    		
			    
			        	$ret = array();
						$ret['products'] = $product_arr;
						$ret['status'] = "success";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "All products";
						return $ret;
					}
					else{
						$ret['status'] = "failure";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "SubCategory Id not found !";
						return $ret;
					}
				}

				else if ($request->type == "takeaway") {
					$checkCategory = Category::where('id',$request->subcategory_id)->first();

		        	if ($checkCategory) {
		        		$category_id = $checkCategory->id;

				        $products = Product::wherenotNull('parent_product_id')->where('subcategory_id',$category_id)->where('products.store_id',$request->store_id)->where('steps_completed',3)->get();

		        		if (count($products)>0){
		        			foreach ($products as $product) {

			        			$product_price = ProductPrice::where('product_id',$product->parent_product_id)->where('show_price',1)->first();
			        			$product_image = ProductImage::where('product_id',$product->parent_product_id)->where('is_featured',1)->first();
			        			$customize = \App\Models\ProductImage::where('product_id',$product->parent_product_id)->where('customize',1)->first();
			        			if (isset($customize->customize)) {
									$is_customize = "yes";
								}
								else{
									$is_customize = "no";
								}
			        			
			        			$allratings = ProductRating::where('product_id',$product->id)->get();
			        			
			        			$discountPrice = $product_price->mrp_price - $product_price->price;
								$discountPercentage = ($product_price->price / $product_price->mrp_price)*100;
			        			$totalRating = array();
			        			foreach ($allratings as $allrating) {
			        				$totalRating[] = $allrating->rating;
			        			}
			        			$totalRatingcount = count($allratings);
			        			if ($totalRatingcount != 0) {
			        				$prductRating = array_sum($totalRating) / $totalRatingcount;
			        			}
			        			else{
			        				$prductRating = 0;
			        			}

			        			$product_arr[] = array(
			        				'id'=>$product->id,
					                'name'=>$product->name,
					                'mrp_price'=>$product_price->mrp_price,
					                'selling_price' => $product_price->price,
					                'discount_price'=> $discountPrice,
					                'discount_percentage' => 100-round($discountPercentage),
									'image'=> url('/')."/uploads/product/".@$product_image->images,
									'is_customize' => $is_customize,
									'customize' => url('/')."/uploads/product/".@$customize->images,
									'rating'=> round($prductRating, 1),
			        			);
			        		}
		        		}
		        		else{
		        			$product_arr = array();
		        		}

			        	$ret = array();
						$ret['products'] = $product_arr;
						$ret['status'] = "success";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "All products";
						return $ret;
					}
					else{
						$ret['status'] = "failure";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "SubCategory Id not found !";
						return $ret;
					}
				}

				else{
					$ret['status'] = "failure";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "Type Error !";
					return $ret;

				}
				
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;

			}
		}
    }

    public function allCakes(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
			'type' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {

				if ($request->type == "delivery") {
			        $products = Product::whereNull('parent_product_id')->where('category_id',1)->where('steps_completed',3)->get();
	        		if (count($products)>0){
	        			foreach ($products as $product) {
		        			$product_price = ProductPrice::where('product_id',$product->id)->where('show_price',1)->first();
		        			$product_image = ProductImage::where('product_id',$product->id)->where('is_featured',1)->first();
		        			$customize = \App\Models\ProductImage::where('product_id',$product->id)->where('customize',1)->first();
		        			if (isset($customize->customize)) {
								$is_customize = "yes";
							}
							else{
								$is_customize = "no";
							}
		        			
		        			$allratings = ProductRating::where('product_id',$product->id)->get();
		        			
		        			$discountPrice = $product_price->mrp_price - $product_price->price;
							$discountPercentage = ($product_price->price / $product_price->mrp_price)*100;
		        			$totalRating = array();
		        			foreach ($allratings as $allrating) {
		        				$totalRating[] = $allrating->rating;
		        			}
		        			$totalRatingcount = count($allratings);
		        			if ($totalRatingcount != 0) {
		        				$prductRating = array_sum($totalRating) / $totalRatingcount;
		        			}
		        			else{
		        				$prductRating = 0;
		        			}

		        			$product_arr[] = array(
		        				'id'=>$product->id,
				                'name'=>$product->name,
				                'mrp_price'=>$product_price->mrp_price,
				                'selling_price' => $product_price->price,
				                'discount_price'=> $discountPrice,
				                'discount_percentage' => 100-round($discountPercentage),
								'image'=> url('/')."/uploads/product/".@$product_image->images,
								'is_customize' => $is_customize,
								'customize' => url('/')."/uploads/product/".@$customize->images,
								'rating'=> round($prductRating, 1),
		        			);
		        		}
	        		}
	        		else{
	        			$product_arr = array();
	        		}
		    		
		        	$ret = array();
					$ret['products'] = $product_arr;
					$ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "All CakeProducts";
					return $ret;
				}

				else if ($request->type == "takeaway") {
			        $products = Product::wherenotNull('parent_product_id')->where('category_id',1)->where('products.store_id',$request->store_id)->where('steps_completed',3)->get();

	        		if (count($products)>0){
	        			foreach ($products as $product) {

		        			$product_price = ProductPrice::where('product_id',$product->parent_product_id)->where('show_price',1)->first();
		        			$product_image = ProductImage::where('product_id',$product->parent_product_id)->where('is_featured',1)->first();
		        			$customize = \App\Models\ProductImage::where('product_id',$product->parent_product_id)->where('customize',1)->first();

		        			if (isset($customize->customize)) {
								$is_customize = "yes";
							}
							else{
								$is_customize = "no";
							}
		        			$allratings = ProductRating::where('product_id',$product->id)->get();
		        			
		        			$discountPrice = $product_price->mrp_price - $product_price->price;
							$discountPercentage = ($product_price->price / $product_price->mrp_price)*100;
		        			$totalRating = array();
		        			foreach ($allratings as $allrating) {
		        				$totalRating[] = $allrating->rating;
		        			}
		        			$totalRatingcount = count($allratings);
		        			if ($totalRatingcount != 0) {
		        				$prductRating = array_sum($totalRating) / $totalRatingcount;
		        			}
		        			else{
		        				$prductRating = 0;
		        			}

		        			$product_arr[] = array(
		        				'id'=>$product->id,
				                'name'=>$product->name,
				                'mrp_price'=>$product_price->mrp_price,
				                'selling_price' => $product_price->price,
				                'discount_price'=> $discountPrice,
				                'discount_percentage' => 100-round($discountPercentage),
								'image'=> url('/')."/uploads/product/".@$product_image->images,
								'is_customize' => $is_customize,
								'customize' => url('/')."/uploads/product/".@$customize->images,
								'rating'=> round($prductRating, 1),
		        			);
		        		}
	        		}
	        		else{
	        			$product_arr = array();
	        		}

		        	$ret = array();
					$ret['products'] = $product_arr;
					$ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "All subcategoryProducts";
					return $ret;
				}

				else{
					$ret['status'] = "failure";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "Type Error !";
					return $ret;

				}
				
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;

			}
		}
    }

    public function getTestimonials(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {
				$testimonial_array = array();
				$testimonials = Testimonial::where('show_in_app_home','yes')->get();
        		if (count($testimonials)){
        			foreach ($testimonials as $testimonial) {        			
	        			$testimonial_array[] = array(
	        				'id'=>$testimonial->id,
			                'title'=>$testimonial->title,
			                'description'=>$testimonial->description,
			                'image' =>  url('/')."/uploads/testimonials/".@$testimonial->image,
	        			);
        			}
        		}
	        	$ret = array();
				$ret['testimonials'] = $testimonial_array;
				$ret['status'] = "success";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "All Testimonials";
				return $ret;
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;

			}
		}
    }

    public function subscribeNewsLetter(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
			'email' => 'required'
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {
				$checkEmail = Newsletter::where('email',$request->email)->first();
			    if ($checkEmail) {
			        $ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "Already Subscribed";
					return $ret;
			    }
			    else{
			        $email = new Newsletter;
			        $email->email = $request->email;
			        $email->save();
			        $ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "Thank You For Subscribing";
					return $ret;
			    }
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;

			}
		}
    }

    public function subscribeNewsLetter1(Request $request)
    {
    	$ret = array();

		$validator = Validator::make($request->all(), [
			'access_token' => 'required',
			'email' => 'required'
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{
			$access_token = $request->access_token;
			$user = User::where('access_token',$access_token)->first();
			if ($user) {
				$checkEmail = Newsletter::where('email',$request->email)->first();
			    if ($checkEmail) {
			        $ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "Already Subscribed";
					return $ret;
			    }
			    else{
			        $email = new Newsletter;
			        $email->email = $request->email;
			        $email->save();
			        $ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "Thank You For Subscribing";
					return $ret;
			    }
			}
			else{
				$ret['status'] = "failure";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "Access Token Mismatched !";
				return $ret;

			}
		}
    }

 //    public function deliverysignUp(Request $request)
	// {
	// 	// echo 'hello';
	// 	$ret = array(); 
	// 	$validator = Validator::make($request->all(), [
	// 		"name" => 'required|string|max:191',
 //            "email" => 'required|string|email|max:191|unique:users',
 //            "password" => 'required|string|min:6',
	// 		'phone' => 'required|max:10',
	// 	]);

	// 		$validateEmail = Employee::where('email',$request->email)->first();
	// 		$validatePhone = Employee::where('phone',$request->phone)->first();
	// 		if ($validatePhone) 
	// 		{
	// 			$ret['user_id'] = $validatePhone->id;
	// 			$ret['statusCode'] = (string) 200;
	// 			$ret['status'] = "success";
	// 			$ret['message'] = "Phone number already registered with us, please try another phone number";				
	// 			return response()->json($ret, $ret['statusCode']);
	// 		}
	// 		else if ($validateEmail) 
	// 		{
	// 			$ret['user_id'] = $validateEmail->id;
	// 			$ret['statusCode'] = (string) 200;
	// 			$ret['status'] = "success";
	// 			$ret['message'] = "Email already registered with us, please try another email";				
	// 			return response()->json($ret, $ret['statusCode']);
	// 		}
	// 		else
	// 		{
	// 			// $otp_code = mt_rand(100000, 999999);
	// 			$user = new Employee;
	// 			$user->name = $request->name;
	// 			$user->email = $request->email;
	// 			$user->phone = $request->phone;
	// 			$user->password = $request->password;
	// 			$user->access_token = md5(uniqid(rand().time(), true));
	// 			// $user->last_used_platform = "APP";
	// 			// $user->has_verified = 1;
	// 			// $user->otp = $otp_code;
	// 			$user->save();
 				
 				
				
	// 			if (isset($user->id)) 
	// 			{
	// 				$user = Employee::where('id','=',$user->id)->first();
	// 				$ret['user_id'] = $user->id;
	// 				$ret['user_name'] = $user->name;
	// 				$ret['access_token'] = $user->access_token;
	// 				$ret['statusCode'] = (string) 200;
	// 				$ret['status'] = "success";
	// 				$ret['message'] = "User Signed Up";
	// 				// $ret['has_verified'] = $user->has_verified;
	// 				return response()->json($ret, $ret['statusCode']);
	// 			}
	// 			else
	// 			{
	// 				$ret['statusCode'] = (string) 200;
	// 				$ret['status'] = "failure";
	// 				$ret['message'] = "Something went wrong";
	// 				return response()->json($ret, $ret['statusCode']);
	// 			}
	// 		}
	// }



    // public function deliverylogin2(Request $request){

    //     $validator = Validator::make($request->all(), [
                
    //             'email' => 'required|max:255',
    //             'password' => 'required',
    //             //'remember_me' => 'boolean'
    //         ]);
    //     if ($validator->fails())
    //         {
    //             return response()->json([
    //                 "error" => "Validation Errors",
    //                 //'statusCode' => (string) 500,
    //                 'status' => 'failure',
    //                 "validationErrors" => $validator->errors()
    //             ]);
    //         }

    //     try {
            
    //         $credentials = request(['email', 'password']);
    //         if(!Employee::attempt($credentials)){
    //             return response()->json([
    //                 //'statusCode' => (string) 401,
    //                 'status' => 'failure',
    //                 'message' => 'User name Password Mismatched!'
    //             ], 401);
    //         }else{
    //             $user = $request->user();
    //             if($user->hasVerifiedEmail()){ 
    //                 // $tokenResult = $user->createToken('Personal Access Token');
    //                 // $token = $tokenResult->token;
    //                 // if ($request->remember_me){
    //                 //     $token->expires_at = Carbon::now()->addWeeks(1);
    //                 //     $token->save();
    //                 // }
    //                     return response()->json([
    //                         //'statusCode' => (string) 200,
    //                         'status' => 'success',
    //                         'login' => 'ACTIVE',
    //                         // 'access_token' => $tokenResult->accessToken,
                            
    //                         'user' => Auth::user()
    //                     ]);
    //             }
    //         }
           
    //     } catch (Exception $e) {
    //          return response()->json([//'statusCode' => (string) 400, 
    //             'status' => 'failure','error' => $e->getMessage()]);
    //     }
    // }

    

	public function deliverylogin(Request $request)
	{
		
		$ret = array();

		$validator = Validator::make($request->all(), [
			'email' => 'required',
			// "password" => 'required',
			// 'type' => 'required',
		]);

		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else
		{		
			if(is_numeric($request->email)){
					$user = Employee::where('phone',$request->email)->where('password',bcrypt($request->password))->first();
				}

				elseif (filter_var($request->email, FILTER_VALIDATE_EMAIL)) {
					//$user = Employee::where('email',$request->email)->where('password',bcrypt($request->password))->first();
					if(Auth::guard('employee')->attempt($request->only('email','password'),$request->filled('remember'))){
						$user = Employee::where('email',$request->email)->first();
						$ret['user_id'] = $user->id;
						$ret['name'] = $user->name;
						$ret['email'] = $user->email;
						$ret['phone'] = $user->phone;
						$ret['statusCode'] = (string) 200;
						$ret['status'] = "success";
						$ret['message'] = "Logged In";					
						return response()->json($ret, $ret['statusCode']);
					}
					else
					{
					$ret['statusCode'] = (string) 200;			

					$ret['status'] = "failure";
					$ret['message'] = "Your login details is incorrect, please enter correct password";
					return response()->json($ret, $ret['statusCode']);
					}
				}

								
				/*
				if ($user) 
				{
					
					$ret['user_id'] = $user->id;
					// $ret['access_token'] = $user->access_token;
					$ret['statusCode'] = (string) 200;
					$ret['status'] = "success";
					$ret['message'] = "Logged In";					
					return response()->json($ret, $ret['statusCode']);
				}
				else
				{
					$ret['statusCode'] = (string) 200;			

					$ret['status'] = "failure";
					$ret['message'] = "Your login details is incorrect, please enter correct password";
					return response()->json($ret, $ret['statusCode']);
				}
			
*/
			

			
 		}
	

	}

	public function upcomingdelivery(Request $request){
		$ret = $orders = array();

		$validator = Validator::make($request->all(), [
			'userid' => 'required',			
		]);
		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else{
				
			$order = Order::where('assignto',$request->userid)->where('status','!=','delivered')->where('status','!=','cancelled')->get();	
			// $order = Order::where('assignto',$request->userid)->get();	
			if (count($order) > 0) {
					foreach ($order as $orderdetails) {
						$orders[] = array(
							'id'=> $orderdetails->id,
							'order_price'=> $orderdetails->order_price,
							'payable_price'=> $orderdetails->payable_price,
							'coupon_amount'=> $orderdetails->coupon_amount,
							'delivery_charge'=> $orderdetails->delivery_charge,
							'cbcoin_amount'=> $orderdetails->cbcoin_amount,
							'coupon_id'=> $orderdetails->coupon_id,
							'coupon_code'=> $orderdetails->coupon_code,
							'order_id'=> $orderdetails->order_id,
							'user_id'=> $orderdetails->user_id,
							'user_address_id'=> $orderdetails->user_address_id,
							'type'=> $orderdetails->type,
							'store_id'=> $orderdetails->store_id,
							'takeaway_to_delivery'=> $orderdetails->takeaway_to_delivery,
							'assignto'=> $orderdetails->assignto,
							'status'=> $orderdetails->status,
							'payment_type'=> $orderdetails->payment_type,
							'payment_status'=> $orderdetails->payment_status,
							'delivered_date'=> $orderdetails->delivered_date,
							'txnid'=> $orderdetails->txnid,
							'razorpay_signature'=> $orderdetails->razorpay_signature,
							'razorpay_payment_id'=> $orderdetails->razorpay_payment_id,
							'amount_paid'=> $orderdetails->amount_paid,
							'deliveryboy_id'=> $orderdetails->deliveryboy_id,
							'created_at'=> $orderdetails->created_at,
							'countdowm_time'=> $orderdetails->countdowm_time,
							'order_made_action_on'=> $orderdetails->order_made_action_on,
							'action_type'=> $orderdetails->action_type,
							'updated_at'=> $orderdetails->updated_at,
						);
					}

					

                    $ret['ordersDetails'] = $orders;
					$ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "All orders are here";
					return $ret;	
           		}
	           		else{
						$ret['status'] = "failure";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "Order not found";
						return $ret;
					}
				}

		}

	
	public function cancelleddelivery(Request $request)
	{
			$ret = $orders = array();

		$validator = Validator::make($request->all(), [
			'userid' => 'required',			
		]);
		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else{
				
			$order = Order::where('assignto',$request->userid)->where('status','=','cancelled')->get();	
			// $order = Order::where('assignto',$request->userid)->get();	
		if (count($order) > 0) {
					foreach ($order as $orderdetails) {
						$orders[] = array(
							'id'=> $orderdetails->id,
							'order_price'=> $orderdetails->order_price,
							'payable_price'=> $orderdetails->payable_price,
							'coupon_amount'=> $orderdetails->coupon_amount,
							'delivery_charge'=> $orderdetails->delivery_charge,
							'cbcoin_amount'=> $orderdetails->cbcoin_amount,
							'coupon_id'=> $orderdetails->coupon_id,
							'coupon_code'=> $orderdetails->coupon_code,
							'order_id'=> $orderdetails->order_id,
							'user_id'=> $orderdetails->user_id,
							'user_address_id'=> $orderdetails->user_address_id,
							'type'=> $orderdetails->type,
							'store_id'=> $orderdetails->store_id,
							'takeaway_to_delivery'=> $orderdetails->takeaway_to_delivery,
							'assignto'=> $orderdetails->assignto,
							'status'=> $orderdetails->status,
							'payment_type'=> $orderdetails->payment_type,
							'payment_status'=> $orderdetails->payment_status,
							'delivered_date'=> $orderdetails->delivered_date,
							'txnid'=> $orderdetails->txnid,
							'razorpay_signature'=> $orderdetails->razorpay_signature,
							'razorpay_payment_id'=> $orderdetails->razorpay_payment_id,
							'amount_paid'=> $orderdetails->amount_paid,
							'deliveryboy_id'=> $orderdetails->deliveryboy_id,
							'created_at'=> $orderdetails->created_at,
							'countdowm_time'=> $orderdetails->countdowm_time,
							'order_made_action_on'=> $orderdetails->order_made_action_on,
							'action_type'=> $orderdetails->action_type,
							'updated_at'=> $orderdetails->updated_at,
						);
				}

					

                    $ret['ordersDetails'] = $orders;
					$ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "All orders are here";
					return $ret;	
           		}
	           		else{
						$ret['status'] = "failure";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "Order not found";
						return $ret;
					}
				}
		}

	public function pastdelivery(Request $request){
			$ret = $orders = array();

		$validator = Validator::make($request->all(), [
			'userid' => 'required',			
		]);
		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else{
				
			$order = Order::where('assignto',$request->userid)->where('status','=','delivered')->get();	
			// $order = Order::where('assignto',$request->userid)->get();	
			if (count($order) > 0) {
					foreach ($order as $orderdetails) {
						$orders[] = array(
							'id'=> $orderdetails->id,
							'order_price'=> $orderdetails->order_price,
							'payable_price'=> $orderdetails->payable_price,
							'coupon_amount'=> $orderdetails->coupon_amount,
							'delivery_charge'=> $orderdetails->delivery_charge,
							'cbcoin_amount'=> $orderdetails->cbcoin_amount,
							'coupon_id'=> $orderdetails->coupon_id,
							'coupon_code'=> $orderdetails->coupon_code,
							'order_id'=> $orderdetails->order_id,
							'user_id'=> $orderdetails->user_id,
							'user_address_id'=> $orderdetails->user_address_id,
							'type'=> $orderdetails->type,
							'store_id'=> $orderdetails->store_id,
							'takeaway_to_delivery'=> $orderdetails->takeaway_to_delivery,
							'assignto'=> $orderdetails->assignto,
							'status'=> $orderdetails->status,
							'payment_type'=> $orderdetails->payment_type,
							'payment_status'=> $orderdetails->payment_status,
							'delivered_date'=> $orderdetails->delivered_date,
							'txnid'=> $orderdetails->txnid,
							'razorpay_signature'=> $orderdetails->razorpay_signature,
							'razorpay_payment_id'=> $orderdetails->razorpay_payment_id,
							'amount_paid'=> $orderdetails->amount_paid,
							'deliveryboy_id'=> $orderdetails->deliveryboy_id,
							'created_at'=> $orderdetails->created_at,
							'countdowm_time'=> $orderdetails->countdowm_time,
							'order_made_action_on'=> $orderdetails->order_made_action_on,
							'action_type'=> $orderdetails->action_type,
							'updated_at'=> $orderdetails->updated_at,
						);
					}

					

                    $ret['ordersDetails'] = $orders;
					$ret['status'] = "success";
					$ret['statusCode'] = (string) 200;
					$ret['message'] = "All orders are here";
					return $ret;	
           		}
	           		else{
						$ret['status'] = "failure";
						$ret['statusCode'] = (string) 200;
						$ret['message'] = "Order not found";
						return $ret;
					}
				}
		}
	public function orderDetail(Request $request){
		$ret = $orders = array();

		$validator = Validator::make($request->all(), [
			'order_id' => 'required',			
		]);
		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else{
				
			

			$order = Order::where('order_id',$request->order_id)->first();
$orderitems = DB::table('orderlists')
	                ->join('products','products.id','orderlists.item_id')
	                ->select('orderlists.*','products.name as itemname')
	                ->where('orderlists.order_id',$request->order_id)
	                ->get();

 $orderAddress = Address::where('id',$order->user_address_id)->first();
 		foreach ($orderitems as $orderitem) {	            	
	            		$orderitems_arr[] = array(
			        		'itemname' => $orderitem->itemname,
			        		
			        	);
	            	}

				$delivery_Details_arr = array(
					'name' => $orderAddress->name,
	        		'email' => $orderAddress->email,
	        		'phone' => $orderAddress->phone,
	        		'address' => $orderAddress->location,
	        		'additional_address' => $orderAddress->additional_address,
	        		'address_type' => $orderAddress->address_type,
	        		'pincode' => $orderAddress->pincode,
				);

					$order_summary_arr = array(
		        		'order_id'=>$order->order_id,
		        		'order_price'=>$order->order_price,
		        		'payable_price'=> $order->payable_price,
		        		'coupon_amount'=> $order->coupon_amount,
					'delivery_charge'=> $order->delivery_charge,
					'cbcoin_amount'=> $order->cbcoin_amount,
					'coupon_id'=> $order->coupon_id,
					'coupon_code'=> $order->coupon_code,
					'order_id'=> $order->order_id,
					'user_id'=> $order->user_id,
					'user_address_id'=> $order->user_address_id,
					'type'=> $order->type,
					'store_id'=> $order->store_id,
					'takeaway_to_delivery'=> $order->takeaway_to_delivery,
					'assignto'=> $order->assignto,
					'status'=> $order->status,
					'payment_type'=> $order->payment_type,
					'payment_status'=> $order->payment_status,
					'delivered_date'=> $order->delivered_date,
					'txnid'=> $order->txnid,
					'razorpay_signature'=> $order->razorpay_signature,
					'razorpay_payment_id'=> $order->razorpay_payment_id,
					'amount_paid'=> $order->amount_paid,
					'deliveryboy_id'=> $order->deliveryboy_id,
					'created_at'=> $order->created_at,
					'countdowm_time'=> $order->countdowm_time,
					'order_made_action_on'=> $order->order_made_action_on,
					'action_type'=> $order->action_type,
					'updated_at'=> $order->updated_at,
	        		
		        	);
				
				
				$orderdetails = array(
	            	"order_summary" => $order_summary_arr,
					"orderitems" => $orderitems_arr,
					"deliverydetails" => $delivery_Details_arr,
				);
				 // if (count($order) > 0) {
	            $ret['orderdetails'] = $orderdetails;
				$ret['status'] = "success";
				$ret['statusCode'] = (string) 200;
				$ret['message'] = "All orders are here";
				return $ret;	
    //        		}
    //        		else{
				// 	$ret['status'] = "failure";
				// 	$ret['statusCode'] = (string) 200;
				// 	$ret['message'] = "Order not found";
				// 	return $ret;
				// }
				
				}
		}
	public function deliveryorderupdate(Request $request){
		$ret = $orders = array();

		$validator = Validator::make($request->all(), [
			'userid' => 'required',			
			'orderid' => 'required',			
			'status' => 'required',			
		]);
		if ($validator->fails())
		{
			$ret['statusCode'] = (string) 200;
			$ret['status'] = "failure";
			$ret['message'] = $validator->messages();
			return response()->json($ret, $ret['statusCode']);
		}
		else{
				
			$order = Order::where('assignto',$request->userid)			
			->where('order_id',$request->orderid)
			->update([
            'status' => $request->status
        ]);
		if ($order) {
		$ret['status'] = "Success";
		$ret['statusCode'] = (string) 200;
		$ret['message'] = "Status Updated";
		return $ret;	
		}else{
			$ret['status'] = "error";
		$ret['statusCode'] = (string) 200;
		$ret['message'] = "Status not Updated";		
		return $ret;	
		}
			
   		}
   		
		}
		
		

}
