require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe '#age' do
    let(:user) { create(:user) }
    let(:target_day) { Date.new(2025, 10, 5) }

    context '誕生日が登録されていない場合' do
      let(:profile) { described_class.new(user:, birthday: nil) }

      it 'nilを返却する' do
        expect(profile.age(as_of: target_day)).to be_nil
      end
    end

    context '誕生日が登録されている場合' do
      context 'その年の誕生日を既に迎えている場合' do
        let(:profile) { described_class.new(user:, birthday: Date.new(1990, 10, 1)) }

        it '正しい年齢を返却する' do
          expect(profile.age(as_of: target_day)).to eq 35
        end
      end

      context 'その年の誕生日当日の場合' do
        let(:profile) { described_class.new(user:, birthday: Date.new(1990, 10, 5)) }

        it '正しい年齢を返却する' do
          expect(profile.age(as_of: target_day)).to eq 35
        end
      end

      context 'その年の誕生日を迎えていない場合' do
        let(:profile) { described_class.new(user:, birthday: Date.new(1990, 10, 10)) }

        it '正しい年齢を返却する' do
          expect(profile.age(as_of: target_day)).to eq 34
        end
      end
    end
  end
end
