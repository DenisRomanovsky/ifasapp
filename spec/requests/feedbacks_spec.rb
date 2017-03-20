require 'rails_helper'

RSpec.describe 'Feedbacks', type: :request do
  describe 'post /feedbacks' do
    let!(:user) { FactoryGirl.create(:user) }
    let (:text) {Faker::Lorem.paragraph}
    let!(:category) {FactoryGirl.create(:mechanism_category)}

    before do
      ApplicationController.any_instance.stub(:authenticate_user!).and_return(true)
      ApplicationController.any_instance.stub(:current_user).and_return(user)
    end

    context 'feedback is saved' do

      before do
        post feedbacks_path, {feedback: { feedback_text: text }}
      end

      it 'create a feedback' do
        expect(response).to have_http_status(302)
        expect(Feedback.all.size).to eq(1)
        expect(Feedback.first.feedback_text).to eq(text)
        expect(Feedback.first.user_id).to eq(user.id)
      end

      it 'sends an email after creation' do
        expect(ActionMailer::Base.deliveries.size).to eq(1)
      end
    end

    context 'input validations' do
      it 'empty text' do
        post feedbacks_path, {feedback: { feedback_text: '' }}
        response.should render_template('new')
        expect(Feedback.all.size).to eq(0)
      end

      it 'long text' do
        post feedbacks_path, {feedback: { feedback_text: '' }}
        response.should render_template('new')
        expect(Feedback.all.size).to eq(0)
      end
    end
  end
end
