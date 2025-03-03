# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer          default(0)
#  image          :string
#  likes_count    :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer          not null
#
# Indexes
#
#  index_photos_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader


  belongs_to :owner, class_name: "User"
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :fans, through: :likes, source: :fan

  validates :image, presence: true
end
