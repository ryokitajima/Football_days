class Admin::SearchesController < ApplicationController
	before_action :authenticate_admin!
  def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = Article.search_for(@content, @method)
		end
  end
end
