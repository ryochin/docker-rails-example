# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'up', type: :feature do
  describe '#index' do
    it 'returns a success response' do
      visit up_path

      expect(page).to have_http_status(:success)
    end
  end

  describe '#databases' do
    it 'returns a success response' do
      visit up_databases_path

      expect(page).to have_http_status(:success)
    end
  end
end
