# frozen_string_literal: true

require "erb"
require_relative "bonamia/version"
require_relative "bonamia/request"
require "bonamia/helpers/configuration"

module Bonamia
  extend Configuration

  define_setting :base_url, "https://api.bionomia.net/"
  define_setting :mailto, ENV["BIONOMIA_API_EMAIL"]

  # Parse human names
  #
  # @param names [String] Human name(s) separated by \r\n
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Array, Boolean] An array of hashes
  def self.parse(names, verbose: false)
    endpoint = "parse"
    Request.new(
      endpoint: endpoint,
      names: names,
      verbose: verbose
    ).perform
  end

  # Get a person's profile by ID or specimens
  # @param id [String] An ORCID or WikiData identifier
  # @param specimens [Boolean, nil] Get the person's specimens
  # @param csv [Boolean, nil] For specimens, whether to return a csv
  #
  # @param page [Integer, nil] Pagination for the results list
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, String, Boolean] A JSON-LD hash or CSV
  def self.person(id, csv: nil, specimens: nil, page: nil, verbose: false)
    if csv and specimens
      extension = '.csv'
    else
      extension = '.jsonld'
    end

    if specimens
      endpoint = "#{id}/specimens#{extension}"
    else
      endpoint = "#{id}#{extension}"
    end
    Request.new(endpoint: endpoint, page: page, verbose: verbose).perform
  end

  # Get and occurrence record
  # @param id [String] An occurence ID from Global Biodiversity Information Facility
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash, Boolean] A JSON-LD hash
  def self.occurrence(id, verbose: false)
    endpoint = "occurrence/#{id}.jsonld"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end

  # Search human names
  # @param q [String] A single human name
  # @param families_collected [Boolean, nil] Comma-separated list of taxonomic families collected
  # @param families_identified [Boolean, nil] Comma-separated list of taxonomic families identified
  # @param date [String, nil] A date expressed as YYYY-MM-DD, YYYY-MM, or YYYY
  # @param strict [Boolean, nil] Must include vs should include on families_identified, families_collected, date
  # @param callback [String, nil] A string to produce a JSONP response instead of a JSON-LD response
  #
  # @param page [Integer, nil] Pagination for the results list
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Array, Boolean] An array of hashes
  def self.search_people(q, families_collected: nil, families_identified: nil, date: nil, page: nil,
                  strict: nil, callback: nil, verbose: false)
    endpoint = 'users/search'
    Request.new(
      endpoint: endpoint,
      q: q,
      families_collected: families_collected,
      families_identified: families_identified,
      date: date,
      page: page,
      strict: strict,
      callback: callback,
      verbose: verbose
    ).perform
  end

  # Search occurrences
  # @param dataset_id [String] a registered dataset UUID provided by the Global Biodiversity Information Facility
  # @param occurrence_id [String] identifier from the data provider
  # @param callback [String, nil] A string to produce a JSONP response instead of a JSON-LD response
  #
  # @param page [Integer, nil] Pagination for the results list
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Array, Boolean] An array of hashes
  def self.search_occurrences(dataset_id, occurrence_id, callback: nil, verbose: false)
    endpoint = 'occurrences/search'
    Request.new(
      endpoint: endpoint,
      dataset_id: dataset_id,
      occurrence_id: occurrence_id,
      callback: callback,
      verbose: verbose
    ).perform
  end

  # Suggest human names (autocomplete widget)
  # @param q [String] Part of a human name
  # @param is_public [Boolean, nil] Filters results to public profiles
  # @param has_occurrences [Boolean, nil] Filters results to profiles with occurrences
  #
  # @param limit [Integer, nil] The number of results to return
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Array, Boolean] An array of hashes
  def self.suggest(q, is_public: nil, has_occurrences: nil, limit: nil, verbose: false)
    endpoint = 'user.json'
    Request.new(
      endpoint: endpoint,
      q: q,
      is_public: is_public,
      has_occurrences: has_occurrences,
      limit: limit,
      verbose: verbose
    ).perform
  end
end
