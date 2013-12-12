class Certificate < ActiveRecord::Base
	belongs_to :user

	after_initialize :date_for_issue

	#当新建证书或者修改证书的时候，证书的签发日期默认就等于测试日期
	def date_for_issue
    self.date_issue = date_test
  end

end
