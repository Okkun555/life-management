# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/users/show.json.jbuilder', type: :view do
  describe 'render' do
    let(:user) { create(:user) }
    context 'プロフィールが未設定の場合' do
      before do
        assign(:user, user)
        render
      end

      it 'レスポンスのチェック' do
        parsed_json = JSON.parse(rendered)
        expect(parsed_json).to eq({
                                    'id' => user.id,
                                    'name' => user.name,
                                    'has_profile' => false
                                  })
      end
    end

    context 'プロフィールが設定済みの場合' do
      let!(:profile) { create(:profile, user:) }

      before do
        assign(:user, user)
        render
      end

      it 'レスポンスのチェック' do
        parsed_json = JSON.parse(rendered)
        expect(parsed_json).to eq({
                                    'id' => user.id,
                                    'name' => user.name,
                                    'has_profile' => true,
                                    'age' => profile.age,
                                    'sex' => profile.sex,
                                    'is_public' => profile.is_public,
                                    'avatar_url' => nil
                                  })
      end
    end
  end
end
