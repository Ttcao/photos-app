class Photos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.binary :image

      t.timestamps
    end
  end
end
