class StoreController < ApplicationController
  def index
    @products = Product.order(:titel)
  end
end
