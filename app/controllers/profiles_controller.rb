class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      redirect_to new_profile_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def profile_params
    params.permit(:username)
  end
end
