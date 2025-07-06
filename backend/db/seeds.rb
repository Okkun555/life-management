# frozen_string_literal: true

# 開発用のユーザーを作成
users = [
  {
    email: 'development1@example.com',
    name: 'マイケル',
    supabase_uid: '11111111-1111-1111-1111-111111111111'  
  },
  {
    email: 'development2@example.com',
    name: 'トム',
    supabase_uid: '22222222-2222-2222-2222-222222222222'
  }
]

users.each do |user| 
  User.find_or_create_by!(
    email: user[:email],
    name: user[:name],
    supabase_uid: user[:supabase_uid]
  )
end