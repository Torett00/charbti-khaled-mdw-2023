<?php

namespace App\Models;

use App\Models\Voyage;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Reservation extends Model
{
    use HasFactory;
    protected $fillable = ['id','nbrptotal','nbrpoccupe','etat','voyage_id'];
    public function voyage()
    {
        return $this->belongsTo(Voyage::class);
    }
}
