class Shops::OpeningSlotsController < ApplicationController
  before_action :set_shop, only: [:new]
  before_action :set_opening_slot, only: [:show, :edit, :update]

  # GET /shops/:shop_id/opening_slots/new
  def new
    @opening_slot = @shop.opening_slots.new
  end

  # GET /shops/:shop_id/opening_slots/:id/edit
  def edit
  end

  # POST /shops/:shop_id/opening_slots
  def create
    @opening_slot = OpeningSlot.new(opening_slot_params)

    respond_to do |format|
      if @opening_slot.save
        format.html {
          redirect_to [@opening_slot.shop],
          notice: t(
            'shared.notice.successful_creation',
            klass: OpeningSlot.model_name.human.humanize,
            instance: @opening_slot
          )
        }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /shops/:shop_id/opening_slots/:id
  def update
    respond_to do |format|
      if @opening_slot.update(opening_slot_params)
        format.html {
          redirect_to [@opening_slot.shop],
          notice: t(
            'shared.notice.successful_update',
            klass: OpeningSlot.model_name.human.humanize,
            instance: @opening_slot
          )
        }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def set_shop
      @shop = Shop.find(params[:shop_id])
    end

    def set_opening_slot
      @opening_slot = OpeningSlot.find(params[:id])
    end

    def opening_slot_attrs
      [
        :shop_id,
        :opening_at,
        :closing_at,
        days_of_week: [],
      ]
    end

    def opening_slot_params
      params.require(:opening_slot).permit(opening_slot_attrs)
    end

end
