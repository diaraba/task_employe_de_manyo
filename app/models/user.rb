class User < ApplicationRecord
    has_many :tasks , dependent: :destroy
    validates :name, presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }
    has_secure_password
    validates :password, length: { minimum: 6 }

    before_update :check_admin_exist_for_update
    before_destroy :check_admin_exist_for_destroy

    def admin?
        admin
    end

    private
    def check_admin_exist_for_update
      if self.is_only_one_admin? && self.will_save_change_to_attribute?(:admin)
        errors.add(:base, "Vous ne pouvez pas modifier les privilèges car le nombre d'administrateurs sera de 0.")
        throw(:abort)
      end 
    end

    def check_admin_exist_for_destroy
      if self.is_only_one_admin?  
        errors.add(:base, "Impossible de supprimer car il n'y a que 1 administrateurs")
        throw(:abort)
      end 
    end

    def is_only_one_admin?
      User.where(admin: true).count == 1 && self == User.find_by(admin: true)
    end
end
