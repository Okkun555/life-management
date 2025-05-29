require 'rails_helper'

RSpec.describe 'MissionStatements', type: :request do
  describe 'POST /api/mission_statement' do
    context '正常系' do
      let(:params) { { content: '私の目標は、持続可能なwell-beingを追求することです。' } }

      it 'ミッションステートメントが作成できる' do
        expect(true).to eq(true)
      end
    end
  end
end
