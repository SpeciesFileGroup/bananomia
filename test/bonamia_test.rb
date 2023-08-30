# frozen_string_literal: true

require "test_helper"

class BananomiaTest < Test::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Bananomia::VERSION
  end
end
