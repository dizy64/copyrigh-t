class AddReferenceInformerToReport < ActiveRecord::Migration[5.1]
  def change
    add_reference :reports, :informer, index: true, foreign_key: true
  end
end
