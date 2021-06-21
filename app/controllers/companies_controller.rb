# frozen_string_literal: true
class CompaniesController
  def index
    @resources = CompaniesIndexService.call
    render_for_index(@resources)
  end

  def create
  end

  def update; end

  def destroy; end
end
