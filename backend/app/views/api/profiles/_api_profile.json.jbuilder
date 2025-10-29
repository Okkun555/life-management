json.extract! api_profile, :id, :sex, :is_public, :birthday
json.name api_profile.user.name
json.age api_profile.age

if api_profile.avatar.attached?
  json.avatar_url rails_blob_url(api_profile.avatar)
else
  json.avatar_url nil
end
