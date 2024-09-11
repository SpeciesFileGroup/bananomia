require_relative "test_helper"

class TestPerson < Test::Unit::TestCase

  def test_person_orcid
    VCR.use_cassette("test_person_orcid") do
      res = Bananomia.person('0000-0001-7618-5230')
      assert_equal('Shorthouse, David Peter', res['alternateName'][0])
    end
  end

  def test_person_orcid_specimens
    VCR.use_cassette("test_person_orcid_specimens") do
      res = Bananomia.person('0000-0001-7618-5230', specimens: true)
      assert_equal('PRESERVED_SPECIMEN', res['@reverse']['identified'][0]['basisOfRecord'])
    end
  end

  def test_person_orcid_specimens_csv
    VCR.use_cassette("test_person_orcid_specimens_csv") do
      res = Bananomia.person('0000-0001-7618-5230', specimens: true, csv: true)
      rows = res.split("\n")
      assert_equal(rows[0], 'action,gbifID,datasetKey,license,occurrenceID,basisOfRecord,dateIdentified,decimalLatitude,decimalLongitude,country,countryCode,eventDate,year,kingdom,family,identifiedBy,institutionCode,collectionCode,catalogNumber,recordedBy,scientificName,typeStatus,recordedByID,identifiedByID,BIONOMIAcreatedBy,BIONOMIAcreatedByURI,BIONOMIAcreated')
      rows[1..-1].each do |r|
        assert_true(r.include?('Shorthouse'))
      end
    end
  end

  def test_person_wikidata
    VCR.use_cassette("test_person_wikidata") do
      res = Bananomia.person('Q1035')
      assert_equal('Darwin, Charles Robert', res['alternateName'][0])
    end
  end

end