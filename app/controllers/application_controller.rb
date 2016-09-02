class ApplicationController < ActionController::Base
  before_action :autorization



  def autorization
    #отримання token
    @token_key = RestClient.post "http://maxus.beta.qpard.com/index.php/rest/V1/integration/admin/token", {"username":USERNAME_ADMIN_MAGENTO, "password":PASSWORD_ADMIN_MAGENTO}.to_json,
                                 {:content_type => :json, :accept => :json}
    @token_key = @token_key.to_s.gsub('"','')
  end

end
