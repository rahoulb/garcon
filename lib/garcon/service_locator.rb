module Garcon
  class ServiceLocator

    def initialize
      super
      @services = {}
    end

    def [] service_name
      @services[service_name.to_s].call
    end

    def register service_name, &handler
      @services[service_name.to_s] = handler
    end
  end
end
