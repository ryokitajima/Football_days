class ApplicationController < ActionController::Base
  # Deviseコントローラーのアクションが実行される前に、許可されるパラメータをカスタマイズする
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  # サインアップ時に許可するパラメータをカスタマイズするためのメソッド
  def configure_permitted_parameters
    # devise_parameter_sanitizerメソッドを使用して、サインアップ時の許可パラメータに`:name`を追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
