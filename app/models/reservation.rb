class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :start, presence: true
  validates :end, presence: true
  validates :people, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :start_check
  validate :start_end_check

  def start_check
    if start.present? && start < Time.zone.today
    errors.add(:start, "は本日以降を選択してください") 
    end
  end

  def start_end_check
    if start.present? && self.end.present? && start >= self.end
      errors.add(:end, "はチェックインより後の日付にしてください")
    end
  end
end
