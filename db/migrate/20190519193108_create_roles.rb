class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name, default: "user"
      t.references :user

      t.timestamps
    end
  end
end
