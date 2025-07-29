module ApiHelpers
  def login(user)
    headers['Accept'] = 'application/json'
    headers['Content-Type'] = 'application/json'
    headers['X-Dev-User-UID'] = user.supabase_uid
  end

  def logout
    headers.delete('X-Dev-User-UID')
  end
end
