`GitHub` の `issue` に追加する初期タスク一覧です。
必要に応じて変更しただいて構いません。

【注意】 以下の連番はあくまで仮のものです。「issue 番号」は GitHub で割り振られたものを使用しましょう。

![issue_number](public/readme_images/issue_number.png)

# 1. 開発環境の整備

## 実装内容

- 「開発環境・テスト環境のみ」にデバッグ用の gem を追加して，`bundle install` を実行

```
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # 次を追加
  gem 'pry-byebug'
end
```

- 次の`config/initializers/generators.rb`を作成
  - `rails g controller` コマンドで不要なものが作成されないようになります

```rb
Rails.application.config.generators do |g|
  g.stylesheets false
  g.skip_routes true
  g.helper false
end
```

- Herokuにプッシュした際に自動でマイグレーションを行う設定を追加
  - ターミナルから以下を実行すること

```zsh
echo "release: bin/rails db:migrate" > Procfile
```

# 2. トップページの追加

## 実装内容

- `texts` コントローラを作成し，indexアクションに対応するビューを トップページ にして下さい。
  - `rails g controller` コマンドを使用する場合は，不要なファイルを削除して下さい

※ index.html.erb の中身はデフォルトのままでOKです。別タスクとします。

# 3. ページ全体の設定を追加

## 実装内容

ページ全体に共通する内容が書かれているファイル `app/views/layouts/application.html.erb` の

```erb
    <%= yield %>
```

を

```erb
    <header>
    </header>
    <main>
      <#% max_width メソッドは application_helper.rb に記載 %>
      <div class="base-container <%= max_width %>">
        <%= yield %>
      </div>
    </main>
    <footer>
    </footer>
```

としておき，全ページに共通して必要なCSSを `app/assets/stylesheets/application.css` に設定して下さい。

```css
/* 全体 */ 

.base-container {
  margin: 0 auto;
  padding: 1rem;
}

/* max-width */ 

.mw-md {
  max-width: 720px;
}

.mw-lg {
  max-width: 960px;
}

.mw-xl {
  max-width: 1200px;
}
```

さらに，`max_width` メソッドを `app/helpers/application_helper.rb` に定義しましょう。後に条件分岐が必要ですが，現時点では `mw-xl` 固定としておきましょう。

```rb
module ApplicationHelper
  def max_width
    "mw-xl"
  end
end
```

# 4. モデル・テーブルの作成

## 実装内容

次のモデル・テーブルを作成して下さい

- Textモデルとtextsテーブルを作成
  - カラムは「`genre`（`integer型`）」「`title`（`string型`）」「`content`（`text型`）」

- Movieモデルとmoviesテーブルを作成
  - カラムは「`genre`（`integer型`）」「`title`（`string型`） 」と「`url`（`string型`）」

※モデルのバリデーションは別タスクとします

- `genre` カラムはそれぞれ以下の形式で「列挙型」にする

```rb
  enum genre: {
    invisible: 0, # 非表示
    basic: 1,
    git: 2,
    ruby: 3,
    rails: 4,
    php: 5,
    html: 6,
    javascript: 7,
    typescript: 8,
    react: 9,
    vue: 10,
    angular: 11,
    aws: 12,
    money: 13, # マネタイズ講座
    talk: 14, # 全ての勉強会
    live: 15, # 勉強会
  }
```

# 5. バリデーションを追加

【注意】「タスク4」はissue番号

![issue_number](public/readme_images/issue_number.png)

## 実装内容

★タスク4 完了後に行って下さい

- タスク4 で作成した2種類のモデルの各カラムに空データが入らないようにするバリデーションを追加

# 6. ログイン機能の実装

## 実装内容

- `devise` を利用して，ユーザーのログイン機能を実装
  - 今回のアプリに不要な操作をしないようにすること
  - 編集用のビューファイルを作成しないようにすること（`rails g devise:views` を実行しないこと）

- 新規登録・ログイン・ログアウトのリンクを，全てのページの一番上に追加
  - 条件分岐を利用して自然な表示とすること（ログインしているのにログインを表示してはならない）

- 以下の書式で `db/seeds.rb` にテスト用ユーザーを作成できるように設定
  - 何度実行してもエラーが出ないように `create!` ではなく `find_or_create_by!` を使用

```rb
EMAIL = 'test@example.com'
PASSWORD = 'password'

# テストユーザーが存在しないときだけ作成
User.find_or_create_by!(email: EMAIL) do |user|
  user.password = PASSWORD
  puts 'ユーザーの初期データインポートに成功しました。'
end
```

- 全てのページを「ログイン必須」に変更
  - `authenticate_user!` で検索しましょう

★日本語化，ナビバーの追加，ログイン画面の見た目を整える作業は別タスクにします。

## 参考文献

- [【公式】devise](https://github.com/heartcombo/devise)
- [やんばるエキスパート教材（ログイン機能）](https://www.yanbaru-code.com/texts/219)

# 7. 日本語化

【注意】「タスク6」はissue番号に

## 実装内容

★タスク6 完了後に行って下さい

- `rails-i18n`, `devise-i18n`のgemを追加し，必要な設定を行う

## 参考文献

- [【公式】rails-i18n](https://github.com/svenfuchs/rails-i18n)
- [【公式】devise-i18n](https://github.com/tigrish/devise-i18n)
- [やんばるエキスパート教材（ログイン機能）](https://www.yanbaru-code.com/texts/219)

# 8. Bootstrapの導入

## 実装内容

- Bootstrap を導入
  - Rails 5とは導入方法が異なりますので，注意して下さい
  - 混乱を避けるため css は Sprockets で扱うこと
  - トップページに動作確認用のボタンを1個配置すること

★ Bootstrap でスタイルを付ける作業は別タスクとする

## 参考文献

- [やんばるエキスパート教材（Bootstrap）](https://www.yanbaru-code.com/texts/216)

# 9. テキスト教材のCSVインポート機能を実装

## 実装内容

- `db/seeds.rb` に，テキスト教材のCSV（`db/csv_data/text_data.csv`）を読み込み texts テーブルにデータを投入する処理を追加
  - 先に `Text.delete_all` を入れ，実行時にデータを初期化できるようにしておくこと
  - `rails db:seed` を実行し，Railsコンソールなどで初期データが入ることを確認すること

## 参考文献

- [やんばるエキスパート教材（CSVインポート）](https://www.yanbaru-code.com/texts/217)

# 10. 動画教材のCSVインポート機能を実装

## 実装内容

- `db/seeds.rb` に，テキスト教材のCSV（`db/csv_data/movie_data.csv`）を読み込み movies テーブルにデータを投入する処理を追加
  - 先に `Movie.delete_all` を入れ，実行時にデータを初期化できるようにしておくこと
  - `rails db:seed` を実行し，Railsコンソールなどで初期データが入ることを確認すること

## 参考文献

- [やんばるエキスパート教材（CSVインポート）](https://www.yanbaru-code.com/texts/217)

# 11. 日本語ファイル・表示名の設定

【注意】「タスク7」はissue番号に置き換えて

## 実装内容

★タスク7 完了後に行って下さい

- `config/locales/ja.yml` に各モデル・カラムの日本語訳を設定
- `enum-help` を追加
- `texts`, `movies` テーブルの `genre` に対応する表示名 `config/locales/enums.ja.yml` に追加
  - 表示名の設定は `db/csv_data/genre_data.csv` を参考にして下さい

## 参考文献

- [列挙型（enum）とセレクトボックス](https://www.yanbaru-code.com/texts/351)

# 12. ナビバーの実装

【注意】「タスク7,8」はissue番号に置き換えて記載すること

## 実装内容

★タスク7,8 完了後に行って下さい

- Bootstrapを使い，逆転教材のナビバーに近いものを作成して下さい。
  - Bootstrapは「タスク8」で導入済みです。
  - 直接 `application.html.erb` に書き込まず，部分テンプレート `app/views/layouts/_header.html.erb` を作成して読み込むようにすること
  - 「タスク6」で作成された「新規登録・ログアウトなどのリンク」は削除して下さい
  - 元のアプリにはありませんが，「新規登録」のリンクも付けて下さい
  - ナビバーのリンクは，「新規登録」「ログイン」「ログアウト」と，「テキスト教材」ページのみ有効にし，他は href 属性を `#` にしておくこと
  - ナビバーは `fixed-top` クラスを利用して上に固定されるようにすること。また，ナビバーに隠れないようなスタイルの調整も行うこと。

## 参考文献

- [【公式】Bootstrap（Navbar）](https://getbootstrap.jp/docs/4.5/components/navbar/)

# 13. フラッシュの実装

【注意】「タスク8」はissue番号に置き換えて記載すること

## 実装内容

★タスク8完了後に行って下さい

- フラッシュの表示機能
  - ナビバー同様，横幅一杯とすること（headerタグの下）
  - 直接`application.html.erb`に書き込まず，部分テンプレート `app/views/layouts/_flash.html.erb` を作成して読み込むようにすること
  - ログイン・ログアウト時にフラッシュが表示されるようにしてください
  - フラッシュの作成はこの issue に含みません

- フラッシュの背景色を設定
  - Bootstrapに用意されているものを利用すること
  - `notice` は `alert-info`か`alert-success`, `alert` は `alert-danger` とすること

## 参考文献

- [【公式】Bootstrap（Alerts）](https://getbootstrap.jp/docs/4.5/components/alerts/)
- [やんばるエキスパート教材（メッセージ投稿アプリ その3）](https://www.yanbaru-code.com/texts/271)

# 14. devise関連ページのスタイルを修正

【注意】「タスク13」はissue番号に置き換えて記載すること

## 実装内容

- ログイン関連ページを日本語化
   - ビューファイルを作成する際は，多言語対応のビューファイルを作成できる `rails g devise:i18n:views` を使用すること。

- Bootstrapを利用してスタイルを修正
   - `devise-bootstrap-views` のgemを追加してビューファイルを上書き

※フラッシュは「タスク13」で追加しますので対応不要です
※パスワード再設定用のメール送信機能については何もしなくてOKです

# 15. 管理者画面の実装

【注意】「タスク6,11」はissue番号に置き換えて記載すること

## 実装内容

- 管理者画面を追加して下さい。
  - `rails-i18n`, `devise-i18n` の追加はタスク7で完了済
  - `ja.yml` の設定はタスク11で完了済

- `db/seeds.rb` をタスク6と同様の形式（何度実行してもエラーが出ない形式）に修正
  - 開発環境に限定する条件は不要

- ユーザー，動画，テキスト教材を管理者画面から追加できるように設定

- 管理者画面以外のスタイルに影響が出ないように対処すること

## 参考文献

- [【公式】Active Admin](https://github.com/activeadmin/activeadmin)
- [やんばるエキスパート教材 管理者画面](https://www.yanbaru-code.com/texts/220)

# 16. Railsテキスト教材一覧ページの実装

## 実装内容

- Railsテキスト教材の一覧ページを作成
  - Bootstrapの `Cards` や `Grid System` を用いてスタイルも似せること
  - 画像部分は[デフォルト画像](https://d5izmuz0mcjzz.cloudfront.net/texts/no_image.jpg)を表示するのみとする
  - 検索機能・読破済み機能も別タスクとする

- Railsテキスト教材で表示するジャンルは以下のものとすること

```rb
["basic", "git", "ruby", "rails"]
```

- ナビバーのテキスト教材ページへのリンクが機能するようにする

※Take off Railsなどの広告は削ること
※詳細ページへのリンク，詳細ページの作成は別タスクとします

## 参考文献

- [【公式】Bootstrap Cards](https://getbootstrap.jp/docs/4.5/components/card/)
- [【公式】Bootstrap Grid system](https://getbootstrap.jp/docs/4.5/layout/grid/)

# 17. Railsテキスト教材詳細ページの実装

【注意】「タスク16」はissue番号に置き換えて記載すること

## 実装内容

★タスク16完了後に行って下さい

- 一覧ページから詳細ページに移動できるようにする

- 詳細ページの実装
  - 「内容（content）」は Markdown に対応した表示ができるようにすること
  - スタイルはデフォルトのままでOKです
  - 「読破済み」機能は別タスクとする

# 18. Rails動画教材ページの実装

## 実装内容

- Rails動画教材の一覧ページを作成
  - 視聴済み機能・ページネーションは別タスクとする

- Rails動画教材で表示するジャンルは以下のものとすること

```rb
["basic", "git", "ruby", "rails"]
```

- ナビバーの動画教材ページへのリンクが機能するようにする

※Take off Railsなどの広告は削ること

## 参考文献

- [【公式】Bootstrap Cards](https://getbootstrap.jp/docs/4.5/components/card/)
- [【公式】Bootstrap Grid system](https://getbootstrap.jp/docs/4.5/layout/grid/)
- [やんばるエキスパート教材 YouTube動画の投稿](https://www.yanbaru-code.com/texts/349)