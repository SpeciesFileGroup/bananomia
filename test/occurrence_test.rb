require_relative "test_helper"

class TestOccurrence < Test::Unit::TestCase

  def test_occurrence
    VCR.use_cassette("test_occurrence") do
      res = Bonamia.occurrence('477976412')
      assert_equal('PRESERVED_SPECIMEN', res['basisOfRecord'])
    end
  end
end