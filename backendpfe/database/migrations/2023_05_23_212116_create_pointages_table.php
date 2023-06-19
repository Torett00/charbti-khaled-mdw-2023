<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePointagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
       Schema::create('pointages', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->integer('nombredejour')->nullable();
            $table->integer('currentjour');
            $table->string('currentmois');
            $table->integer('conjirestant');
            $table->unsignedBigInteger('entreprise_id');
            $table->foreign('entreprise_id')->references('id')->on('entreprises');
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users');
        });
     
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('pointages');
    }
}
