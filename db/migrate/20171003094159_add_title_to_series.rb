class AddTitleToSeries < ActiveRecord::Migration[5.0]
  def change
    add_column :series, :title, :string, null: false, default: ""
  end
end
