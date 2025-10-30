json.extract! user, :id, :name

if user.profile.present?
  json.has_profile true
  json.age user.profile.age
  json.sex user.profile.sex
  json.is_public user.profile.is_public
else
  json.has_profile false
end
