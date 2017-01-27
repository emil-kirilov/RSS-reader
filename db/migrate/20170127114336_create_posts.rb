class CreatePosts < ActiveRecord::Migration[5.0]
	def change
		create_table :posts do |t|
			t.references :feed, foreign_key: true, null: false, index: true
			t.string :title, null: false, limit: 50
			t.string :link, null: false , limit: 200
			t.datetime :pud_date, null: false

			t.timestamps null: false
		end
	end
end