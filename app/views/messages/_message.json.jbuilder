# frozen_string_literal: true

json.extract! message, :id, :content, :content_answer, :photo_answer, :created_at, :updated_at
json.url message_url(message, format: :json)
