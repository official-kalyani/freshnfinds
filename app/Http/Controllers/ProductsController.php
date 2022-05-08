<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductPrice;
use App\Models\Category;
use App\Models\ProductImage;
use App\Models\Location;
use App\Models\Occasion;
use App\Models\Section;
use App\Models\ProductRating;
use App\Models\SectionItem;
use App\Models\CustomizeImage;
use App\Models\Order;
use App\Models\CustomizeFlavour;
use App\Models\CustomizeShape;
use App\Models\CustomizeCake;
use App\Models\Slider;
use App\Models\Cbcoin;
use App\Models\CategoryImage;
use App\Models\Blog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Http\Response;
use DB;
use Auth;
use Session;
 
class ProductsController extends Controller
{
   
    public function index(Request $request)
    {
        $categories = Category::whereNull('parent_id')->get();
        $sections = Section::all();
        $sliders = Slider::where('show_in_website_home','yes')->get();
        return view('welcome', compact('categories','sections','sliders'));

    }


    public function categoryWiseProductListing(Request $request, $slug){
        $category = Category::where('slug',$slug)->first();
        $sliders = CategoryImage::where('category_id',$category->id)->get();
        $products = array();
        if (isset($category->id)) {
            $products = DB::table('products')
            ->join('product_images','product_images.product_id','products.id')
            ->where('products.category_id',$category->id)
            ->where('products.steps_completed',3)
            ->where('product_images.is_featured',1)
            ->orderBy('products.id','desc')
            ->select('products.*','product_images.images')->paginate(12);
        }
        return view('listing.category-wise-product-listing',compact('category','products','sliders'));   
    }
   

    public function section(Request $request,$id)
    {

        $section = Section::where('id',$id)->first();
        if ($section) {
            $products = DB::table('products')
            ->join('section_items','section_items.product_id','products.id')
            ->join('product_images','product_images.product_id','products.id')
            ->where('products.steps_completed',3)
            ->where('product_images.is_featured',1)
            ->where('section_items.section_id',$section->id)
            ->orderBy('section_items.id','asc')
            ->select('products.*','product_images.images')->paginate(12);
            return view('listing.section',compact('products','section'));
        }
        else{
            abort('404');
        }
        
    }


    public function productsDetails(Request $request,$slug)
    {
        $id = $request->cookie('store_id');
        $type = $request->cookie('type');                
        if ($slug == "all") 
        {
            $products = DB::table('products')
            ->join('product_images','product_images.product_id','products.id')          
            ->where('product_images.is_featured',1)
            ->where('products.is_active','active')
            ->orderBy('products.id','desc')
            ->select('products.*','product_images.images')->paginate(12);
            return view('listing.allproductsdetail',compact('products'));
        }
        else
        {
            $checkProduct = Product::where('slug',$slug)->where('steps_completed',3)->first();
            $product_id = $checkProduct->id;
            if ($checkProduct) {            
                $product = DB::table('products')
                    ->join('categories','categories.id','products.category_id')          
                    ->where('products.id',$product_id)
                    ->select('products.*','categories.name as cat_name')->first();  
                //$product = Product::find($product_id); 
                $product_first_images = ProductImage::where('product_id',$product_id)->first(); 
                $product_images = ProductImage::where('product_id',$product_id)->get(); 
                $relatedProducts = DB::table('products')
                    ->join('product_images','product_images.product_id','products.id')          
                    ->where('product_images.is_featured',1)
                    ->where('products.category_id',$product->category_id)
                    ->orderBy('products.id','desc')
                    ->select('products.*','product_images.images')->get();
                return view('product-details',compact('product','product_images','product_first_images','relatedProducts'));
            }
            else{
                abort('404');
            }
        }
    }
    

    public function cart(Request $request)
    {
        $store_id = $request->cookie('store_id');
        $type = $request->cookie('type');
          if($type == 'pickup' && $store_id !=''){
                   $addOnProducts = DB::table('products')
                   ->join('product_prices','product_prices.product_id','products.parent_product_id')
                   ->join('product_images','product_images.product_id','products.parent_product_id')
                   ->where('products.steps_completed',3)
                   ->where('products.category_id',43)
                   ->where('product_prices.show_price',1)
                   ->where('product_images.is_featured',1)
                   ->select('products.*','product_prices.price','product_prices.mrp_price', 'product_images.images')
                   ->get();
            } else {
                $addOnProducts = DB::table('products')
                   ->join('product_prices','product_prices.product_id','products.id')
                   ->join('product_images','product_images.product_id','products.id')
                   ->where('products.steps_completed',3)
                   ->where('products.category_id',43)
                   ->where('product_prices.show_price',1)
                   ->where('product_images.is_featured',1)
                   ->select('products.*','product_prices.id as price_id','product_prices.price','product_prices.mrp_price', 'product_images.images')
                   ->get();
            }
        return view('cart', compact('addOnProducts'));
        
    }
    public function addToCart(Request $request,$id)
    {
        $product = Product::find($id);
        if(!$product) {
            abort(404);
        }
        $cart = session()->get('cart');
        // if cart is empty then this the first product
        if(!$cart) {
            $cart = [
                $id => [
                    "id" => $product->id,
                    "quantity" => 1,
                    "price" => $request->price,
                ]
            ];
            session()->put('cart', $cart);
            $htmlCart = view('layouts.sidebar_cart')->render();
            $cartCounter = count((array) session('cart'));
            return response()->json(['msg' => 'Added To Cart!', 'data' => $htmlCart, 'cartCounter' => $cartCounter]);
            //return redirect()->back()->with('success', 'Added To Cart!');
        }

        // if cart not empty then check if this product exist then increment quantity
        if(isset($cart[$id])) {

            $cart[$id]['quantity']++;

            session()->put('cart', $cart);

            $htmlCart = view('layouts.sidebar_cart')->render();
            $cartCounter = count((array) session('cart'));
            return response()->json(['msg' => 'Added To Cart!', 'data' => $htmlCart, 'cartCounter' => $cartCounter]);

            //return redirect()->back()->with('success', 'Added To Cart!');

        }

        // if item not exist in cart then add to cart with quantity = 1
        $cart[$id] = [
            "id" => $product->id,
            "quantity" => 1,
            "price" => $request->price,
        ];

        session()->put('cart', $cart);
        $htmlCart = view('layouts.sidebar_cart')->render();
        $cartCounter = count((array) session('cart'));
        return response()->json(['msg' => 'Added To Cart!', 'data' => $htmlCart, 'cartCounter' => $cartCounter]);

        //return redirect()->back()->with('success', 'Added To Cart!');
    }

    public function addToCartMain(Request $request,$id)
    {
        $product = Product::find($id);
        if(!$product) {
            abort(404);
        }
        $cart = session()->get('cart');
        // if cart not empty then check if this product exist then increment quantity
        if(isset($cart[$id])) {

            $cart[$id]['quantity']++;

            session()->put('cart', $cart);

            $product_price = ProductPrice::where('id',$request->price_id)->where('show_price',1)->first(); 
            $subTotal = $cart[$request->id]['quantity'] * $product_price->price;

            $total = $this->getCartTotal();
            $maincart = view('layouts.maincart')->render();
            $cartCounter = count((array) session('cart'));

            return response()->json(['msg' => 'Cart updated successfully', 'total' => $total, 'subTotal' => $subTotal,'totalPrice'=> $total,'maincart'=>$maincart]);
        }
        // if item not exist in cart then add to cart with quantity = 1
        $cart[$id] = [
            "id" => $product->id,
            "quantity" => 1,
            "price" => $request->price,
        ];

        session()->put('cart', $cart);

        $product_price = ProductPrice::where('id',$request->price_id)->where('show_price',1)->first(); 
        $subTotal = $cart[$request->id]['quantity'] * $product_price->price;

        $total = $this->getCartTotal();
        $maincart = view('layouts.maincart')->render();
        $cartCounter = count((array) session('cart'));

        return response()->json(['msg' => 'Cart updated successfully', 'total' => $total, 'subTotal' => $subTotal,'totalPrice'=> $total,'maincart'=>$maincart]);

        //return redirect()->back()->with('success', 'Added To Cart!');
    }

    public function update(Request $request)
    {
        if($request->id and $request->quantity)
        {
            $cart = session()->get('cart');
            $cart[$request->id]["quantity"] = $request->quantity;
            session()->put('cart', $cart);
            $subTotal = $cart[$request->id]['quantity'] * $request->price;
            $total = $this->getCartTotal();
            $htmlCart = view('layouts.sidebar_cart')->render();
            $maincart = view('layouts.maincart')->render();
            return response()->json(['msg' => 'Cart updated successfully', 'total' => $total, 'subTotal' => $subTotal,'data'=>$htmlCart,'totalPrice'=> $total,'maincart'=>$maincart]);

            //session()->flash('success', 'Cart updated successfully');
        }
    }

    public function remove(Request $request)
    {
        if($request->id) {

            $cart = session()->get('cart');

            if(isset($cart[$request->id])) {

                unset($cart[$request->id]);

                session()->put('cart', $cart);
            }

            $total = $this->getCartTotal();

            $htmlCart = view('layouts.sidebar_cart')->render();
            $maincart = view('layouts.maincart')->render();

            $cartCounter = count((array) session('cart'));
            return response()->json(['msg' => 'Product removed successfully', 'data' => $htmlCart, 'total' => $total,'cartCounter' => $cartCounter,'maincart'=>$maincart]);

            //session()->flash('success', 'Product removed successfully');
        }
    }

    public function clearAll(Request $request)
    {

        $request->session()->flush();

        $htmlCart = view('layouts.app')->render();

        return response()->json(['msg' => 'All Products removed successfully']);
    }


    /**
     * getCartTotal
     *
     *
     * @return float|int
     */
    private function getCartTotal()
    {
        $total = 0;

        $cart = session()->get('cart');

        foreach($cart as $id => $details) {
            $total += $details['price'] * $details['quantity'];
        }
        return $total;
 
    }

    public function cancelOrder(Request $request)
    {
        $orders = Order::where('order_id',$request->order_id)->where('user_id',Auth::user()->id)->first();
        if ($orders->status == "order_confirmed" || $orders->status == "order_preparing" || $orders->status == "ontheway" || $orders->status == "delivered") {
            $arr['status'] = 2;
        }
        else{
            $orders->status = "cancelled";
            $arr['status'] = 1;
            $orders->save();
        }
        return response()->json($arr);
    }

    public function fetchProducts(Request $request)
    {
        if($request->get('query'))
        {
        $query = $request->get('query');
        $searchResults = DB::select("
            (
                SELECT
                    'product' as `type`,
                    `products`.`id` as `id`,
                    `products`.`name` as `name`,
                    `products`.`slug` as `slug`
                FROM `products`
                WHERE
                    `products`.`name` LIKE '%{$query}%'
            )          
            ");

          
        $products_counter = 0;
        $output = '<ul id="cakes-list">';
        foreach($searchResults as $row)
        {
            $products_counter++;

            $output .= '<li><a href="products/'.$row->slug.'">'.$row->name.'</a></li>';
   
        }
          $output .= '</ul>';
          echo $output;
        }
    }

    public function customize(Request $request)
    {
        if (Auth::user()) {
            $customize_shapes = CustomizeShape::all();
            $customize_flavours = CustomizeFlavour::all();
            return view('customize.index',compact('customize_shapes','customize_flavours'));
        } else {
            return redirect()->back();
        }
    }

    public function removeCustomImage(Request $request)
    {
        $customImage = CustomizeImage::where('user_id',Auth::user()->id)->where('product_id',$request->product_id)->first();
        @unlink(public_path('uploads/customized/'.$customImage->image));
        $customImage->delete();
        return redirect()->back();
    }

    public function saveCustomizedImage(Request $request)
    {
        $this->validate($request, [
            'customize_shape_id' => 'required',
            'customize_flavour_id' => 'required',
            'message_on_cake' => 'required',
        ]);
        $c_image = CustomizeImage::where('user_id',Auth::user()->id)->where('product_id',$request->product_id)->first();
        if ($c_image) {
            
        }
        else{
            $c_image = new CustomizeImage;
        }
        if($request->hasfile('photo_cake'))
        {
            @unlink(public_path('uploads/customized/'.$customImage->photo_cake));
            $c_image->delete();
            $file = $request->file('photo_cake');
            $filename = time() . '.' . $file->getClientOriginalExtension($file);
            $filePath = 'uploads/customized/' . $filename;
            $file->move(public_path('uploads/customized'),$filePath); 
            $c_image->photo_cake = $filename;  
        }
        
        $c_image->user_id = Auth::user()->id;
        $c_image->product_id = $request->product_id;
        $c_image->customize_shape_id = $request->customize_shape_id;
        $c_image->customize_flavour_id = $request->customize_flavour_id;
        $c_image->message_on_cake = $request->message_on_cake;
        $c_image->save();
        //return redirect($request->return_url);
        $product = Product::find($request->product_id);
        return redirect('products/'.$product->slug);
        
    }

    // public function rateProduct(Request $request)
    // {
    //     $user_id = Auth::user()->id;
    //     $ratingCheck = ProductRating::where('user_id',$user_id)->where('product_id',$request->product_id)->first();
    //     if ($ratingCheck) {
    //         $ratingCheck->review_text = $request->review_text;
    //         $ratingCheck->rating = $request->rating;
    //         $ratingCheck->save();
    //     }
    //     else{
    //         $rating = new ProductRating;
    //         $rating->product_id = $request->product_id;
    //         $rating->user_id = Auth::user()->id;
    //         $rating->review_text = $request->review_text;
    //         $rating->rating = $request->rating;
    //         $rating->save();
    //     }
        
    //     $arr['status'] = 1;
    //     return response()->json($arr);
    // }

    public function blogListing()
    {
        $blogs = Blog::orderBy('id','DESC')->paginate(10);
        return view('blog.index',compact('blogs')); 
    }

    public function blogDetails($slug)
    {
        $blog = Blog::where('slug',$slug)->first();
        if ($blog) {
            return view('blog.details',compact('blog')); 
        }
        else{
            abort(404);
        }
        
    }

    public function getProductInfo($product_id='', $type='', $product_parent_id='') { // product id

        $product = Product::find($product_id);
        $productId = $type == 'pickup' ? $product_parent_id : $product_id;
        $product_price = ProductPrice::where('product_id',$productId)->where('show_price',1)->first(); 
        $product_image = ProductImage::where('product_id',$productId)->where('is_featured',1)->first(); 
        $customize = ProductImage::where('product_id',$productId)->where('customize',1)->first();
        $discountPrice = $product_price->mrp_price - $product_price->price;
        $discountPercentage = ($product_price->price / $product_price->mrp_price)*100;  
        $product_arr = array(
            'id' => $product->id,
            'parent_product_id' => $product->parent_product_id,
            'name' => $product->name,
            'slug' => $product->slug,
            'product_image' => $product_image->images,
            'price_id' => $product_price->id,
            'price' => $product_price->price,
            'mrp_price' => $product_price->mrp_price,
            'discount' => $discountPercentage,
            'is_customize' => $product->is_customize,
            'customize_images' => @$customize->images
        );
        return $product_arr;
    }
}
