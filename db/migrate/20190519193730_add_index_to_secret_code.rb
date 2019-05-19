class AddIndexToSecretCode < ActiveRecord::Migration[5.2]
  def change
    add_index :secret_codes, :code_string
  end
end
