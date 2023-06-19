<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Password;

class UpdateLigneRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            'numero' => 'required|string|unique:lignes,numero,'.$this->id,
            'depart' => 'required|string|max:55',
            'arrive' =>  'required|string|max:55',
            'distance' => 'required|string|max:55',
            'prix' => 'required|string|max:55',
        ];
    }
}
