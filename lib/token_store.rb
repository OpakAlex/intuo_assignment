module TokenStore

  extend self

  TTL = 60.hours

  def generate(user)
    token = generate_authentication_token
    $redis[token] = user.id
    $redis.expire token, TTL
    token
  end

  def valid?(token)
    $redis.exists(token)
  end

  def invalidate(token)
    $redis.del(token)
  end

  def current_user(token)
    User.find_by(id: $redis[token])
  end

  private

  def generate_authentication_token
    Digest::SHA1.hexdigest([Time.now, rand].join)
  end

end
