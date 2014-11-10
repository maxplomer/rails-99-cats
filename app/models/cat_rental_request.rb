class CatRentalRequest < ActiveRecord::Base

  validates :status, inclusion: { in: %w(APPROVED DENIED PENDING) }

  validates :cat_id, :start_date, :end_date, presence: true

  validate :overlapping_approved_requests

  belongs_to :cat, class_name: "CatRentalRequests", foreign_key: :cat_id, primary_key: :id


  def approve!
    self.status = "APPROVED"
  end

  def deny!
    self.status = "DENIED"
  end
  # private

  def overlapping_requests
    query =  <<-SQL
        SELECT
          *
        FROM
          cat_rental_requests
        WHERE
          start_date <= '#{self.end_date}'
          AND end_date >= '#{self.start_date}'
          AND cat_id = #{self.cat_id}
        SQL
    CatRentalRequest::find_by_sql(query)
    #CatRentalRequest.where(
    #  <<-SQL
    #  SELECT
    #    *
    #  FROM
    #    cat_rental_requests
    #  WHERE
    #    start_date <= '#{self.end_date}'
    #    AND end_date >= '#{self.start_date}'
    #    AND cat_id = #{self.cat_id}
    #  SQL
    #)
  end

  def overlapping_approved_requests
    if overlapping_requests.any? { |requests| requests.status == "APPROVED"}
      errors[:approved] << "That cat is already booked for those dates"
    end
  end


end