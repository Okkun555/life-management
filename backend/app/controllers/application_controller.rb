class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    if Rails.env.development? && authenticate_with_stub
      return
    end

    authenticate_with_jwt
  end
  
  # 開発環境用のスタブ認証
  def authenticate_with_stub
    uid = request.headers['X-Dev-User-UID']
    return false unless uid

    @current_user = User.find_by(supabase_uid: uid)

    if @current_user.nil?
      render json: {
        error: "Development Stub: User with UID '#{uid}' not found." 
      }, status: :unauthorized
    else 
      true
    end
  end

  # JWTを使った認証
  def authenticate_with_jwt
    # 本番環境用のロジックを追加する
  end
end
