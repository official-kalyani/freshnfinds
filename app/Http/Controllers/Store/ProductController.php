<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Category;
use App\Models\ProductPrice;
use App\Models\Occasion;
use Auth;

class ProductController extends Controller
{
    public function index()
    {
        $occasions = Occasion::all();
        $data = Product::wherenotNull('parent_product_id')->where('store_id',Auth::user()->id)->orderBy('id','DESC')->paginate(10);
        return view('shop.products.index',compact('data','occasions'));
    }

    public function create(Request $request)
    {
        $categories = Category::whereNull('parent_id')->get();
        if (isset($request->id) && $request->id !='') {
            $id = $request->id;
            if ($products = Product::where('id',@$id)->where('store_id',Auth::user()->id)->first()) {
                return view('shop.products.create',compact('categories','products')); 
            }
            else{
                abort(404);
            }
            
        }
        
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'stock_quantity' => 'required',
        ]);

        if (isset($request->id) && $request->id !='') {
            $id = $request->id;
            $shop = Product::where('id',$id)->where('store_id',Auth::user()->id)->first();
            $shop->stock_quantity = $request->stock_quantity;
            $shop->save();
            return back()->with('flash_success', 'Stock Quantity Updated Successfully!');
        }

    }

    public function masterProducts()
    {
        $data = Product::whereNull('parent_product_id')->orderBy('id','DESC')->paginate(20);
        $occasions = Occasion::all();
        return view('shop.master-products.index',compact('data','occasions'));
    }

    public function cloneMasterProducts(Request $request)
    {
        $product_id = $request->id;

        $product = Product::find($product_id);

        $newProduct = Product::where('parent_product_id',$product_id)->where('store_id',Auth::user()->id)->first();

        if ($newProduct) {
            return back()->with('flash_danger', 'Product Already Cloned!');
        }
        else{
            $newProduct = new Product;
            $newProduct->name = $product->name;
            $newProduct->description = $product->description;
            $newProduct->category_id = $product->category_id;
            $newProduct->subcategory_id = $product->subcategory_id;
            $newProduct->occasion_id = $product->occasion_id;
            $newProduct->meta_title = $product->meta_title;
            $newProduct->meta_desc = $product->meta_desc;
            $newProduct->slug = $product->slug;
            $newProduct->stock_quantity = 0;
            $newProduct->store_id = Auth::user()->id;
            $newProduct->parent_product_id = $product->id;
            $newProduct->is_customize = $product->is_customize;
            $newProduct->is_photocake = $product->is_photocake;
            $newProduct->steps_completed = $product->steps_completed;
            $newProduct->save();
            return back()->with('flash_success', 'Product Cloned Successfully!');
        }
    }
}
