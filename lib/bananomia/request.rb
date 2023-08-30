require_relative "faraday" # !! Potential ruby 3.0 difference in module loading? relative differs from Serrano
require "faraday/follow_redirects"
require_relative "utils"

module Bananomia

  class Request
    attr_accessor :endpoint
    attr_accessor :q
    attr_accessor :verbose

    attr_accessor :options

    def initialize(**args)
      @endpoint = args[:endpoint]
      @verbose = args[:verbose]
      @q = args[:q]
      @families_collected = args[:families_collected]
      @families_identified = args[:families_identified]
      @date = args[:date]
      @strict = args[:strict]
      @callback = args[:callback]
      @is_public = args[:is_public]
      @has_occurrences = args[:has_occurrences]
      @dataset_id = args[:dataset_id]
      @occurrence_id = args[:occurrence_id]
      @names = args[:names]&.gsub('\n', "\n")&.gsub('\r', "\r")
      @limit = args[:limit]
      @page = args[:page]
      @options = args[:options] # TODO: not added at bananomia.rb
    end

    def perform

      args = {
        q: @q,
        families_collected: @families_collected,
        families_identified: @families_identified,
        date: @date,
        strict: @strict,
        callback: @callback,
        names: @names,
        is_public: @is_public,
        has_occurrences: @has_occurrences,
        datasetKey: @dataset_id,
        occurrenceID: @occurrence_id,
        limit: @limit,
        page: @page
      }
      opts = args.delete_if { |_k, v| v.nil? }

      Faraday::Utils.default_space_encoding = "+"

      conn = if verbose
               Faraday.new(url: Bananomia.base_url) do |f|
                 f.response :logger
                 f.use Faraday::ColrapiErrors::Middleware
                 f.adapter Faraday.default_adapter
               end
             else
               Faraday.new(url: Bananomia.base_url) do |f|
                 f.use Faraday::ColrapiErrors::Middleware
                 f.adapter Faraday.default_adapter
               end
             end

      conn.headers['Accept'] = 'application/ld+json,*/*'
      conn.headers[:user_agent] = make_user_agent
      conn.headers["X-USER-AGENT"] = make_user_agent

      res = conn.get(endpoint, opts)

      # Handles ChecklistBank endpoints that do not return JSON
      begin
        MultiJson.load(res.body)
      rescue MultiJson::ParseError
        res.body
      end
      
    end
  end
end
