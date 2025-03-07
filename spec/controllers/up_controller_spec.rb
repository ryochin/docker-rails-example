# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index

      expect(response).to be_successful
    end
  end

  describe 'GET #databases' do
    it 'returns a success response' do
      get :databases

      expect(response).to be_successful
    end
  end
end
