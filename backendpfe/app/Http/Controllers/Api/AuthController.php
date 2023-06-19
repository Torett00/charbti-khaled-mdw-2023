<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use http\Env\Response;
use App\Models\Employe;
use App\Models\Entreprise;
use Illuminate\Http\Request;
use App\Http\Requests\LoginRequest;
use App\Http\Controllers\Controller;
use App\Http\Requests\SignupRequest;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function signup(SignupRequest $request)
    {
        $data = $request->validated();
        /** @var \App\Models\User $user */
        $user = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'role_id'=>$data['role_id'],
            'password' => bcrypt($data['password']),
        ]);

        $token = $user->createToken('main')->plainTextToken;
        return response(compact('user', 'token'));
    }

    public function login(LoginRequest $request)
    {
        $credentials = $request->validated();
        if (!Auth::attempt($credentials)) {
            return response([
                'message' => 'Provided email or password is incorrect'
            ], 422);
        }

        /** @var \App\Models\User $user */
        $user = Auth::user();
        
        $userRole = $user->role->name;
        $iduser = $user->id;
         $iden = Entreprise::where('user_id',$iduser)->value('id');
          
        $token = $user->createToken('main')->plainTextToken;
     
        return response(compact('user', 'token'));
        
    }

    public function logout(Request $request)
    {
        /** @var \App\Models\User $user */
        $user = $request->user();
        $user->currentAccessToken()->delete();
        return response('data is don', 204);
    }
    public function getRoleId(Request $request)
    {
        // Get the authenticated user
        $user = $request->user();

        // Get the role_id of the authenticated user
        $roleId = $user->role_id;

        return response()->json(['role_id' => $roleId]);
    }
}
