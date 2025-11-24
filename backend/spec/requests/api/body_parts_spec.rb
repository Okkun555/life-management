require 'rails_helper'

RSpec.describe 'Api::BodyParts', type: :request do
  let(:user) { create(:user) }

  before do
    login(user)
  end

  describe 'POST /api/body_parts' do
    context '階層が正常な場合' do
      context '親階層がない場合' do
        let(:name) { '上半身' }
        let(:parent_id) { nil }
        let(:params) { { body_part: { name:, parent_id: } } }

        it '201ステータスを返却し、新規作成する' do
          expect { subject }.to change { BodyPart.count }.by(1)
          expect(response).to have_http_status(:created)
        end
      end

      context '親階層がある場合' do
        # 親階層の部位
        let!(:parent) { create(:body_part, user:) }
        let(:name) { '胸' }
        let(:parent_id) { parent.id }
        let(:params) { { body_part: { name:, parent_id: } } }

        it '201ステータスを返却し、新規作成する' do
          expect { subject }.to change { BodyPart.count }.by(1)
          expect(response).to have_http_status(:created)
        end
      end
    end

    context '指定した親階層が存在しない場合' do
      let(:name) { '胸' }
      let(:parent_id) { 11 } # 存在しないID
      let(:params) { { body_part: { name:, parent_id: } } }

      it '' do
        expect { subject }.not_to(change { BodyPart.count })
        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['message']).to eq('指定された親部位が見つかりません')
      end
    end
  end
end
