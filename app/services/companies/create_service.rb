module Companies
  class CreateService
    def initialize(params)
      @params = params
    end

    def call
      Company.new(params).save!
    end
  end
end
