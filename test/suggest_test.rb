require_relative "test_helper"

class TestSuggest < Test::Unit::TestCase

  def test_suggest
    VCR.use_cassette("test_suggest") do
      res = Bonamia.suggest('anning')
      assert_equal('Q230491', res[0]['wikidata'])
    end
  end

end