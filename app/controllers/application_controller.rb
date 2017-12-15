class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  protect_from_forgery with: :exception
	helper_method :boss_admin
	helper_method :current_or_guest_user


	def current_or_guest_user
	  if current_user
	    if session[:guest_user_id] && session[:guest_user_id] != current_user.id
	      logging_in

	      guest_user(with_retry = false).try(:reload).try(:destroy)
	      session[:guest_user_id] = nil
	    end
	    current_user
	  else
	    guest_user
	  end
	end

	def guest_user(with_retry = true)
	  @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

	rescue ActiveRecord::RecordNotFound
    session[:guest_user_id] = nil
    guest_user if with_retry
	end

  def admin?
    current_or_guest_user.try(:admin?)
  end


	private
  def boss_admin
	  @boss_admin ||= User.find_by(admin: true)
  end

  def logging_in
    # guest_comments = guest_user.comments.all
    # guest_comments.each do |comment|
      # comment.user_id = current_user.id
      # comment.save!
    # end
  end

  def create_guest_user
    u = User.new(:email => "guest_#{Time.now.to_i}#{rand(100)}@customerchat.com")
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end
end
