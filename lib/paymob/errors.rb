module Paymob
  # PaymobError is the base error from which all other more specific Paymob
  # errors derive.
  class PaymobError < StandardError
    attr_reader :message, :error, :http_body, :http_headers, :http_status, :json_body

    # Initializes a PaymobError.
    def initialize(message = nil, http_status: nil, http_body: nil)
      @message = message
      @http_status = http_status
      @http_body = http_body
      begin
        @json_body = JSON.parse(http_body)
      rescue JSON::ParserError
        @json_body = {}
      end
    end

    def to_s
      status_string = @http_status.nil? ? "" : "(Status #{@http_status}) "
      "#{status_string}#{@message}"
    end
  end

  # AuthenticationError is raised when invalid credentials are used to connect
  # to Paymob's servers.
  class AuthenticationError < PaymobError
  end

  # APIConnectionError is raised in the event that the SDK can't connect to
  # Paymob's servers. That can be for a variety of different reasons from a
  # downed network to a bad TLS certificate.
  class APIConnectionError < PaymobError
  end

  # APIError is a generic error that may be raised in cases where none of the
  # other named errors cover the problem. It could also be raised in the case
  # that a new error has been introduced in the API, but this version of the
  # Ruby SDK doesn't know how to handle it.
  class APIError < PaymobError
  end

  # InvalidRequestError is raised when a request is initiated with invalid
  # parameters.
  class InvalidRequestError < PaymobError
    attr_accessor :param

    def initialize(message, param, http_status: nil, http_body: nil)
      super(message, http_status: http_status, http_body: http_body)
      @param = param
    end
  end

  # SignatureVerificationError is raised when the signature verification for a
  # webhook fails
  class SignatureVerificationError < PaymobError
    attr_accessor :sig_header

    def initialize(message, sig_header, http_body: nil)
      super(message, http_body: http_body)
      @sig_header = sig_header
    end
  end

  module OAuth
    # OAuthError is raised when the OAuth API returns an error.
    class OAuthError < PaymobError
      def initialize(description, http_status: nil, http_body: nil)
        super(description, http_status: http_status, http_body: http_body)
      end
    end

    # InvalidRequestError is raised when a code, refresh token, or grant type
    # parameter is not provided, but was required.
    class InvalidRequestError < OAuthError
    end
  end
end
