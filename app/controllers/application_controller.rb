class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  #   # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

 # Add this inside app/controllers/application_controller.rb
def render_json_response(type, hash)
  unless [ :ok, :redirect, :error ].include?(type)
    raise "Invalid json response type: #{type}"
  end

  # To keep the structure consistent, we'll build the json 
  # structure with the default properties.
  #
  # This will also help other developers understand what 
  # is returned by the server by looking at this method.
  default_json_structure = { 
    :status => type, 
    :html => nil, 
    :message => nil, 
    :to => nil }.merge(hash)

  render_options = {:json => default_json_structure}  
  render_options[:status] = 400 if type == :error

  render(render_options)
end 

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
end
