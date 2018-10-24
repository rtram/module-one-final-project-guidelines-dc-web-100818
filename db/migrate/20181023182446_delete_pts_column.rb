class DeletePtsColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column(:standings, :points, :integer)
  end
end
