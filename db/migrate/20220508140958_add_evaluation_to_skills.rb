class AddEvaluationToSkills < ActiveRecord::Migration[6.1]
  def change
    add_column :skills, :evaluation, :float
  end
end
