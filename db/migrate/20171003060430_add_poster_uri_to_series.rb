class AddPosterUriToSeries < ActiveRecord::Migration[5.0]
  def change
    add_column :series, :poster_uri, :string
  end
end
