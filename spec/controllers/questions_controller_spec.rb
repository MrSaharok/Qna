require 'rails_helper'
RSpec.describe QuestionsController, type: :controller do
  describe 'GET #index' do
    let(:question) { create_list(:question, 3) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:question)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end
end
