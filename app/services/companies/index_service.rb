# frozen_string_literal: true

module Companies
  class IndexService
    VALID_FILTERS = ['incomplete'].freeze

    def initialize(params)
      @params = params
    end

    def call
      if filter.present?
        Company.public_send(filter)
      else
        Company.all
      end
    end

    def filter
      return if @params['filter'].blank?
      return @params['filter'] if VALID_FILTERS.include? @params['filter']

      false
    end
  end
end
