<?php

namespace App\Models;

use App\Models\Employe;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Conji extends Model
{
    use HasFactory;
    protected $fillable = [
        'id',
        'name',
        'reason'
        ,'nbrjr','dateconji','user_id','etat','entreprise_id',
    ];
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
