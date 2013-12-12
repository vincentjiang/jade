json.array!(@certificates) do |certificate|
  json.extract! certificate, :id, :report_no, :is_hoklas, :date_test, :date_issue, :shape, :object, :cut, :dimensions1, :dimensions2, :dimensions3, :dimension, :weight, :weight_desc, :transparency, :deep1, :color1, :deep2, :color2, :deep3, :color3, :distribution, :polariscope, :refractive_index, :is_measure, :ww1, :ww2, :ww3, :sg, :uv_lw, :uv_sw, :chelsea_color_filter, :visible_spectrum, :magnification, :surface_feature, :infrared_spectrum, :level, :conclusion, :comments, :img_url, :user_id
  json.url certificate_url(certificate, format: :json)
end
