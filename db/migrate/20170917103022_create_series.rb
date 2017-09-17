class CreateSeries < ActiveRecord::Migration[5.0]
  def change
    create_table :series do |t|
      t.string :imdb, :null => false, :default => ""
      t.float :my_rating
      t.string :last_episode
      t.integer :serie_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
