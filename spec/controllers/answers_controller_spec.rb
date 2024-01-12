require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question, user: user) }

  describe 'POST #create' do
    context 'Authorized user creates answer with valid attributes' do
      before { login(user) }

      it 'saves the new answer in the database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js }.to change(question.answers, :count).by(1)
      end

      it 'created by current user' do
        post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js }
        expect(assigns(:answer).user_id).to eq(answer.user_id)
      end

      it 'renders create template' do
        post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end
    end

    context 'Authorized user creates answer with invalid attributes' do
      before { login(user) }

      it 'does not saves the answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid), format: :js } }.to_not change(Answer, :count)
      end

      it 'renders create template' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid), format: :js }
        expect(response).to render_template :create
      end
    end

    context 'Unauthorized user' do
      it 'tries to save a new answer to database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js } }.to_not change(Answer, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question: question, user: user) }

    context 'User is author' do
      before { login(user) }

      it 'check that answer was deleted' do
        delete :destroy, params: { id: answer }, format: :js
        expect(assigns(:answer)).to be_destroyed
      end

      it 'renders destroy view' do
        delete :destroy, params: { id: answer }, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'User is not author' do
      let(:other_user) { create(:user) }
      before { login(other_user) }

      it 'tries to delete answer' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'get empty response' do
        delete :destroy, params: { id: answer }, format: :js
        expect(response.body).to be_empty
      end
    end

    context 'Unauthorized user' do
      it 'tries to delete answer' do
        expect { delete :destroy, params: { id: answer }, format: :js }.to_not change(Answer, :count)
      end
    end
  end
  describe 'PATCH #update' do
    let!(:answer) { create(:answer, question: question, user: user) }

    context 'Authorized user edits his answer with valid attributes' do
      before { login(user) }

      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'Authorized user edits his answer with invalid attributes' do
      before { login(user) }

      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        end.to_not change(answer, :body)
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'User is not author' do
      let(:other_user) { create(:user) }
      before { login(:other_user) }

      it "tries to edit others's user answer" do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to_not eq 'new body'
      end
    end

    context 'Unauthorized user' do
      it 'tries to edit answer' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to_not eq 'new body'
      end

      it 'needs to login in order to proceed' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        expect(response.body).to have_content 'You need to sign in or sign up before continuing.'
      end
    end
  end

  it_behaves_like 'voted'
end
