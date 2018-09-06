class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates do |t|
      t.string :name
      t.belongs_to :campaign, index: true
      t.timestamps
    end
  end
end
