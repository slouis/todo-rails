class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :list
      t.string :name
      t.integer :sort

      t.timestamps
    end
    add_index :tasks, :list_id
  end
end
