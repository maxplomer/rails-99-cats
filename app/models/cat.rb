class Cat < ActiveRecord::Base
  validates_date :birth_date, :on_or_before => lambda { Date.current }

  validates :sex, inclusion: { in: %w(M F) }

  validates :birth_date, :color, :name, :sex, :description,  presence: true

  has_many(
    :requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "CatRentalRequest",
    dependent: :destroy
  )


  belongs_to(
    :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Cat"
  )

end