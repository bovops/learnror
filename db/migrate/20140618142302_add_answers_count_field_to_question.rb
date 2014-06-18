class AddAnswersCountFieldToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :answers_count, :integer, default: 0

    Question.reset_column_information
    Question.all.map { |q| Question.reset_counters(q.id, :answers) }

  end
end
