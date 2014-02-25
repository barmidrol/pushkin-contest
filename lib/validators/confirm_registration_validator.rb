class ConfirmRegistrationValidator < ActiveModel::Validator

  QUESTION = 'Буря мглою небо кроет, Вихри %WORD% крутя'.freeze
  ANSWER = 'снежные'.freeze
  RESPONSE_IDLE_TIME = 1.freeze

  def validate(record)
    return if record.errors.present?

    uri = URI.parse(record.url)
    uri.path = '/registration'
    data = {question: QUESTION, token: record.token}
    options = {content_type: :json, accept: :json, timeout: RESPONSE_IDLE_TIME}

    begin

      response = RestClient.post uri.to_s, data.to_json, options
      json = JSON.parse(response)
      self.errors.add(:url, 'Wrong or blank answer form server!') unless json["answer"].downcase == ANSWER

    rescue RestClient::RequestTimeout => e
      record.errors.add(:url, 'Registration time exceed')

    rescue Exception => e
      record.errors.add(:url, 'Error on request confirmation!')
    end

  end
end
