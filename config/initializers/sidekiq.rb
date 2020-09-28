Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://spinyfin.redistogo.com:11022/0' }
end
