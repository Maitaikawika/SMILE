module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=50"
    image_tag(gravatar_url, class: "gravatar")
  end
end
