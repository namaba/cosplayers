class BillsController < ApplicationController
  before_action :set_bill, only: %i[update]
  def index
    @bills = case params[:status]&.to_sym
             when :unapplied
               base_query.unapplied
             when :appliying
               base_query.appliying
             when :withdrawn
               base_query.withdrawn
             else
               base_query
             end
  end

  def update
    @bill.appliying!
    redirect_to bills_path, notice: '出金申請しました！'
  end

  private

  def set_bill
    @bill = Bill.find params[:id]
  end

  def base_query
    current_user.creater.bills.captured.page(params[:page]).per(20)
  end
end