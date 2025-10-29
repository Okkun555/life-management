require 'rails_helper'

RSpec.describe 'Api::Profiles', type: :request do
  let(:user) { create(:user) }

  before do
    login(user)
  end

  describe 'GET /api/profile' do
    context '操作ユーザーのプロフィールが存在しない場合' do
      before do
        subject
      end

      it '404ステータスを返却する' do
        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['message']).to eq('プロフィールは存在しません')
      end
    end

    context '操作ユーザーのプロフィールが存在する場合' do
      context '画像の設定がない場合' do
        let!(:profile) { create(:profile, user:) }

        before do
          subject
        end

        it '200ステータスとプロフィール情報（プロフィール画像はnil）を返却する' do
          expect(response).to have_http_status(:ok)
          expect(response.parsed_body).to eq({
                                               'id' => profile.id,
                                               'name' => profile.user.name,
                                               'birthday' => profile.birthday.to_s,
                                               'age' => profile.age,
                                               'sex' => profile.sex,
                                               'is_public' => profile.is_public,
                                               'avatar_url' => nil
                                             })
        end
      end

      context '画像の設定がある場合' do
        let!(:profile) { create(:profile, :with_avatar, user:) }

        before do
          subject
        end

        it '200ステータスとプロフィール情報（画像URL付き）を返却する' do
          expect(response).to have_http_status(:ok)

          response_body = response.parsed_body
          expect(response_body['id']).to eq(profile.id)
          expect(response_body['name']).to eq(profile.user.name)
          expect(response_body['birthday']).to eq(profile.birthday.to_s)
          expect(response_body['age']).to eq(profile.age)
          expect(response_body['sex']).to eq(profile.sex)
          expect(response_body['is_public']).to eq(profile.is_public)
          expect(response_body['avatar_url']).to be_present
          expect(response_body['avatar_url']).to include('sample_avatar.jpg')
        end
      end
    end
  end

  describe 'POST /api/profile' do
    let(:birthday) { Date.new(1990, 1, 1) }
    let(:sex) { 1 }
    let(:is_public) { true }

    context '正常系' do
      context 'プロフィール画像を設定しない場合' do
        let(:params) { { profile: { birthday:, sex:, is_public:, avatar: nil } } }

        it '201ステータスを返却し、プロフィールデータを作成する' do
          expect { subject }.to change { Profile.count }.by(1)
          expect(response).to have_http_status(:created)
        end
      end

      context 'プロフィールが画像を設定する場合' do
        let(:avatar_image) { fixture_file_upload('/spec/fixtures/files/sample_avatar.jpg') }
        let(:params) { { profile: { birthday:, sex:, is_public:, avatar: nil } } }

        it '201ステータスを返却し、プロフィールデータを作成する' do
          expect { subject }.to change { Profile.count }.by(1)
          expect(response).to have_http_status(:created)
        end
      end
    end

    context '異常系' do
      let(:params) { { profile: { birthday:, sex:, is_public:, avatar: nil } } }

      context '操作ユーザーのプロフィールが既に存在する場合' do
        before do
          create(:profile, user:)
        end

        it '422ステータスを返却し、新たなデータを作成しない' do
          expect { subject }.not_to(change { Profile.count })
          expect(response).to have_http_status(:conflict)
        end
      end

      context '生年月日の値が不正な場合' do
        let(:params) { { profile: { birthday:, sex:, is_public:, avatar: nil } } }

        context '未入力の場合' do
          let(:birthday) { '' }

          it '422ステータスとエラーを返却する' do
            expect { subject }.not_to(change { Profile.count })
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

        context '未来日の場合' do
          let(:birthday) { Date.new(1990, 1, 2) }

          before do
            travel_to('1990/01/01 00:00:00')
          end

          it '422ステータスとエラーを返却する' do
            expect { subject }.not_to(change { Profile.count })
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.parsed_body).to eq({
                                                 'message' => '入力内容に不備があります',
                                                 'errors' => [
                                                   {
                                                     'field' => 'birthday',
                                                     'message' => '生年月日は1990-01-01以前の日付にしてください'
                                                   }
                                                 ]
                                               })
          end
        end
      end

      context '性別の値が不正な場合' do
        let(:sex) { '' }

        it '422ステータスとエラーを返却する' do
          expect { subject }.not_to(change { Profile.count })
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

      context '公開設定の値が不正な場合' do
        let(:is_public) { '' }

        it '422ステータスとエラーを返却する' do
          expect { subject }.not_to(change { Profile.count })
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body).to eq({
                                               'message' => '入力内容に不備があります',
                                               'errors' => [
                                                 {
                                                   'field' => 'is_public',
                                                   'message' => 'プロフィールの公開設定を設定しなおしてください'
                                                 }
                                               ]
                                             })
        end
      end
    end
  end

  describe 'PUT /api/profile' do
    let(:birthday) { Date.new(1990, 1, 2) }
    let(:sex) { 'man' }
    let(:is_public) { true }

    context '正常系' do
      let(:params) { { profile: { birthday:, sex:, is_public:, avatar: nil } } }
      let!(:profile) { create(:profile, user:, birthday: Date.new(1990, 1, 1), sex: 2, is_public: false) }

      it 'プロフィールを更新し、204ステータスを返却する' do
        expect { subject }.not_to(change { Profile.count })
        expect(response).to have_http_status(:no_content)

        target_profile = Profile.find(profile.id)
        expect(target_profile.birthday).to eq(birthday)
        expect(target_profile.sex).to eq(sex)
        expect(target_profile.is_public).to eq(is_public)
      end
    end

    context '異常系' do
      context '対象のユーザーのプロフィールが存在しない場合' do
        it '404ステータスとエラーを返却する' do
          subject
          expect(response).to have_http_status(:not_found)
          expect(response.parsed_body['message']).to eq('プロフィールは存在しません')
        end
      end
    end
  end
end
