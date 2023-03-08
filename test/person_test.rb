require_relative "test_helper"

class TestPerson < Test::Unit::TestCase

  def test_person_orcid
    VCR.use_cassette("test_person_orcid") do
      res = Bonamia.person('0000-0001-7618-5230')
      assert_equal('Shorthouse, David Peter', res['alternateName'][0])
    end
  end

  def test_person_orcid_specimens
    VCR.use_cassette("test_person_orcid_specimens") do
      res = Bonamia.person('0000-0001-7618-5230', specimens: true)
      assert_equal('PRESERVED_SPECIMEN', res['@reverse']['identified'][0]['basisOfRecord'])
    end
  end

  def test_person_orcid_specimens_csv
    VCR.use_cassette("test_person_orcid_specimens_csv") do
      res = Bonamia.person('0000-0001-7618-5230', specimens: true, csv: true)
      assert_equal('action,gbifID,datasetKey,license,occurrenceID,basisOfRecord,dateIdentified,decimalLatitude,decimalLongitude,country,countryCode,eventDate,year,kingdom,family,identifiedBy,institutionCode,collectionCode,catalogNumber,recordedBy,scientificName,typeStatus,recordedByID,identifiedByID,BIONOMIAcreatedBy,BIONOMIAcreatedByURI,BIONOMIAcreated
identified,769281222,8971dfba-f762-11e1-a439-00145eb45e9a,CC0_1_0,urn:catalog:UASM:UASM329574,PRESERVED_SPECIMEN,2010,56.786,-118.349,Canada,CA,2004-07,,Animalia,Linyphiidae,"Shorthouse, D.",University of Alberta Museums (UAM),UASM,UASM329574,"Pinzon, J.",Oreonetides vaginatus,,,,"Shorthouse, David Peter",https://orcid.org/0000-0001-7618-5230,2021-03-12 20:11:13 UTC
identified,769279986,8971dfba-f762-11e1-a439-00145eb45e9a,CC0_1_0,urn:catalog:UASM:UASM329612,PRESERVED_SPECIMEN,2010,56.785,-118.355,Canada,CA,2004-07,,Animalia,Linyphiidae,"Shorthouse, D.",University of Alberta Museums (UAM),UASM,UASM329612,"Pinzon, J.",Tunagyna debilis,,,,"Shorthouse, David Peter",https://orcid.org/0000-0001-7618-5230,2021-09-22 16:15:12 UTC
identified,769279710,8971dfba-f762-11e1-a439-00145eb45e9a,CC0_1_0,urn:catalog:UASM:UASM329573,PRESERVED_SPECIMEN,2010,56.839,-118.340,Canada,CA,2004-07,,Animalia,Linyphiidae,"Shorthouse, D.",University of Alberta Museums (UAM),UASM,UASM329573,"Pinzon, J.",Oreonetides vaginatus,,,,"Shorthouse, David Peter",https://orcid.org/0000-0001-7618-5230,2023-01-15 15:08:30 UTC
', res)
    end
  end

  def test_person_wikidata
    VCR.use_cassette("test_person_wikidata") do
      res = Bonamia.person('Q1035')
      assert_equal('Darwin, Charles', res['alternateName'][0])
    end
  end

end