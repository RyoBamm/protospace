class CreatePrototypeTags < ActiveRecord::Migration
  def change
    create_table :prototype_tags do |t|
      t.references :prototype, foreign_key: true, null: false
      t.references :tag, foreing_key: true, null: false
      t.timestamps null: false
    end
  end
end
