require 'rails_helper'

RSpec.describe Workout, type: :model do
  describe '#validates' do
    context 'name.uniqueness' do
      context '同じユーザーが作成した種目の場合' do
        let(:user) { create(:user) }
        let(:body_part1) { create(:body_part, user:, name: '胸') }
        let(:body_part2) { create(:body_part, user:, name: '上腕三頭筋') }
        let!(:existing_workout) { create(:workout, user:, body_part: body_part1, name: 'ベンチプレス') }

        context '同じ対象部位で既に存在する種目名を指定した場合' do
          let(:workout) { described_class.new(user:, body_part: body_part1, name: 'ベンチプレス') }

          it 'バリデーションエラーになる' do
            expect(workout.valid?).to be_falsey
          end
        end

        context '異なる対象部位を指定した場合' do
          let(:workout) { described_class.new(user:, body_part: body_part2, name: 'ベンチプレス') }

          it 'バリデーションを通過する' do
            expect(workout.valid?).to be_truthy
          end
        end
      end

      context '異なるユーザーが作成した種目の場合' do
        let(:user) { create(:user) }
        let(:other_user) { create(:user) }
        let(:body_part) { create(:body_part, user:) }
        let(:workout) { create(:workout, user:, body_part:, name: 'ベンチプレス') }

        before do
          create(:workout, user: other_user, body_part:, name: 'ベンチプレス')
        end

        it 'バリデーションを通過する' do
          expect(workout.valid?).to be_truthy
        end
      end
    end
  end
end
