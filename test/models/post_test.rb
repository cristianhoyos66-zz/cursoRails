require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "debe poder crear un post" do
  	post = Post.create(titulo: "Mi título", contenido: "Mi contenido")
  	assert post.save
	end

	test "debe poder actualizar un post" do
  	post = posts(:primer_articulo)
    assert post.update(titulo: "Nuevo titulo", contenido: "Nuevo contenido")
	end

  test "debe poder encontrar un post por su id" do
    post_id = posts(:primer_articulo).id
    #post = Post.find(post_id)
    #assert_equal post, posts(:primer_articulo), "No encontró el registro"
    assert_nothing_raised {Post.find(post_id)}
  end

  test "Debe poder borrar un post" do
    post = posts(:primer_articulo)
    post.destroy
    assert_raise(ActiveRecord::RecordNotFound) {Post.find(post.id)}
  end

  test "No debe crear un post sin título" do
    post = Post.new
    assert post.invalid?, "El post debería ser inválido"
  end

  test "El título del post debe ser único" do
    post = Post.new
    post.titulo = posts(:primer_articulo).titulo
    assert post.invalid?, "Dos posts no pueden tener el mismo titulo"
  end

end
