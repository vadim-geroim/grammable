require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  subject { create :gram }

  describe "grams#destroy action" do
    it "should allow a user to destroy grams" do
      gram = create :gram
      delete :destroy, params: { id: gram.id }
      expect(response).to redirect_to(root_path)
      gram = Gram.find_by_id(gram.id)
      expect(gram).to be_nil
    end

    it "should return 404 error if the gram is not found with the id that is specified" do
      delete :destroy, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "grams#update action" do
    it "should allow users to successfully update grams" do
        gram = create(:gram, message: 'Initial Value')
        patch :update, params: { id: gram.id, gram: { message: 'Changed' } } 
        expect(response).to redirect_to(root_path)
        gram.reload
        expect(gram.message).to eq('Changed')
    end

    it "should have http 404 error if the gram is not found" do
        patch :update, params: { id: 0, gram: { message: 'Changed'} }
        expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      gram = create(:gram, message: 'Initial Value')
      patch :update, params: { id: gram.id, gram: { message: ''} }
      expect(response).to have_http_status(:unprocessable_entity)
      gram.reload
      expect(gram.message).to eq('Initial Value')
    end
  end

  describe "grams#edit action" do
    it "should successfully show the edit form if the gram is found" do
      get :edit, params: { id: subject.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the gram is not found" do
      get :edit, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "grams#show action" do
    it "should successfully show the page if the gram is found" do
      get :show, params: { id: subject.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the gram is not found" do 
      get :show, params: { id: 'TACOCAT' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#new action" do
    it "should successfully show the new form" do
      user = create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end

    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path

    end
  end

  describe "grams#create action" do
    it "should require users to be logged in" do
      post :create, params: { gram: { message: 'Hello!' } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new record" do
      user = create(:user)
      sign_in user
      post :create, params: { gram: { message: 'Hello!' } }
      expect(response).to redirect_to root_path
      gram = Gram.last
      expect(gram.message).to eq("Hello!")
      expect(gram.user).to eq user
    end

    it "should properly deal with validation errors" do
      user = create(:user)
      sign_in user
      post :create, params: { gram: { message: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Gram.count).to eq 0
    end
  end
end
