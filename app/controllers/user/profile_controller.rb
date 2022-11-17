class User::ProfileController < ApplicationController
  def show
    authorize current_user
  end
end
