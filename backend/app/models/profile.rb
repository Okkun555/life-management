class Profile < ApplicationRecord
  belongs_to :user

  validates :birthday, presence: true,
                       comparison: { greater_than_or_equal_to: Date.new(1900, 1, 1), less_than_or_equal_to: Date.current }
  validates :sex, presence: true
  validates :is_public, inclusion: { in: [true, false] }

  enum :sex, { secret: 0, man: 1, woman: 2 }

  # 年齢を整数で返す
  # デフォルトは今日時点（対象日時点での年齢を計算する場合、引数に対象日を指定）
  def age(as_of: Date.current)
    return nil unless birthday

    years_diff = as_of.year - birthday.year

    # 誕生日を迎えていない場合は 1 年引く
    had_birthday = (as_of.month > birthday.month) || (as_of.month == birthday.month && as_of.day >= birthday.day)
    years_diff -= 1 unless had_birthday
    years_diff
  end
end
