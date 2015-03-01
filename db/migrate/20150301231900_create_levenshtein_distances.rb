class CreateLevenshteinDistances < ActiveRecord::Migration
  def change
    create_table :levenshtein_distances do |t|

      t.timestamps
    end
  end
end
