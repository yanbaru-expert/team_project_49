EMAIL = 'test@example.com'
PASSWORD = 'password'

# テストユーザーが存在しないときだけ作成
User.find_or_create_by!(email: EMAIL) do |user|
  user.password = PASSWORD
  puts 'ユーザーの初期データインポートに成功しました。'
end

ADMIN_EMAIL = 'admin@example.com'
ADMIN_PASSWORD = 'password'

AdminUser.find_or_create_by!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') do |admin_user|
  admin_user.password = ADMIN_PASSWORD
  puts 'ユーザーの初期データインポートに成功しました。'
end

Text.delete_all
ImportCsv.text_data
Movie.delete_all
ImportCsv.movie_data
