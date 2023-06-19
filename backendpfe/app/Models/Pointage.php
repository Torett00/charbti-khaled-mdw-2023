<?php

namespace App\Models;

use App\Models\User;
use App\Models\Entreprise;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Pointage extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['id','conjirestant','currentjour','nombredejour','currentmois','user_id','entreprise_id'];
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function entreprise()
    {
        return $this->belongsTo(Entreprise::class);
    }
}
