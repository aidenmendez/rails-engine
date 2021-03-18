class MerchantsWithItemsSoldSerializer
  include FastJsonapi::ObjectSerializer
  set_type :items_sold
  set_id :id
  attributes :name, :count
end