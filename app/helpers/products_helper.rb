module ProductsHelper
  def price_range(price)
    '$' * price.to_i
  end

  def price_label(price_tier)
    case price_tier
    when 1
      "$"
    when 2
      "$$"
    when 3
      "$$$"
    when 4
      "$$$$"
    end
  end
end
