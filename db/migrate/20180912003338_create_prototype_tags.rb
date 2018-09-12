class CreatePrototypeTags < ActiveRecord::Migration
  def change
    create_table :prototype_tags do |t|

      t.timestamps null: false
    end
  end
end
