defmodule PhxParamsDecoderTest do
  use ExUnit.Case
  doctest PhxParamsDecoder

  describe "decode_value/1" do
    test "decodes a list of strings" do
      value = ["ADMINS", "EMPLOYEE", "MVP"]

      assert PhxParamsDecoder.decode_value(value) == ["ADMINS", "EMPLOYEE", "MVP"]
    end

    test "decodes a list of stringified integers" do
      value = ["124039", "99", "0"]

      assert PhxParamsDecoder.decode_value(value) == [124_039, 99, 0]
    end

    test "decodes a value which is stringified integer" do
      value = "12"

      assert PhxParamsDecoder.decode_value(value) == 12
    end

    test "decodes a value which is a stringified float" do
      value = "12.2"

      assert PhxParamsDecoder.decode_value(value) == 12.2
    end

    test "decodes a value which is a float" do
      value = 12.2

      assert PhxParamsDecoder.decode_value(value) == 12.2
    end

    test "returns string when it's just a string" do
      value = "valid value"

      assert PhxParamsDecoder.decode_value(value) == "valid value"
    end
  end
end
