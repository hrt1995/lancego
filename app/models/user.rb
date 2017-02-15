class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: [:twitter]

    def self.from_omniauth(auth)
        where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
            user.provider = auth["provider"]
            user.uid = auth["uid"]
            user.username = auth["info"]["nickname"]
        end
    end

    def self.new_with_session(params, session)
        if session["devise.user_attributes"]
            new(session["devise.user_attributes"], without_protection: true) do |user|
                user.attributes = params
                user.valid?
            end
        else
            super
        end
    end

  has_many :tweets

  #validates :name, presence:true

  #validates :email, presence:true, uniqueness:true

  def set_image(file)
    if !file.nil?
      file_name = file.original_filename
      File.open("public/user_images/#{file_name}", 'wb'){|f| f.write(file.read)}
      self.image = file_name
    end
  end
end
