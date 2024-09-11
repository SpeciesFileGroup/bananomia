require_relative "test_helper"
require "date"

class TestSearchPeople < Test::Unit::TestCase

  def test_search_people
    VCR.use_cassette("test_search_people") do
      res = Bananomia.search_people('smith', families_collected: 'scarabaeidae', strict: true)
      assert_true(res['dataFeedElement'][0]['item']['name'].include?('Smith'))
    end
  end

  def test_search_people_families_collected
    VCR.use_cassette("test_search_people_families_collected") do
      res = Bananomia.search_people('Thomas McElrath', families_collected: 'Acholeplasmataceae', strict: true)
      assert_equal(0, res['opensearch:totalResults'])
    end
  end

  def test_search_people_families_identified
    VCR.use_cassette("test_search_people_families_identified") do
      res = Bananomia.search_people('Thomas McElrath', families_identified: 'Acholeplasmataceae', strict: true)
      assert_equal(0, res['opensearch:totalResults'])
    end
  end

  # NOTE: Date filters on alive during date. Increment birth date by 1 day to include them in the search results
  def test_search_people_date
    VCR.use_cassette("test_search_people_date") do
      search_date = '1580-01-02'
      res = Bananomia.search_people('Smith', date: search_date, strict: true)
      res['dataFeedElement'].each do |r|
        search_date = Date.parse(search_date)
        birth = Date.parse(r['item']['birthDate'])
        death = Date.parse(r['item']['deathDate'])
        assert_true((search_date >= birth and search_date <= death))
      end
    end
  end

  def test_search_people_page
    VCR.use_cassette("test_search_people_page") do
      res = Bananomia.search_people('Smith', page: 2)
      assert_equal('https://api.bionomia.net/users/search?page=2&q=Smith', res['as:current'])
    end
  end

  def test_search_people_callback
    VCR.use_cassette("test_search_people_callback") do
      res = Bananomia.search_people('Smith', callback: 'aldkfjlasfoewhfaefoiefoaef')
      assert_include(res, 'aldkfjlasfoewhfaefoiefoaef')
    end
  end

end