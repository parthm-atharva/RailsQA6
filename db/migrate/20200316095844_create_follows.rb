class CreateFollows < ActiveRecord::Migration[6.0]
  def up
    create_table :follows do |t|
      t.references :user, null: false, foreign_key: true
      t.references :followable, polymorphic: true

      t.timestamps
    end
  end

  def down
    drop_table :follows
  end
end
