class AddLanguageNameToSkills < ActiveRecord::Migration[6.1]
  def change
    add_column :skills, :language_name, :string
  end
end
