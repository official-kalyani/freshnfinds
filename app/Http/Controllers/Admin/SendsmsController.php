<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use Mail;
use App\Mail\EmailBlast;
//use GuzzleHttp\Client;
use Twilio\Rest\Client;



class SendsmsController extends Controller
{
    public function email()
    {
    	return view('admin.email',compact('users'));
    }
    public function sms()
    {
    	return view('admin.sms');
    }
    public function pushNotofication()
    {
    	return view('admin.push-notification');
    }

    public function sendEmails(Request $request)
    {
        $this->validate($request, [
            'subject' => 'required',
            'desc' => 'required',
        ]);

        $users = User::orderBy('id','DESC')->get();
        foreach ($users as $user) {
            $data = ['message' => 'This is a test!', 'name' => $user->name , 'subject' => $request->subject, 'desc' => $request->desc];;
            Mail::to($user->email)->send(new EmailBlast($data));
        }
        return back()->with('flash_success', 'Emails Send Successfully!');
    }

    public function sendSms(Request $request)
    {
        $this->validate($request, [
            'sms' => 'required',
            'phone' => 'required|regex:/[0-9]/'
        ]);

        $account_sid = getenv("TWILIO_SID");
        $auth_token = getenv("TWILIO_AUTH_TOKEN");
        $twilio_number = getenv("TWILIO_NUMBER");
        $client = new Client($account_sid, $auth_token);
        $phone = "+91".$request->phone;
        $client->messages->create($phone, ['from' => $twilio_number, 'body' => $request->sms] );

        return back()->with('flash_success', 'Message Send Successfully To '.$phone.'');
    }

    public function sendNotification(Request $request)
    {
        $this->validate($request, [
            'notification' => 'required',
        ]);

        return back()->with('flash_success', 'Notification Send Successfully To User !');
    }
}
