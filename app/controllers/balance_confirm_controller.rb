class BalanceConfirmController < ApplicationController
  def top
  end
 
  def show
    @year_month = params[:year_month] + "-01"
		@incomes = Income.order(created_at: :asc)
		@fixedcosts = Fixedcost.order(created_at: :asc)
		@variablecosts = Variablecost.order(created_at: :asc)
 
    #収入計算
		@income_values =IncomeValue.where(year_month: @year_month)
		@income_value_total = cal_income_total(@income_values)
 
		#固定費計算
		@fixedcost_values = FixedcostValue.where(year_month: @year_month)
		@fixedcost_value_total = cal_fixedcost_total(@fixedcost_values)
 
		#収支差
		@balance_difference = @income_value_total - (@fixedcost_value_total + @variablecost_value_total)
 
	end
 
	def show_year
		year = params[:year]
		@year = year
		months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" ]
		year_months = months.map do |month|
			year+"-"+month+"-01"
		end
 
		puts year_months
 
		#年度の収入配列を作成
		i=0
		total = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		gon.data_incomes = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		year_months.each do |year_month|
			income_values = IncomeValue.where(year_month: year_month)
			if income_values.present?
				total[i] = cal_income_total(income_values)
				gon.data_incomes[i] = total[i]	#グラフ用データ
			end
			i += 1
		end
		@income_value_totals = total
 
		#年度の固定費配列を作成
		i=0
		total = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		gon.data_fixedcosts = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		year_months.each do |year_month|
			fixedcost_values = FixedcostValue.where(year_month: year_month)
			if fixedcost_values.present?
				total[i] = cal_fixedcost_total(fixedcost_values)
				gon.data_fixedcosts[i] = total[i]
			end
			i += 1
		end
		@fixedcost_value_totals = total
 
		#年度の収支結果を計算
		@balance_differences = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		gon.data_results = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]	#グラフ用データ
		0.upto(11) do |i|
			if @income_value_totals[i].present?
				@balance_differences[i] = @income_value_totals[i] - (@fixedcost_value_totals[i])
				gon.data_results[i] = @balance_differences[i]	#グラフ用データ
			end
		end
	end
 
	#収入トータル計算
	def cal_income_total(income_values)
		income_value_total = 0 #固定費合計
		income_values.each do |income_value|
			income_value_total += income_value.value
		end
		income_value_total
	end
 
	#費用トータル計算
	def cal_fixedcost_total(fixedcost_values)
		fixedcost_value_total = 0 #費用合計
		fixedcost_values.each do |fixedcost_value|
			fixedcost_value_total += fixedcost_value.value
		end
		fixedcost_value_total
	end
end