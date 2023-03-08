require_relative "test_helper"

class TestSearchOccurrences < Test::Unit::TestCase

  def test_search_occurrences
    VCR.use_cassette("test_search_occurrences") do
      res = Bonamia.search_occurrences(
        'f86a681d-7db8-483b-819a-248def18b70a',
        '7a1daa39-8d7c-d7c4-968f-799d58b3c7b0'
      )
      assert_equal('PRESERVED_SPECIMEN', res['dataFeedElement'][0]['item']['basisOfRecord'])
    end
  end

end