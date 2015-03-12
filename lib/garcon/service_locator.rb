module Garcon
  class ServiceLocator

    def initialize
      super
      @services = {}
    end

    def [] service_name
      service = @services[service_name.to_s]
      service.nil? ? Object.const_get(service_name.to_s) : service.call
    end

    def register service_name, &handler
      @services[service_name.to_s] = handler
    end
  end
end
