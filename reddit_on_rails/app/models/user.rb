class User < ApplicationRecord

    #figvaper, celll

    validates :username, uniqueness: true, presence: true
    validates :password_digest, :session_token, presence: true
    validates :password, presence: true, allow_nil: true, length: {minimum: 6}

    attr_reader :password
    after_initialize :ensure_session_token

    def self.find_by_credentials(username, password)

    end

    def is_password?(password)
        BCrypt::Password.new(password_digest).is_password?(password)
    end

    def generate_session_token
        self.session_token = SecureRandom.urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= self.generate_session_token
    end

    def reset_session_token!
        self.session_token = self.generate_session_token
        self.save
        self.session_token
    end



end