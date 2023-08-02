class Public::SearchesController < ApplicationController
	
	# 検索結果を表示するアクション
	def search
		# 検索対象のモデル名を受け取る
		@model = params[:model]
		# 検索キーワードを受け取る
		@content = params[:content]
		# 検索方法を受け取る
		@method = params[:method]
		# ユーザーモデルを検索する場合
		if @model == 'user'
			# Userモデルのsearch_forメソッドを呼び出して検索結果を取得
			@records = User.search_for(@content, @method)
		# Articleモデルを検索する場合
		else
			# Articleモデルのsearch_forメソッドを呼び出して検索結果を取得
			@records = Article.search_for(@content, @method)
		end
	end

end
