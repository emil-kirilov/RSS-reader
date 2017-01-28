class RenamePudDateToPubDate < ActiveRecord::Migration[5.0]
  def change
  	rename_column :posts, :pud_date, :pub_date
  end
end
