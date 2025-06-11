class ImageUploader
  #    include HTTParty

  #    base_uri 'https://images.abstractapi.com/v1/upload/'

  #     def initialize(img)

  #         @img = File.open(img)
  #     end

  #     def upload
  #         response = self.class.post("/",{
  #         query: {
  #             api_key: Rails.application.credentials.image_api,
  #             image: @img}
  #         })
  #         #response["url"]
  #     end
end
