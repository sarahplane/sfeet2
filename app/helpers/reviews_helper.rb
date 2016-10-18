module ReviewsHelper
  def rating_average(reviews)
    (reviews.map{|review| review.rating.to_i }.inject(:+)) / (reviews.count)
  end
end
