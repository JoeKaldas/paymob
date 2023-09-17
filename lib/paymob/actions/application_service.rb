module Paymob
  class ApplicationService
    Response = Struct.new(:success?, :payload, :error) do
      def failure?
        !success?
      end
    end

    def self.call(...)
      service = new
      service.call(...)
    rescue StandardError => e
      service.failure(e)
    end

    def self.call!(...)
      new.call(...)
    end

    def success(payload = nil)
      Response.new(true, payload)
    end

    def failure(exception)
      Response.new(false, nil, exception)
    end

    def warning(message)
      Response.new(false, nil, message)
    end
  end
end
