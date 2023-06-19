<?php

namespace App\Models;

use App\Models\Reservation;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class billet extends Model
{
    use HasFactory;
    
    protected $fillable = ['id','numero','validite','reservations_id'];
    public function reservation()
    {
        return $this->belongsTo(Reservation::class);
    }
    
}

