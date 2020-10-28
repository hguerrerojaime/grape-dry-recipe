# frozen_string_literal: true

require 'securerandom'

module DataHelper
  def generate_id
    SecureRandom.uuid.split('-').join
  end
end
