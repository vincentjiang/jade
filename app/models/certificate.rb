class Certificate < ActiveRecord::Base

	mount_uploader :img_url, ImgUrlUploader

	SHAPE = %w{旦形 佛公 马鞍面 怀古/圆扣 梨形 观音 长方形 筒珠/蘭豆 心/杏心形 圆形 方形 圆珠/圆环 榄尖形 花件 十字架 首饰套装/摆件}
	OBJECT = %w{戒指 吊坠 耳环 襟针 手链 颈链 袖扣 手镯}
	CUT = %w{卜面 平面 拱面}
	MEASURE = %w{测量 未能测量}
	TRANSPARENCY = %w{半透明 全透明 不透明 未能测量}
	POLARISCOPE = %w{多晶质 各向异性 各向同性 异常消光 未能测量}
	DEEP1 = %w{淡 浅 绿 鲜 浓 深 暗}
	COLOR1 = %w{绿色 黄绿色 蓝绿色}
	DEEP2 = %w{淡 浅 绿 鲜 浓 深 暗}
	COLOR2 = %w{绿色 黄绿色 蓝绿色}
	DEEP3 = %w{淡 浅 绿 鲜 浓 深 暗}
	COLOR3 = %w{绿色 黄绿色 蓝绿色}
	DISTRIBUTION = %w{均匀 不均匀 塊状 脈状 点状}
	MAGNIFICATION = %w{粒状及纤维状晶体结构（中粒） 纤维状晶体结构（幼粒） 粒状晶体结构（粗粒）}
	SURFACE_FEATURE = %w{铁渗 翠性 小坑洞 橙皮纹 微小裂纹 沟漕}
	INFRARED_SPECTRUM = %w{不含树脂物质 含树脂物质}

	belongs_to :user

	after_initialize :date_for_issue

	before_save :weight_round_down_3, :val_sg

	#当新建证书或者修改证书的时候，证书的签发日期默认就等于测试日期
	def date_for_issue
    self.date_issue = date_test
  end

  # round down 3位小数
  def weight_round_down_3
    self.weight = weight.to_f < 1 ? weight.to_i.to_f : (weight - 0.5 / 10**3).round(3)
  end

  # 求sg的值
  def val_sg
  	self.sg = ((ww1.to_f + ww2.to_f + ww3.to_f)/3).round(2)
  end

end
