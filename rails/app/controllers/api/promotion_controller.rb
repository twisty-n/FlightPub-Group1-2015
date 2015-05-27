class Api::PromotionController < ApplicationController

    def apply_promotion

        promo = Promotion.new
        promo.flight_id = params[:flight_id]
        promo.discount = params[:discount]

        if promo.save
            render json: {}, status: 201
        else
            render json: {}, status: 422
        end
    end

end
