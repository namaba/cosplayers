1.upto(20) do |i|
  Creater.seed(:id) do |c|
    c.id = i
    c.user_id = i
    c.description = "サンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプル"
    c.min_charge = 3000
  end
end