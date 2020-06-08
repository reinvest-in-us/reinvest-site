class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!

  def after_sign_in_path_for(_)
    admin_root_path
  end

  def after_sign_out_path_for(_)
    root_path
  end
end
