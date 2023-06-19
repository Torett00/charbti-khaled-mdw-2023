<?php

namespace App\Models;

use App\Models\Ligne;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class station extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['station'];
      


}
