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
    base_bills = current_user.creater.bills.captured.includes(:request)
    @gross_sales = base_bills.sum(&:amount)
    @withdrawn_gross_sales = base_bills.withdrawn.sum(&:amount)
    @current_month_sales =  base_bills.where('bills.created_at >= ?', Time.current.beginning_of_month).sum(&:amount)
    @withdrawn_current_month_sales =  base_bills.withdrawn.where('bills.created_at >= ?', Time.current.beginning_of_month).sum(&:amount)
    @withdrawable_sales = base_bills.captured.unapplied.sum(&:amount)
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