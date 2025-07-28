require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_datetime' do
    context '引数がnilの場合' do
      it 'ArgumentErrorの例外がthrowされる' do
        expect { helper.format_datetime(nil) }.to raise_error(ArgumentError)
      end
    end

    context '引数が存在する場合' do
      it '日時がフォーマットされて返却される' do
        datetime = Time.zone.local(2025, 7, 29, 10, 0, 0)
        expect(helper.format_datetime(datetime)).to eq(datetime.strftime('2025/07/29 10:00:00'))
      end
    end
  end
end
