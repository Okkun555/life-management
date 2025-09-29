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
        expect(response).to have_http_status(:conflict)
        expect(response.parsed_body['error']).to eq('プロフィールはすでに存在します')
      end
    end
  end

  describe 'PUT /api/profile' do
    let(:params) { { profile: { birthday:, sex:, is_public: } } }
    let(:birthday) { Date.new(1990, 1, 1) }
    let(:sex) { 'woman' }
    let(:is_public) { false }

    context 'プロフィールが存在する場合' do
      let!(:profile) { create(:profile, user:, birthday: Date.new(1980, 1, 1), sex: 0, is_public: true) }

      before { subject }

      it '204ステータスが返却され、プロフィールが更新される' do
        target = Profile.find(profile.id)

        expect(response).to have_http_status(:no_content)
        expect(target.id).to eq(profile.id)
        expect(target.birthday).to eq(birthday)
        expect(target.sex).to eq(sex)
        expect(target.is_public).to eq(is_public)
      end
    end

    context 'プロフィールが存在しない場合' do
      before { subject }

      it '422ステータスが返却される' do
        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['error']).to eq('プロフィールは存在しません')
      end
    end
  end
end
