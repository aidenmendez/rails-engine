class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  set_type :merchant
end
