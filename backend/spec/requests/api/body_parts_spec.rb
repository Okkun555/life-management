require 'rails_helper'

RSpec.describe 'Api::BodyParts', type: :request do
  let(:user) { create(:user) }

  before do
    login(user)
  end

  describe 'GET /api/body_parts' do
    context '部位情報が存在しない場合' do
      it '200ステータスと空配列を返却する' do
        subject
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq([])
      end
    end

    context '部位情報が存在する場合' do
      # 親→子→孫の3階層データを作成
      let!(:parent) { create(:body_part, name: '上半身', user:) }
      let!(:child) { create(:body_part, name: '胸', parent:, user:) }
      let!(:grandchild) { create(:body_part, name: '大胸筋上部', parent: child, user:) }

      it '200ステータスと部位情報を配列で返却する' do
        subject
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq([
                                             {
                                               'id' => parent.id,
                                               'name' => parent.name,
                                               'parent_id' => nil,
                                               'full_name' => parent.name
                                             },
                                             {
                                               'id' => child.id,
                                               'name' => child.name,
                                               'parent_id' => parent.id,
                                               'full_name' => "#{parent.name}/#{child.name}"
                                             },
                                             {
                                               'id' => grandchild.id,
                                               'name' => grandchild.name,
                                               'parent_id' => child.id,
                                               'full_name' => "#{parent.name}/#{child.name}/#{grandchild.name}"
                                             }
                                           ])
      end
    end
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

  describe 'DELETE /api/body_parts/:id' do
    context '削除対象のデータが存在しない場合' do
      let(:id) { 999_999 } # 存在しないID

      it '404ステータスを返却する' do
        expect { subject }.not_to(change { BodyPart.count })
        expect(response).to have_http_status(:not_found)
      end
    end

    context '削除対象のデータが存在する場合' do
      context '紐づく階層がない場合' do
        let!(:body_part) { create(:body_part, user:) }
        let(:id) { body_part.id }

        it '200ステータスを返却し、データを削除する' do
          expect { subject }.to change { BodyPart.count }.by(-1)
          expect(response).to have_http_status(:ok)
        end
      end

      context '紐づく階層がある場合' do
        let!(:parent) { create(:body_part, user:) }
        let!(:child) { create(:body_part, parent:, user:) }

        context '削除対象が親の場合' do
          let(:id) { parent.id }

          it '200ステータスを返却し、親、子データを削除する' do
            expect { subject }.to change { BodyPart.count }.by(-2)
            expect(response).to have_http_status(:ok)
          end
        end

        context '削除対象が子の場合' do
          let(:id) { child.id }

          it '200ステータスを返却し、子データのみ削除する' do
            expect { subject }.to change { BodyPart.count }.by(-1)
            expect(response).to have_http_status(:ok)
          end
        end
      end
    end
  end
end
