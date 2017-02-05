class PhotoLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :photo_labels do |t|
      t.string :label
      t.float :score
      t.belongs_to :photo, index: true

      t.timestamps
    end
  end
end
