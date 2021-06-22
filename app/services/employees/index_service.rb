# frozen_string_literal: true

module Employees
  class IndexService
    def initialize(params)
      @params = params
    end

    def call
      Employee.all
    end
  end
end
