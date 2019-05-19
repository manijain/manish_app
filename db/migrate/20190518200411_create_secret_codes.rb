class CreateSecretCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :secret_codes do |t|
      t.string :code_string
      t.references :user

      t.timestamps
    end
  end
end
