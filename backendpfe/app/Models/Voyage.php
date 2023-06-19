<?php

namespace App\Models;

use App\Models\Ligne;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Voyage extends Model
{
    use HasFactory;
    protected $fillable = [
        'id',
        'temps',
        'lignes_id'
    ];

    public function ligne()
    {
        return $this->belongsTo(Ligne::class);
    }
    
}
