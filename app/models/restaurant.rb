# == Schema Information
#
# Table name: restaurants
#
#  id                :bigint           not null, primary key
#  description       :string
#  image             :string
#  image_description :string
#  name              :string           not null
#  price_range       :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Restaurant < ApplicationRecord
end
