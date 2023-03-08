require_relative "test_helper"

class TestSearchPeople < Test::Unit::TestCase

  # TODO: add more tests

  def test_search_people
    VCR.use_cassette("test_search_people") do
      res = Bonamia.search_people('smith', families_collected: 'scarabaeidae', strict: true)
      assert_equal('Andrew B.T. Smith', res['dataFeedElement'][0]['item']['name'])
    end
  end

end