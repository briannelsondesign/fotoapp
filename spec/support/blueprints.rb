require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  username { "user_#{sn}" }
  name     { "User #{sn}" }
  email    { "user#{sn}@foo.com" }
  provider { "github" }
  uid      { "#{sn}" }
  token    { "#{sn}" }
end

PhotoStore.blueprint do
  user            { User.make! }
  provider_key    { "#{sn}" }
  provider_secret { "#{sn}" }
  folder_name     { "#{sn}-fotos" }
end

Photo.blueprint do
  filename    { "photo-#{sn}.jpg" }
  user        { User.make! }
  photo_store { PhotoStore.make!(:user_id => object.user.id) }
  path        { "#{sn}/#{sn}.jpg"}
  checksum    { "#{sn}" }
end
