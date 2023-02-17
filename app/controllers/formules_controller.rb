class FormulesController < ApplicationController
  def index
    user_formules = current_user.formules
    @formule = Formule.new
  end
end
