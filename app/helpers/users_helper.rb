# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def robohash_for(user, options = { size: 80 })
    robohash_id = Digest::MD5.hexdigest(user.github_uid)
    robohash_url = "https://robohash.org/#{robohash_id}?size=#{options[:size]}x#{options[:size]}"
    image_tag(robohash_url, alt: 'UIKonf Friendly Commenter', class: 'robohash')
  end
end
