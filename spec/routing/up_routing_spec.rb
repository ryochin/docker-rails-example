# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/up').to route_to('up#index')
    end

    it 'routes to #databases' do
      expect(get: '/up/databases').to route_to('up#databases')
    end
  end
end
