<?php

namespace App\Http\Controllers\Api;


use App\Models\station;
use App\Http\Controllers\Controller;
use App\Http\Resources\StationResource;
use App\Http\Requests\StationAddRequest;
use App\Http\Resources\StationsResource;
use App\Http\Requests\UpdateStationRequest;

class StationController extends Controller
{

    public function index()
    {
        $Stat= StationResource::collection(station::query()->orderBy('id', 'desc')->paginate(10));
    
    
        return response()->json( $Stat);
    }



    public function show(station $station)
    {
        return new StationResource($station);
    }
    public function store(StationAddRequest $request)
    {
        $data = $request->validated();
        $station = station::create($data);

        return response(new StationResource($station) , 201);
    }
    public function update(UpdateStationRequest $request, station $station)
    {
        $data = $request->validated();
       
        $station->update($station);

        return new StationResource($station);
    }
    public function destroy(station $station)
    {
        $station->delete();

        return response("", 204);
    }

}