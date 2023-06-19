<?php

namespace App\Http\Controllers\Api;
use Faker\Factory;
use App\Models\User;
use App\Models\Ligne;
use App\Models\billet;
use App\Models\Voyage;
use App\Models\Entreprise;
use App\Models\Reservation;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Http\Resources\LigneResource;
use App\Http\Requests\AddLigneRequest;
use App\Http\Requests\StoreUserRequest;
use App\Http\Requests\UpdateUserRequest;
use Illuminate\Support\Facades\Redirect;
use App\Http\Requests\UpdateLigneRequest;

class LigneController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function showlignes($id_lignes)
    {
        $voyage = Voyage::where('lignes_id', $id_lignes)->get();
        return response()->json($voyage);
    }
    public function index()
    {
       
        $etat= LigneResource::collection(Ligne::query()->orderBy('id', 'desc')->paginate(10));
        return response()->json( $etat);
   
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \App\Http\Requests\StoreUserRequest $request
     * @return \Illuminate\Http\Response
     */
    public function store(AddLigneRequest $request)
    {
        $data = $request->validated();
        
        $ligne = Ligne::create($data);

        return response(new LigneResource($ligne) , 201);
    }

    /**
     * Display the specified resource.
     *
     * @param \App\Models\User $user
     * @return \Illuminate\Http\Response
     */
    public function show(Ligne $ligne)
    {
        return new LigneResource($ligne);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \App\Http\Requests\UpdateUserRequest $request
     * @param \App\Models\User                     $user
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateLigneRequest $request, Ligne $ligne)
    {
        $data = $request->validated();
       
        $ligne->update($data);

        return new LigneResource($ligne);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param \App\Models\User $user
     * @return \Illuminate\Http\Response
     */
    public function destroy(Ligne $ligne)
    {
        $ligne->delete();

        return response("", 204);
    }

    public function getdate($voyage_id,$entreprise)
    {
        $test='full';
        $disableddate= Reservation::where('voyage_id',$voyage_id)->where('etat','full')->where('entreprise_id',$entreprise)->get('voyagedate');
        return response()->json($disableddate);
    }
    public function getreservation($voyage_id,$reservation)
    {
    $reserve = Reservation::where('voyage_id',$voyage_id)->where('voyagedate',$reservation)->get();
    return response()->json($reserve);
;   }

public function newreserve(Request $request)
{
    $data = new Reservation;
    $data->voyagedate = $request->input('voyagedate');
    $data->nbrptotal = $request->input('nbrptotal');
    $data->nbrpoccupe = $request->input('nbrpoccupe');
    $data->etat = $request->input('etat');
    $data->voyage_id = $request->input('voyage_id');
    $data->entreprise_id = $request->input('entreprise_id');
    $data->save();

    return response()->json(['message' => 'Data saved successfully']);
}
public function reserveput(Request $request, $id)
{
    $reservation = Reservation::findOrFail($id);
    
    // Update the number of occupied spots
    $reservation->nbrpoccupe += 1;
    $reservation->save();

    // Return a response
    return response()->json(['message' => 'Reservation updated successfully']);
}








public function reserveputetat(Request $request, $id)
{
    $reservation = Reservation::findOrFail($id);
    
    // Update the number of occupied spots
    $reservation->etat ='full';
    $reservation->save();

    // Return a response
    return response()->json(['message' => 'Reservation updated successfully']);
}
public function newbillet(Request $request)
{
    $data = new billet;
    $faker = Factory::create();
    $data->numero = $faker->unique()->randomNumber(8, true);
    $data->validite = $request->input('validite');
    $data->reservations_id = $request->input('reservations_id');
    $data->save();

    return response()->json($data->numero);
}
public function getentreall()
    {
        
        $entre= Entreprise::get();
        return response()->json($entre);
    }
 public function getbillet($numero)
    {
        
        $billet= billet::where('numero',$numero)->get();
        return response()->json($billet);
    }
    public function getvoyage($voyage_id)
    {
        
        $voyage= Voyage::where('id',$voyage_id)->get();
        
        return response()->json($voyage);
    }
    public function getligne($id_lignes)
    {
        
        $ligne= Ligne::where('id',$id_lignes)->get();
        
        return response()->json($ligne);
    }
    public function voyageall()
    {
        $voyage =Voyage::all();
        
        return response()->json($voyage);

    }
    public function postvoyage(Request $request)
{
    $data = new Voyage;
    $data->temps = $request->input('temps');
    $data->lignes_id = $request->input('lignes_id');
    $data->entreprise_id = $request->input('entreprise_id');
    $data->save();

    return response()->json(['message' => 'Data saved successfully']);
}
public function getrall($id)
    {
    $reserve = Reservation::where('voyage_id',$id)->get();
   

  
    return response()->json($reserve);

  }
  public function getrb($id)
    {
    $reserve = Reservation::where('id',$id)->get();
    return response()->json($reserve);
  }
  public function billetputetat(Request $request, $id)
  {
    $billet = billet::findOrFail($id);
    
      
      // Update the number of occupied spots
      $billet->validite ='non validie';
      $billet->save();
  
      // Return a response
      return response()->json(['message' => 'Reservation updated successfully']);
  }


  public function getentre($id_entre)
  {
      
      $entrep= Entreprise::where('id',$id_entre)->get();
      
      
      return response()->json($entrep);
  }



  

}
