# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pages', type: :feature do
  describe '#index' do
    it 'returns a success response' do
      visit root_path

      expect(page).to have_http_status(:success)
    end

    it 'has a valid title' do
      visit root_path

      expect(page).to have_title('Docker + Rails')
    end
  end
end
