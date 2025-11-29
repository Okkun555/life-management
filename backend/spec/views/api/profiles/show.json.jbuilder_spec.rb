# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/profiles/show.json.jbuilder', type: :view do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user:) }

  before do
    assign(:profile, profile)
    render
  end

  describe 'render' do
    it 'レスポンスのチェック' do
      parsed_json = JSON.parse(rendered)
      expect(parsed_json).to eq({
                                  'id' => profile.id,
                                  'name' => profile.user.name,
                                  'birthday' => profile.birthday.to_s,
                                  'age' => profile.age,
                                  'sex' => profile.sex,
                                  'is_public' => profile.is_public,
                                  'avatar_url' => nil
                                })
    end
  end
end
