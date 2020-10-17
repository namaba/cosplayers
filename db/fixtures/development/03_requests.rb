1.upto(20) do |i|
  Request.seed(:id) do |r|
    r.id = i
    r.user_id = i
    r.creater_id = i
    r.description = 'サンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプルサンプル'
    status = ["requesting", "making", "completed", "canceled", "declined"].sample
    r.status = status

    case status
    when 'requesting'
      r.requested_at = Time.current
    when "making"
      r.accepted_at = Time.current
    when "completed"
      r.completed_at = Time.current
    when "canceled"
      r.canceled_at = Time.current
    when "declined"
      r.declined_at = Time.current
    end
  end
end
