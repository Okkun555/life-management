require 'rails_helper'

RSpec.describe 'Api::Users', type: :request do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile, user:) }

  describe 'GET /api/users/me' do
    context 'ログイン済の場合' do
      before do
        login(user)
        subject
      end

      it '200ステータスとユーザー情報を返却する' do
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq({
                                             'id' => user.id,
                                             'name' => user.name,
                                             'has_profile' => true,
                                             'age' => profile.age,
                                             'sex' => profile.sex,
                                             'is_public' => profile.is_public
                                           })
      end
    end

    context '未ログインの場合' do
      it '401エラーを返却する' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
