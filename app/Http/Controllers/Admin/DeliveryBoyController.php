<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\DeliveryBoy;
use App\Employee;

class DeliveryBoyController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data = Employee::orderBy('id','DESC')->paginate(10);
        return view('admin.delivery-boy.index',compact('data'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('admin.delivery-boy.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required',
            'email' => 'required',
            'phone' => 'required',
            'address' => 'required',
            'education' => 'required',
            'password' => 'required',
        ]);
        // dd($request);exit();
        if (Employee::where('email', '=', $request->email)->count() > 0)
        {
           return back()->with('flash_error', 'Email Already Exists');
        }
        if (Employee::where('phone', '=', $request->phone)->count() > 0)
        {
           return back()->with('flash_error', 'Phone Number Already Exists');
        }
        else
        {
            $user = new Employee();

            $user->name = $request->name;
            $user->email = $request->email;
            $user->phone = $request->phone;
            $user->address = $request->address;
            $user->education = $request->education;
            $user->password = bcrypt($request->password);
             // $user->access_token = md5(uniqid(rand().time(), true));
            $user->save();

            return back()->with('flash_success', 'DeliveryBoy created successfully');
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data = Employee::findOrFail($id);
        return view('admin.delivery-boy.edit',compact('data'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'name' => 'required',
            'email' => 'required',
            'phone' => 'required',
            'address' => 'required',
            'education' => 'required',
            'password' => 'required',
        ]);

        $user = Employee::find($id);

        $user->name = $request->name;
        $user->email = $request->email;
        $user->phone = $request->phone;
        $user->address = $request->address;
        $user->education = $request->education;
        $user->password = bcrypt($request->password);
        $user->save();

        return back()->with('flash_success', 'DeliveryBoy Updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $data = Employee::findOrFail($id);
        $data->delete();
        return back()->with('flash_success', 'DeliveryBoy Deleted Successfully!');
    }

    public function changedeliveryboystatus(Request $request)
    {
        $user = Employee::find($request->user_id);
        $user->status = $request->status;
        $user->save();
  
        return response()->json(['success'=>'Status change successfully.']);
    }
}
