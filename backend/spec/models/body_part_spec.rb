require 'rails_helper'

RSpec.describe BodyPart, type: :model do
  describe '#full_name' do
    let(:user) { create(:user) }

    context '自身が親の場合' do
      let(:body_part) { described_class.new(user:, name: '親', ancestry: nil) }

      it '自身を返却する' do
        expect(body_part.full_name).to eq('親')
      end
    end

    context '自身が子の場合' do
      let(:body_part_parent) { create(:body_part, name: '親', user:) }
      let(:body_part_child) { create(:body_part, name: '子', parent: body_part_parent, user:) }

      it '親/自身の形式で返却する' do
        expect(body_part_child.full_name).to eq('親/子')
      end
    end

    context '自身が孫の場合' do
      let(:body_part_parent) { create(:body_part, name: '親', user:) }
      let(:body_part_child) { create(:body_part, name: '子', parent: body_part_parent, user:) }
      let(:body_part_grandchild) { create(:body_part, name: '孫', parent: body_part_child, user:) }

      it '祖父/親/自身の形式で返却する' do
        expect(body_part_grandchild.full_name).to eq('親/子/孫')
      end
    end
  end
end
