defmodule Chacha20Test do
  use ExUnit.Case
  doctest Chacha20

  @key <<1::8*32>>
  @nonce <<1::8*12>>

  test "chacha20 fixed input" do
    c = Chacha20.init :chacha20, @key, @nonce
    assert Chacha20.encrypt(c, [1,2,3]) == {:ok, <<194, 135, 81, 69>>}
    assert Chacha20.encrypt(c, <<1,2,3>>) == {:ok, <<194, 135, 81, 69>>}
    assert Chacha20.encrypt(c, "123") == {:ok, "·au"}
  end

  test "tests chacha12" do
    c = Chacha20.init :chacha12, @key, @nonce
    assert Chacha20.encrypt(c, [1,2,3]) == {:ok, <<11, 49, 20>>}
    assert Chacha20.encrypt(c, <<1,2,3>>) == {:ok, <<11, 49, 20>>}
    assert Chacha20.encrypt(c, "123") == {:ok, <<59, 1, 36>>}
  end

  test "tests chacha8" do
    c = Chacha20.init :chacha8, @key, @nonce
    assert Chacha20.encrypt(c, [1,2,3]) == {:ok, <<194, 132, 24, 94>>}
    assert Chacha20.encrypt(c, <<1,2,3>>) == {:ok, <<194, 132, 24, 94>>}
    assert Chacha20.encrypt(c, "123") == {:ok, "´(n"}
  end
end
