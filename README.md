## Football days

## サイト概要
### サイトテーマ
サッカー好きのためのコミュニティサイト

### テーマを選んだ理由
国内・海外サッカーが好きで、毎週観戦が趣味になっています。
リモートワークや友人の転勤等で身近なサッカー好きと直接会って話せる機会も減り、お互いの好きなチームによっては試合時間が大幅に異なるため、
いつでも情報が発信できサッカー好きの繋がりの輪を広げるられるサイトが欲しいと思いテーマとしました。

### ターゲットユーザ
- サッカー好き
- 観戦後の意見を語り合いたい方
- 友人以外のコミュニティでサッカー好きと繋がりたい方
- サッカーの情報を集めたい方

### 主な利用シーン
- 試合観戦後の感想を発信したい時
- 他の人の意見を確認したい時
- 試合情報や移籍情報など情報を集めたい時
- サッカーにおいて自分と価値観が合うユーザを見つけたい時
- サッカー好き仲間を見つけたい時
- ただしユーザの画像は投稿可能にし、試合の画像や映像は投稿機能として準備しない

## 設計書


## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- 使用検討中です


##メモ
会員情報編集ページのパスワードを表示したい（質問する！）



public/shared/_link.html.erb削除文
<%- if devise_mapping.recoverable? && controller_name != 'passwords' && controller_name != 'registrations' %>
  <%= link_to "Forgot your password?", new_password_path(resource_name) %><br />
<% end %>

<%- if devise_mapping.confirmable? && controller_name != 'confirmations' %>
  <%= link_to "Didn't receive confirmation instructions?", new_confirmation_path(resource_name) %><br />
<% end %>

<%- if devise_mapping.lockable? && resource_class.unlock_strategy_enabled?(:email) && controller_name != 'unlocks' %>
  <%= link_to "Didn't receive unlock instructions?", new_unlock_path(resource_name) %><br />
<% end %>

<%- if devise_mapping.omniauthable? %>
  <%- resource_class.omniauth_providers.each do |provider| %>
    <%= button_to "Sign in with #{OmniAuth::Utils.camelize(provider)}", omniauth_authorize_path(resource_name, provider), data: { turbo: false } %><br />
  <% end %>
<% end %>
