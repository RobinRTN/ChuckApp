class FormulesController < ApplicationController

  def index
    @formule = Formule.new
  end
end
