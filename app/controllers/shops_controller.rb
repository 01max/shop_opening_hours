class ShopsController < ApplicationController
  before_action :set_shop, only: [:show]

  # GET /shops
  def index
    @pagy, @shops = pagy(Shop.all)
  end

  # GET /shops/1
  def show
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html {
          redirect_to [@shop],
          notice: t(
            'shared.notice.successful_creation',
            klass: Shop.model_name.human.humanize,
            instance: @shop
          )
        }
      else
        format.html { render :new }
      end
    end
  end

  private
    def set_shop
      @shop = Shop.find(params[:id])
    end

    def shop_attrs
      [
        :name,
      ]
    end

    def shop_params
      params.require(:shop).permit(shop_attrs)
    end

end
