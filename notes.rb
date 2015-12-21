

# regular price for all films is 1.5


offer:
  # regular films cost 2 for the first 2 days

  # childrens films cost 1.5 for first 3 days

  # new releases cost 3 for EVERY day


  1 extra frequentrenter point for a 2 day new release rental

________________________________

# regular price for all films is 1.5

# new releases cost 3 for EVERY day
if movie.type == "N"
  @customer.to_pay += duration.to_f * price.to_f
  # bonus frequent renter point for 2 day new rental release
  if duration.to_i > 1
    customer.frequent_renter_points += 1
  end
end

# childrens films cost 1.5 for first 3 days
if movie.type == "C"
  if duration < 4
    @customer.to_pay += price.to_f
  else
    @customer.to_pay += price.to_f + (price.to_f * (duration.to_f - 3))
  end
end

# regular films cost 2 for the first 2 days
if movie.type == "R"
  if duration < 3
    @customer.to_pay += price.to_f
  else
    @customer.to_pay += price.to_f + (price.to_f * (duration.to_f - 2))
  end
end
