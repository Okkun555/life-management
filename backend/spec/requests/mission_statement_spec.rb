require 'rails_helper'

RSpec.describe 'MissionStatements', type: :request do
  describe 'POST /api/mission_statement' do
    let(:params) { { name: 'test' } }

    context '正常系' do
      it 'ミッションステートメントが作成できる' do
        expect { subject }.to change(MissionStatement, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(MissionStatement.last.name).to eq 'test'
      end
    end

    context '異常系' do
      context '名前が空の場合' do
        let(:params) { { name: '' } }

        it '作成に失敗する' do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
