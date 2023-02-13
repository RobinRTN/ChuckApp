class PackagesController < ApplicationController

  def index
    @package = Package.new
  end

end
