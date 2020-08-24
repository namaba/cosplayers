1.upto(20) do |i|
  User.seed(:id) do |u|
    u.id = i
    u.email = "artist_#{i}@exapmle.com"
    u.encrypted_password = "$2a$10$JMDTqq8mJPfvmdBZBcbV2u3og.5SQ4BygItc6nzbKDqP094HtiQZG"
    u.username = "artist_#{i}"
    u.confirmed_at = Time.current
    u.introduction = 'サンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプル'
  end
end
