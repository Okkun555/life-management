require 'rails_helper'

RSpec.describe 'Api::Profiles', type: :request do
  let(:user) { create(:user) }

  before { login(user) }

  describe 'POST /api/profile' do
    let(:params) { { profile: { birthday:, sex:, is_public: } } }
    let(:birthday) { Date.new(1990, 1, 1) }
    let(:sex) { 1 }
    let(:is_public) { true }

    context 'プロフィールが存在しない場合' do
      before { subject }

      it '201ステータスが返却される' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'プロフィールが存在する場合' do
      before do
        create(:profile, user:)
        subject
      end

      it '422ステータスが返却される' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['error']).to eq('プロフィールはすでに存在します')
      end
    end
  end
end
