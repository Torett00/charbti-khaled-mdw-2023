<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\LigneController;
use App\Http\Controllers\Api\EmployeController;
use App\Http\Controllers\Api\StationController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/page/role-id', [AuthController::class, 'getRoleId']);
    Route::middleware(['role:entreprise'])->group(function () {
        Route::apiResource('/stations',StationController::class);

        Route::apiResource('/users', UserController::class);
        Route::apiResource('/lignes', LigneController::class);
    
    });
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
  
});
Route::get('/st', function (Request $request) {
    return $request->station();
});
Route::post('storeline', [LigneController::class,'store']);//ajouterr ligneeee
Route::get('gligne/{ligne}', [LigneController::class,'show']);
Route::get('getuser/{user}',[UserController::class,'show']);
Route::put('putuser/{id}',[UserController::class,'update']);
Route::put('putemploye/{user}',[EmployeController::class,'putemploye']);
Route::get('voyage/{id_lignes}', [LigneController::class,'showlignes']);//affiche ligne
Route::get('getallligne', [LigneController::class,'index']);//agett all
Route::post('employeinf',[EmployeController::class,'newemploye']);
Route::post('entrepriseinf',[EmployeController::class,'newentreprise']);
Route::get('getemploye/{user_id}', [EmployeController::class,'getemploye']);
Route::get('getdate/{voyage_id}/{entreprise}', [LigneController::class,'getdate']);
Route::get('getreserve/{voyage_id},{reservation}', [LigneController::class,'getreservation']);
Route::post('newreserve', [LigneController::class,'newreserve']);//ajouterr reservationnn
Route::put('reserveput/{id}',[LigneController::class,'reserveput']);
Route::put('reserveputetat/{id}',[LigneController::class,'reserveputetat']);

Route::get('getrall/{id}', [LigneController::class,'getrall']);
Route::get('getentreall', [LigneController::class,'getentreall']);
Route::get('getrb/{id}', [LigneController::class,'getrb']);



Route::get('getnameandreserv/{id}', [LigneController::class,'getresandname']);//get namenetreprise and reservation


Route::post('newbillet', [LigneController::class,'newbillet']);
Route::get('billet/{numero}', [LigneController::class,'getbillet']);
Route::put('putbilletetat/{id}',[LigneController::class,'billetputetat']);
Route::get('getvoyage/{voyage_id}', [LigneController::class,'getvoyage']);
Route::get('voyageall',[LigneController::class,'voyageall']);
Route::post('postvoyage', [LigneController::class,'postvoyage']);//ajouterr voyageeee

Route::get('vm/{id_lignes}', [LigneController::class,'getligne']);
Route::get('entre/{id_entre}', [LigneController::class,'getentre']);

Route::post('conji', [EmployeController::class,'conji']);
Route::get('getconji/{etat}',[EmployeController::class,'getconji']);

Route::get('getconjiavecid/{id}',[EmployeController::class,'getconjiwhitid']);//conji avec id just besoin
Route::get('conjiemploye/{id}',[EmployeController::class,'getconji']);
Route::get('conjicheck/{id}',[EmployeController::class,'conjicheck']);
Route::get('getpointage/{id}',[EmployeController::class,'getpointage']);
Route::put('pointe/{id}',[EmployeController::class,'pointe']);
Route::get('getfichedp/{id}',[EmployeController::class,'getfichedp']);
Route::put('fiche/{id}',[EmployeController::class,'fiche']);
Route::post('newfiche/',[EmployeController::class,'newfiche']);
Route::put('rejectconji/{id}',[EmployeController::class,'rejectconji']);
Route::put('accpectconji/{id}',[EmployeController::class,'accpectconji']);
Route::apiResource('/stations',StationController::class);
Route::apiResource('/ligness', LigneController::class);

Route::post('/signup', [AuthController::class, 'signup']);
Route::post('/login', [AuthController::class, 'login']);