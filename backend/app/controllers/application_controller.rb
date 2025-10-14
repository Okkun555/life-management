class ApplicationController < ActionController::API
  include Pundit::Authorization

  before_action :authenticate_user!

  # MEMO: rescue_fromは後で書いたものが優先される
  # 今後エラーを追加する場合も、StandardErrorは最上位に定義する
  rescue_from StandardError, with: :handle_standard_error
  rescue_from ActiveRecord::RecordInvalid, with: :handle_validation_error

  attr_reader :current_user

  def render_error(key, status:)
    render json: {
      message: I18n.t(key)
    }, status:
  end

  private

  def authenticate_user!
    return if Rails.env.local? && authenticate_with_stub

    authenticate_with_jwt
  end

  # 開発環境用のスタブ認証
  def authenticate_with_stub
    uid = request.headers['X-Dev-User-UID']

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

  def handle_validation_error(exception)
    errors = exception.record.errors.map do |error|
      {
        field: error.attribute,
        message: error.full_message
      }
    end
    render json: {
      message: '入力内容に不備があります',
      errors: errors
    }, status: :unprocessable_entity
  end

  def handle_standard_error
    render json: { error: '予期せぬエラーが発生しました。管理者にお問い合わせください。' }, status: :internal_server_error
  end
end
