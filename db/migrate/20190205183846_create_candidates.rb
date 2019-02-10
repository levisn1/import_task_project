class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :Name
      t.string :E_mail
      t.string :Phone
      t.string :Job
      t.datetime :Created_at
      t.string :Note
      t.timestamps
    end
  end
end
