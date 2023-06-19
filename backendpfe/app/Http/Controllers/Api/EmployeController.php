<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Models\Conji;
use App\Models\Ligne;
use App\Models\Voyage;
use App\Models\Employe;
use App\Models\Fichedp;
use App\Models\Pointage;
use App\Models\Entreprise;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Http\Resources\LigneResource;
use App\Http\Requests\AddLigneRequest;
use App\Http\Requests\StoreUserRequest;
use App\Http\Requests\UpdateUserRequest;
use App\Http\Requests\UpdateLigneRequest;

class EmployeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function conji(Request $request)
    {
        $data = new Conji;
        $data->name = $request->input('name');
        $data->reason = $request->input('reason');
        $data->nbrjr = $request->input('nbrjr');
        $data->dateconji = $request->input('date');
        $data->user_id = $request->input('user_id');
        $data->etat = $request->input('etat');
        $data->entreprise_id = $request->input('entreprise_id');
        $data->save();


        
        return response()->json(['message' => 'Data saved successfully']);
    }
    public function getemploye($user_id)
    {
        $employe = Employe::where('user_id', $user_id)->get();
        return response()->json($employe);
    }
    public function getconji($etat)
    {
        $conji = Conji::where('etat',$etat)->get();
        return response()->json($conji);
    }
    public function getconjiwhitid($id)
    {
        $conji = Conji::where('user_id',$id)->get();
        return response()->json($conji);
    }




    public function rejectconji(Request $request, $id)
{
    $reservation = Conji::findOrFail($id);
    
    // Update the number of occupied spots
    $reservation->etat ='Reject conji ';
    $reservation->save();

    // Return a response
    return response()->json(['message' => 'Reservation updated successfully']);
}
public function accpectconji(Request $request, $id)
{
    $reservation = Conji::findOrFail($id);
    
    // Update the number of occupied spots
    $reservation->etat ='accept conji ';
    $reservation->save();

    // Return a response
    return response()->json(['message' => 'Reservation updated successfully']);
}
public function newemploye(Request $request)
{
    $data = new Employe;
    $data->name = $request->input('name');
    $data->telephone = $request->input('telephone');
    $data->adresse = $request->input('adresse');
    $data->poste = $request->input('poste');
    $data->salaire = $request->input('salaire');
    $data->user_id = $request->input('user_id');
    $data->entreprise_id = $request->input('entreprise_id');
    $data->save();

    return response()->json(['message' => 'Data saved successfully']);
}
public function newentreprise(Request $request)
{
    $data = new Entreprise;
    $data->name = $request->input('name');
    $data->pays = $request->input('pays');
    $data->telephone = $request->input('telephone');
    $data->adresse = $request->input('adresse');
    $data->user_id = $request->input('user_id');
    $data->save();

    return response()->json(['message' => 'Data saved successfully']);
}
public function conjicheck($id)
    {
        $conji = Conji::where('user_id',$id)->get();
        return response()->json($conji);
    }
    public function getpointage($id)
    {
        $pointage = Pointage::where('user_id',$id)->get();
        return response()->json($pointage);
    }
    public function pointe(Request $request, $id)
{
    $pointage = Pointage::findOrFail($id);
    $pointage->nombredejour = $request->input('nombredejour'); ;
    
    $pointage->currentjour = $request->input('currentjour');
    $pointage->currentmois = $request->input('currentmois');
   
    $pointage->save();

    // Return a response
    return response()->json(['message' => 'Reservation updated successfully']);
}
public function getfichedp($id)
{
    $pointage = Fichedp::where('user_id',$id)->get();
    return response()->json($pointage);
}
public function fiche(Request $request, $id)
{
    $fiche = Fichedp::findOrFail($id);
    $fiche->nombredejour = $request->input('nombredejour'); ;
    
    $fiche->salaire = $request->input('salaire');
    $fiche->conjirestant = $request->input('conjirestant');
   
    $fiche->save();

    // Return a response
    return response()->json(['message' => 'Reservation updated successfully']);
}
public function newfiche(Request $request)
{
    $data = new Fichedp;
    $data->nombredejour = $request->input('nombredejour');
    $data->salaire = $request->input('salaire');
    $data->conjirestant = $request->input('conjirestant');
    $data->user_id = $request->input('user_id');
    $data->entreprise_id = $request->input('entreprise_id');
    $data->save();

    return response()->json(['message' => 'Data saved successfully']);
}
public function putemploye(Request $request, $id)
{
    $data = Employe::findOrFail($id);
    
    $data->name = $request->input('name');
    $data->telephone = $request->input('telephone');
    $data->adresse = $request->input('adresse');
    $data->poste = $request->input('poste');
    $data->salaire = $request->input('salaire');
  
    $data->save();

    return response()->json(['message' => 'employe updated successfully']);
}
}
