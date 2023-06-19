<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use DB;

class UserController extends Controller
{
  public function index()
  {
    return response()->json("rjb");
  }

    public function signup(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|min:2|max:20',
            'email' => 'required|email|unique:users'
        ]);
        if($validated)
        {
            DB::table('users')->insert([
                'name'=>$request->input('name'),
                'email'=>$request->input('email'),
                'password'=>$request->input('password')
            ]);
        }    
    }

    public function login(Request $request) {

        $email = $request->input('email');
        $password = $request->input('password');
        $user = User::where('email', $email)->value('password');

        if (!$user) 
            return response()->json(['success'=>false, 'message' => 'Login Fail, no matches in our database']);

        return response()->json(['success'=>true,'message'=>'We\'ve found a match', 'data' => $user],200);
    }
}
