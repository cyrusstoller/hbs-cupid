# == Schema Information
# Schema version: 20141117214934
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#  active                 :boolean
#  admin                  :boolean
#  section                :string(255)
#
# Indexes
#
#  index_users_on_active                (active)
#  index_users_on_admin                 (admin)
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_section               (section)
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  validates_presence_of :username
  validates_uniqueness_of :username, :case_sensitive => false
  validates_format_of :username, :with => /\A[\w]+\z/, :on => :create, :message => "cannot have whitespace"
  validates_presence_of :section

  has_many :submitted_answers, :class_name => "SubmittedAnswer", :foreign_key => "user_id", :dependent => :destroy
  has_many :answered_questions, :through => :submitted_answers, :source => :question, :dependent => :destroy

  has_many :cached1_percentage_results, :class_name => "CachedPercentageResult", :foreign_key => "user1_id", :dependent => :destroy
  has_many :cached2_percentage_results, :class_name => "CachedPercentageResult", :foreign_key => "user2_id", :dependent => :destroy

  scope :in_section, -> (letter) { where(%(lower("#{self.table_name}"."section") = ?), letter.downcase) }

  def self.section_names
    ("A".."J").map do |letter|
      ["Section #{letter}", letter]
    end
  end

  def self.find_by_username(username)
    username ||= ""
    user = where("lower(username) = :value", :value => username.downcase).first
    raise ActiveRecord::RecordNotFound if user.blank?
    return user
  end

  protected

  # Allowing for devise to use either the username or email as the authentication key
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
