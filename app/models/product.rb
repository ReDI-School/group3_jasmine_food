class Product < ActiveRecord::Base
  has_many :line_items

   before_destroy :ensure_not_referenced_by_any_line_item

   #...

  validates :price, presence: true, numericality: { greater_than: 0, message: "Stop theif!" }
  validates :titel, uniqueness: true
  validates :description, length: { maximum: 100 }

  before_save :add_description
  before_save :add_image_url
  before_validation :set_price
  before_validation :set_name

  def next
    Product.where("id > ?", id).first
  end

  def prev
    Product.where("id < ?", id).last
  end


  private

     # ensure that there are no line items referencing this product
     def ensure_not_referenced_by_any_line_item
       if line_items.empty?
         return true
       else
         errors.add(:base, 'Line Items present')
         return false
       end
     end

  def discount_price
    price * 0.9
  end

  def add_description
    unless description.present?
      self.description = "Great product. Description coming soon!"
    end
  end

  def add_image_url
    unless image_url.present?
      self.image_url = "No image yet"
    end
  end

  def set_price
    if !price.present? || price == 0
      self.price = 1.0
    end
  end

  def set_name
    matching_titels = Product.where(titel: self.titel).where.not(id: self.id)
    titel_taken = matching_titels.exists?
    if titel_taken
      self.titel = "#{self.titel} - #{matching_titels.count}"
    end
  end
end
