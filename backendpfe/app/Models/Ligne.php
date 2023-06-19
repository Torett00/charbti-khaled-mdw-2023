<?php

namespace App\Models;

use App\Models\station;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Ligne extends Model
{
    
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['id','numero','depart','arrive','prix','distance'];

}