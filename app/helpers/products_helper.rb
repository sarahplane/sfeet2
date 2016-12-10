module ProductsHelper
  def price_range(price)
    '$' * price.to_i
  end

  def review_sample(product)
    sample = product.reviews.includes(:user).sample
    "#{sample.user.email} - #{sample.comment}"
  end

end
