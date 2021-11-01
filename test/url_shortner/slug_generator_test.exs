defmodule UrlShortner.SlugGeneratorTest do
  @moduledoc false
  use ExUnit.Case, async: true

  alias UrlShortner.SlugGenerator

  describe "generate/1" do
    test "generate a random string with alphanumeric chars" do
      length = Enum.random(1..100)

      assert SlugGenerator.generate(length) =~ ~r/\w{#{length}}/
      assert SlugGenerator.generate(0) =~ ~r/\w{6}/
      assert SlugGenerator.generate() =~ ~r/\w{6}/
    end
  end
end
