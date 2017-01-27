class CreateFeeds < ActiveRecord::Migration[5.0]
	def change
		create_table :feeds do |t|
			t.string :url, null: false
			 
			t.timestamps null: false
		end
	end
end