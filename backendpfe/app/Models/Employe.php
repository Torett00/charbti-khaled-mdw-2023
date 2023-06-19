<?php

namespace App\Models;

use App\Models\User;
use App\Models\Entreprise;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Employe extends Model
{
    use HasFactory;
    protected $fillable = [
        'id',
        'name',
        'telephone','adresse','poste','salaire','user_id','entreprise_id'
    ];
    public function user()
{
    return $this->belongsTo(User::class);
}
public function entreprise()
{
    return $this->belongsTo(Entreprise::class);
}
}


