require 'rails_helper'

RSpec.describe 'Api::Workouts', type: :request do
  let(:user) { create(:user) }
  let(:body_part) { create(:body_part, user:, name: '胸') }

  before do
    login(user)
  end

  describe 'POST /api/workouts' do
    context '正常な場合' do
      let(:name) { 'ベンチプレス' }
      let(:description) { '低レップ高重量' }
      let(:params) { { workout: { name:, description:, body_part_id: body_part.id } } }

      it '201ステータスを返却し、新規作成する' do
        expect { subject }.to change { Workout.count }.by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context '存在しない部位IDを指定した場合' do
      let(:name) { 'ベンチプレス' }
      let(:description) { '低レップ高重量' }
      let(:params) { { workout: { name:, description:, body_part_id: 99_999 } } }

      it '404ステータスをエラーメッセージを返却する' do
        expect { subject }.not_to(change { Workout.count })
        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['message']).to eq('部位情報が存在しません')
      end
    end
  end
end
