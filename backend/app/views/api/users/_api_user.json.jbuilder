json.extract! user, :id, :name

profile = user.profile
if profile.present?
  json.has_profile true
  json.age profile.age
  json.sex profile.sex
  json.is_public profile.is_public
  json.avatar profile.avatar.attached? ? rails_blob_url(profile.avatar) : nil
else
  json.has_profile false
end
