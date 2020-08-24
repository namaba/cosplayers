User.all.each.with_index(1) do |user, i|
  Creater.seed(:id) do |c|
    c.id = i
    c.user_id = user.id
    c.description = "サンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプル"
    c.min_charge = 3000
  end
end