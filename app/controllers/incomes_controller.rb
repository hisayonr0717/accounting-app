class IncomesController < ApplicationController
    
  def index
    @incomes = Income.order(created_at: :asc)
  end
    
  def new
    @income = Income.new()
  end
    
  def create
    @income = Income.new(params[:income])
　if @income.save
    redirect_to @income, notice: "収入科目を登録しました"
　else
    render "new"
  end
    
  def show
    @income = Income.find(params[:id])
  end
    
  def edit
    @income = Income.find(params[:id])
  end
    
  def update
    @income = Income.find(params[:id])
    @income.assign_attributes(params[:income])
  end
    
  def destroy
    @income.find(params[:id])
    @income.destroy
    redirect_to :income, notice: "科目を削除しました"
  end
end
