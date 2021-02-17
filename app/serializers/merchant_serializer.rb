class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  set_type :merchant

  # attribute :total_revenue do |object|

  # end

end
