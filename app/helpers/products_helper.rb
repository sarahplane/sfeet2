module ProductsHelper
  def price_range(price)
    '$' * price.to_i
  end
end
