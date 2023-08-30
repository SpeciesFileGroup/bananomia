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
identified,769279986,8971dfba-f762-11e1-a439-00145eb45e9a,CC0_1_0,urn:catalog:UASM:UASM329612,PRESERVED_SPECIMEN,2010,56.785,-118.355,Canada,CA,2004-07,,Animalia,Linyphiidae,"Shorthouse, D.",University of Alberta Museums (UAM),UASM,UASM329612,"Pinzon, J.",Tunagyna debilis,,,,David P. Shorthouse,https://orcid.org/0000-0001-7618-5230,2021-09-22 16:15:12 UTC
identified,769279710,8971dfba-f762-11e1-a439-00145eb45e9a,CC0_1_0,urn:catalog:UASM:UASM329573,PRESERVED_SPECIMEN,2010,56.839,-118.340,Canada,CA,2004-07,,Animalia,Linyphiidae,"Shorthouse, D.",University of Alberta Museums (UAM),UASM,UASM329573,"Pinzon, J.",Oreonetides vaginatus,,,,David P. Shorthouse,https://orcid.org/0000-0001-7618-5230,2023-01-15 15:08:30 UTC
recorded,1414822067,040c5662-da76-4782-a48e-cdea1892d14c,CC_BY_4_0,http://bins.boldsystems.org/index.php/Public_RecordView?processid=COLNF1882-15,MATERIAL_SAMPLE,,,,Canada,CA,1999-07-13,,Animalia,,Gregory R. Pohl,,,NFRC-2014-02527,Shorthouse et al.,Coleoptera,,,,David P. Shorthouse,https://orcid.org/0000-0001-7618-5230,2023-03-26 03:03:17 UTC
identified,769281222,8971dfba-f762-11e1-a439-00145eb45e9a,CC0_1_0,urn:catalog:UASM:UASM329574,PRESERVED_SPECIMEN,2010,56.786,-118.349,Canada,CA,2004-07,,Animalia,Linyphiidae,"Shorthouse, D.",University of Alberta Museums (UAM),UASM,UASM329574,"Pinzon, J.",Oreonetides vaginatus,,,,David P. Shorthouse,https://orcid.org/0000-0001-7618-5230,2023-08-09 00:27:49 UTC
', res)
    end
  end

  def test_person_wikidata
    VCR.use_cassette("test_person_wikidata") do
      res = Bonamia.person('Q1035')
      assert_equal('Darwin, Charles Robert', res['alternateName'][0])
    end
  end

end