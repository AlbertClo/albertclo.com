<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\View\View;

class NachiController extends Controller
{
    public function benefits(Request $request): View
    {
        return view('nachi.benefits');
    }
}
