class AddRateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :director, :string
    add_column :products, :detail, :text
    add_column :products, :open_date, :string
  end
end


  # remove_column :テーブル名, :カラム名, :カラムの型