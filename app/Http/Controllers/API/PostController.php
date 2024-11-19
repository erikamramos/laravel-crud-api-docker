<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Post;


class PostController extends Controller
{
    // Obtener todos los posts
    public function index()
    {
        return Post::all();
    }

    // Crear un nuevo post
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required',
        ]);

        return Post::create($validated);
    }

    // Mostrar un post por ID
    public function show(Post $post)
    {
        return $post;
    }

    // Actualizar un post
    public function update(Request $request, Post $post)
    {
        $validated = $request->validate([
            'title' => 'string|max:255',
            'content' => 'string',
        ]);

        $post->update($validated);

        return $post;
    }

    // Eliminar un post
    public function destroy(Post $post)
    {
        $post->delete();

        return response()->noContent();
    }
}
