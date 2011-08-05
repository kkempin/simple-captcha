class SimpleCaptchaController < ActionController::Metal
  # Changes: Streaming -> DataStreaming
  include ActionController::DataStreaming
  include SimpleCaptcha::ImageHelpers

  # GET /simple_captcha
  def show
    unless params[:id].blank?
      # looks like some problems with not existing send_file in Rails 3.1.0rc5
      self.status = 200
      self.content_type = "image/jpeg"
      self.headers['Content-Disposition'] = 'inline; filename=simple_captcha.jpg' 
      self.headers['Content-Transfer-Encoding'] = 'binary' 
      self.response_body = File.open(generate_simple_captcha_image(params[:id]), "rb")
    else
      self.response_body = [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
