class Reservation < ApplicationRecord
  belongs_to :user

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
      errors.add(:end, "は開始日より後の日付にしてください")
      puts "DEBUG: チェックアウトの日付は開始日より後の日付にしてください。"
    end
  end

  # def blank_check
  #   if reservation_params[:start].blank?
  #     errors.add(:start, "の日付を入力してください")
  #   elsif reservation_params[:end].blank?
  #     errors.add(:end, "の日付を入力してください")
  #   elsif reservation_params[:people].blank?
  #     errors.add(:people, "を入力してください")
  #   end
  # end
end
