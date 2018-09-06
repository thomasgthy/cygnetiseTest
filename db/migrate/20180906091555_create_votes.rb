class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
    	t.string :validity
    	t.belongs_to :candidate, index: true
    	t.integer :epoch_time
      t.timestamps
    end
  end
end
