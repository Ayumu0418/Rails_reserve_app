class Room < ApplicationRecord
  belongs_to :user

  has_many :reservations, dependent: :destroy
  has_one_attached :hotel_image

  validates :hotel_name, presence: true
  validates :hotel_detail, presence: true
  validates :hotel_price, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :hotel_address, presence: true

  def self.search(keyword_free, keyword_area)
    if keyword_area.present?
      where('hotel_address LIKE ?', "%#{keyword_area}%")
    elsif keyword_free.present?
      where('hotel_name LIKE ? OR hotel_detail LIKE ? OR hotel_price LIKE ? OR hotel_address LIKE ?', "%#{keyword_free}%", "%#{keyword_free}%", "%#{keyword_free}%", "%#{keyword_free}%")
    else
      all
    end
  end

end
