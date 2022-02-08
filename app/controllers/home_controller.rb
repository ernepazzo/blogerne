class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @estab_plan = [1,3,2]
  end
end
