<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Source extends Model
{
    //
    public function places() {
        return $this->hasMany ( 'App\Places','source_id','id');           
    }         
}
