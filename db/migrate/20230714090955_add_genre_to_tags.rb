class AddGenreToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :genre, :string
  end
end
