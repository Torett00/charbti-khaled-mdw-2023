<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Fichedp extends Model
{
    use HasFactory;
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['id','conjirestant','salaire','nombredejour','user_id','entreprise_id'];
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function entreprise()
    {
        return $this->belongsTo(Entreprise::class);
    }
}
