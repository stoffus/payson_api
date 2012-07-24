module PaysonAPI
class OrderItem
  FORMAT_STRING = "orderItemList.orderItem(%d).%s"
  attr_accessor :description, :quantity, :unit_price, :sku, :tax

  def initialize(description, unit_price, quantity, tax, sku)
    @description = description
    @unit_price = unit_price
    @quantity = quantity
    @tax = tax
    @sku = sku
  end

  def self.to_hash(order_items)
    {}.tap do |hash|
      order_items.each_with_index do |item, index|
        raise "Invalid order item" unless item.instance_of?(self)
        hash.merge!({
          FORMAT_STRING % [index, 'description'] => item.description,
          FORMAT_STRING % [index, 'unitPrice'] => item.unit_price,
          FORMAT_STRING % [index, 'quantity'] => item.quantity,
          FORMAT_STRING % [index, 'taxPercentage'] => item.tax,
          FORMAT_STRING % [index, 'sku'] => item.sku
        })
      end
    end
  end

  def self.parse_order_items(data)
    i = 0
    [].tap do |order_items|
      while data[FORMAT_STRING % [i, 'description']]
        description = data[FORMAT_STRING % [i, 'description']]
        unit_price = data[FORMAT_STRING % [i, 'unitPrice']]
        quantity = data[FORMAT_STRING % [i, 'quantity']]
        tax = data[FORMAT_STRING % [i, 'taxPercentage']]
        sku = data[FORMAT_STRING % [i, 'sku']]

        order_items << OrderItem.new(description, unit_price, quantity, tax, sku)
        i += 1
      end
    end
  end

end
end
