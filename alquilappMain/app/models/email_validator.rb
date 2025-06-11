class EmailValidator
  include HTTParty
  base_uri 'https://emailvalidation.abstractapi.com/v1/'

  def initialize(email)
    @email = email
  end

  def valid?
    response = self.class.get('/', {
                                query: {
                                  api_key: Rails.application.credentials.email_api,
                                  email: @email
                                }
                              })
    response['is_valid_format'] ['value'] && !response['is_disposable_email']['value']
  end
end
