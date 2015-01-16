require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Debe crear un usuario" do
  	u = Usuario.new(username: "cristian", email: "cristianhoyos123@hotmail.com", password: "123123123")
  	assert u.save
  end

  test "Debe crear un usuario sin email" do
  	u = Usuario.new(username: "cristian", password: "123123123")
  	assert u.save
  end

end
