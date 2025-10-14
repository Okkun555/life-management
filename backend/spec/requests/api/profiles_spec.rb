require 'rails_helper'

RSpec.describe 'Api::Profiles', type: :request do
  let(:user) { create(:user) }

  before { login(user) }

  describe 'GET /api/profile' do
    context 'ログインユーザーのプロフィールが存在しない場合' do
      before { subject }

      it '404ステータスが返却される' do
        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['message']).to eq('プロフィールは存在しません')
      end
    end

    context 'ログインユーザーのプロフィールが存在する場合' do
      let!(:profile) { create(:profile, user:) }

      before { subject }

      it '200ステータスとプロフィール情報を返却する' do
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq({
                                             'id' => profile.id,
                                             'name' => profile.user.name,
                                             'birthday' => profile.birthday.to_s,
                                             'age' => profile.age,
                                             'sex' => profile.sex,
                                             'is_public' => profile.is_public
                                           })
      end
    end
  end

  describe 'POST /api/profile' do
    let(:params) { { profile: { birthday:, sex:, is_public: } } }
    let(:birthday) { Date.new(1990, 1, 1) }
    let(:sex) { 1 }
    let(:is_public) { true }

    context '正常なパラメータの場合' do
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
          expect(response.parsed_body['message']).to eq('プロフィールはすでに存在します')
        end
      end
    end

    context '異常なパラメータの場合' do
      before { subject }

      context '生年月日の値が不正' do
        context '未入力の場合' do
          let(:birthday) { '' }

          it '422ステータスとエラーメッセージが返却される' do
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.parsed_body).to eq({
                                                 'message' => '入力内容に不備があります',
                                                 'errors' => [
                                                   {
                                                     'field' => 'birthday',
                                                     'message' => '生年月日を入力してください'
                                                   }
                                                 ]
                                               })
          end
        end
      end

      context '性別の値が不正' do
        context '未入力の場合' do
          let(:sex) { '' }

          it '422ステータスとエラーメッセージが返却される' do
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.parsed_body).to eq({
                                                 'message' => '入力内容に不備があります',
                                                 'errors' => [
                                                   {
                                                     'field' => 'sex',
                                                     'message' => '性別を入力してください'
                                                   }
                                                 ]
                                               })
          end
        end
      end

      context '公開設定の値が不正' do
        context '未入力の場合' do
          let(:is_public) { '' }

          it '422ステータスとエラーメッセージが返却される' do
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.parsed_body).to eq({
                                                 'message' => '入力内容に不備があります',
                                                 'errors' => [
                                                   {
                                                     'field' => 'is_public',
                                                     'message' => 'プロフィールの公開設定は一覧にありません'
                                                   }
                                                 ]
                                               })
          end
        end
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
        expect(response.parsed_body['message']).to eq('プロフィールは存在しません')
      end
    end
  end
end
