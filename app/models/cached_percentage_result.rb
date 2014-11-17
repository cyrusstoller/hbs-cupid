# == Schema Information
# Schema version: 20141115012919
#
# Table name: cached_percentage_results
#
#  id          :integer          not null, primary key
#  user1_id    :integer
#  user2_id    :integer
#  score1      :float
#  score2      :float
#  final_score :float
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_cached_percentage_results_on_final_score  (final_score)
#  index_cached_percentage_results_on_user1_id     (user1_id)
#  index_cached_percentage_results_on_user2_id     (user2_id)
#

class CachedPercentageResult < ActiveRecord::Base
  validates_presence_of :user1_id
  validates_presence_of :user2_id
  validates_uniqueness_of :user1_id, :scope => [:user2_id]
  validates_uniqueness_of :user2_id, :scope => [:user1_id]
  validate -> {
    if user1_id == user2_id
      errors[:base] << "Cannot store cached result of a user with itself"
    end
  }

  belongs_to :user1, :class_name => "User", :foreign_key => "user1_id"
  belongs_to :user2, :class_name => "User", :foreign_key => "user2_id"

  before_validation :order_user_ids

  def self.find_instance_with_users(u1, u2)
    find_with_user(u1).find_with_user(u2).first
  end

  def self.find_with_user(user)
    if user.is_a?(User)
      u_id = user.id
    else
      u_id = user
    end

    where(%("#{self.table_name}"."user1_id" = :u_id OR "#{self.table_name}"."user2_id" = :u_id), :u_id => u_id)
  end

  private

  def order_user_ids
    unless self.user1_id.blank? or self.user2_id.blank?
      if self.user1_id > self.user2_id
        self.user1_id, self.user2_id = self.user2_id, self.user1_id
        self.score1, self.score2 = self.score2, self.score1
      end
    end
  end
end
