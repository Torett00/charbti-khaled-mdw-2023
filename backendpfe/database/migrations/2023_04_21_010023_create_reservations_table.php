<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReservationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('reservations', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->date('voyagedate');
            $table->integer('nbrptotal')->nullable();
            $table->integer('nbrpoccupe')->nullable();
            $table->string('etat');
            $table->unsignedBigInteger('voyage_id');
            $table->foreign('voyage_id')->references('id')->on('voyages');
            $table->unsignedBigInteger('entreprise_id');
            $table->foreign('entreprise_id')->references('id')->on('entreprises');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('reservations');
    }
}