class CreatePosts < ActiveRecord::Migration[5.0]
	def change
		craete_table :posts do |t|
			t.references :feed, foreign_key: true, null: false, index: true
			t.string :title, null: false
			t.string :link, null: false  
			t.date :pud_date, null: false

			t.timestamps null: false
		end
	end
end