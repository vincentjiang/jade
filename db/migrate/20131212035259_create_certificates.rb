class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :report_no
      t.boolean :is_hoklas
      t.date :date_test
      t.date :date_issue
      t.string :shape
      t.string :object
      t.string :cut
      t.decimal :dimensions1
      t.decimal :dimensions2
      t.decimal :dimensions3
      t.decimal :dimension
      t.decimal :weight
      t.string :weight_desc
      t.string :transparency
      t.string :deep1
      t.string :color1
      t.string :deep2
      t.string :color2
      t.string :deep3
      t.string :color3
      t.string :distribution
      t.string :polariscope
      t.decimal :refractive_index
      t.boolean :is_measure
      t.decimal :ww1
      t.decimal :ww2
      t.decimal :ww3
      t.decimal :sg
      t.string :uv_lw
      t.string :uv_sw
      t.string :chelsea_color_filter
      t.string :visible_spectrum
      t.string :magnification
      t.string :surface_feature
      t.string :infrared_spectrum
      t.string :level
      t.string :conclusion
      t.text :comments
      t.string :img_url
      t.integer :user_id

      t.timestamps
    end
  end
end
