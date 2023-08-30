require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_original_0
    VCR.use_cassette("test_parse") do
      res = Bananomia.parse('Henry Robert Nicollon des Abbayes; Groom Q\r\nMrs. John Errol Chandos Aberdeen')
      assert_equal('Henry Robert Nicollon des Abbayes; Groom Q', res[0]['original'])
    end
  end

  def test_parse_0_family_0
    VCR.use_cassette("test_parse") do
      res = Bananomia.parse('Henry Robert Nicollon des Abbayes; Groom Q\r\nMrs. John Errol Chandos Aberdeen')
      assert_equal('Abbayes', res[0]['parsed'][0]['family'])
    end
  end

  def test_parse_0_given_0
    VCR.use_cassette("test_parse") do
      res = Bananomia.parse('Henry Robert Nicollon des Abbayes; Groom Q\r\nMrs. John Errol Chandos Aberdeen')
      assert_equal('Henry Robert Nicollon', res[0]['parsed'][0]['given'])
    end
  end

  def test_parse_0_particle_0
    VCR.use_cassette("test_parse") do
      res = Bananomia.parse('Henry Robert Nicollon des Abbayes; Groom Q\r\nMrs. John Errol Chandos Aberdeen')
      assert_equal('des', res[0]['parsed'][0]['particle'])
    end
  end

  def test_parse_0_family_1
    VCR.use_cassette("test_parse") do
      res = Bananomia.parse('Henry Robert Nicollon des Abbayes; Groom Q\r\nMrs. John Errol Chandos Aberdeen')
      assert_equal('Groom', res[0]['parsed'][1]['family'])
    end
  end

  def test_parse_0_given_1
    VCR.use_cassette("test_parse") do
      res = Bananomia.parse('Henry Robert Nicollon des Abbayes; Groom Q\r\nMrs. John Errol Chandos Aberdeen')
      assert_equal('Q.', res[0]['parsed'][1]['given'])
    end
  end

  def test_original_1
    VCR.use_cassette("test_parse") do
      res = Bananomia.parse('Henry Robert Nicollon des Abbayes; Groom Q\r\nMrs. John Errol Chandos Aberdeen')
      assert_equal('Mrs. John Errol Chandos Aberdeen', res[1]['original'])
    end
  end

end