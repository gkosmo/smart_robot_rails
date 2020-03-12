# frozen_string_literal: true

class Message < ApplicationRecord
  has_one_attached :photo
  include IBMWatson

  def classify_pic
    authenticator = Authenticators::IamAuthenticator.new(
      apikey: ENV['VISR_IBM_KEY']
    )
    visual_recognition = VisualRecognitionV3.new(
      version: '2018-03-19',
      authenticator: authenticator
    )
    visual_recognition.service_url = ENV['VISR_IBM_URL']

    classes = visual_recognition.classify(url: photo.service.url(photo.key))
    puts JSON.pretty_generate(classes.result)
  end

  def content_analysis
    authenticator = Authenticators::IamAuthenticator.new(
      apikey: ENV['NLP_IBM_KEY']
    )

    natural_language_understanding = NaturalLanguageUnderstandingV1.new(
      version: '2019-07-12',
      authenticator: authenticator
    )
    natural_language_understanding.service_url = ENV['NLP_IBM_URL']

    response = natural_language_understanding.analyze(
      text: content,
      features: {
        categories: {},
        sentiment: {},
        relations: {},
        entities: {},
        keywords: {}
      }
    )

    puts JSON.pretty_generate(response.result)
  end
end
