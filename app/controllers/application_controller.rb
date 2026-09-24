class ApplicationController < ActionController::Base
  include Authentication

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :manager?

  private
    def current_user
      Current.session&.user
    end

    def manager?
      current_user&.manager?
    end

    def require_manager
      redirect_to root_path, alert: "Orders are only open to managers." unless manager?
    end
end
