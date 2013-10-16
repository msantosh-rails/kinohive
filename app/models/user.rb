class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires, :oauth_token, :provider, :uid, :email, :hivetype, :age, :city, :state, :zipcode, :total_hivecoins
has_many :videos, dependent: :destroy
has_many :statistics, dependent: :destroy
has_many :awarding_hivecoins, dependent: :destroy
has_many :visits, dependent: :destroy
validates_uniqueness_of :email


  def self.from_omniauth(auth, hivetype)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth, hivetype)
  end

  def email_or_id
    if self.email.present?
      return self.email
    else
      return self.id
    end
  end

  def title
    if self.name.present?
      self.name
    else
      self.email.split("@").first
    end
  end

  def self.create_with_omniauth(auth,hivetype)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.hivetype = hivetype
    end
  end
end
