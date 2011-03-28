module HostRedirector
  def self.included(base)
    base.send :extend, ClassMethods
  end
 
  module ClassMethods
    def forces_redirect_to_host
      send :before_filter do
        config = Rails.application.config
        unless config.respond_to? :host
          logger.warn "HostRedirector: Please specify a host in the site configuration" 
          return
        end

        unless request.host == config.host
          redirect_to "#{request.protocol}#{config.host}#{request.port_string}#{request.fullpath}"
        end
      end
    end
  end
end

ActionController::Base.send :include, HostRedirector