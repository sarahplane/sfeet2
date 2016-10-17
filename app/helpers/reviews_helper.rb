module ReviewsHelper
  def rating_average(reviews)
    reviews.average(:rating)
  end
end
