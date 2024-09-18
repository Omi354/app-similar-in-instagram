class ProfileSerializer < ActiveModel::Serializer
  attributes :avatar_url

  def avatar_url
    object.avatar_url
  end

end
