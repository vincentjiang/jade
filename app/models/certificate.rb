class Certificate < ActiveRecord::Base

	SHAPE = %w{旦形 佛公 马鞍面 怀古/圆扣 梨形 观音 长方形 筒珠/蘭豆 心/杏心形 圆形 方形 圆珠/圆环 榄尖形 花件 十字架 首饰套装/摆件}
	OBJECT = %w{戒指 吊坠 耳环 襟针 手链 颈链 袖扣 手镯}
	CUT = %w{卜面 平面 拱面}
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

	belongs_to :user

	after_initialize :date_for_issue

	#当新建证书或者修改证书的时候，证书的签发日期默认就等于测试日期
	def date_for_issue
    self.date_issue = date_test
  end

end
