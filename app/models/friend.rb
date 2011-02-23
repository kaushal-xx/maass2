class Friend < ActiveRecord::Base

  FRIENDS_STATUSES = {"accepted" => "accept", "waiting" => "wait"}
    belongs_to :profile

  FRIENDS_STATUSES.each do |key,value|
    scope key.to_sym, where(:status => value)
  end

  def self.check_friend(user,friend)
    find_by_inviter_id_and_invited_id(user, friend)
  end

  def self.request(user,friend)
    create(:inviter_id => user, :invited_id => friend, :status => 'wait')
    create(:inviter_id => friend, :invited_id => user, :status => 'request')
  end

  def self.accept_request(user,friend)
    accept_one_side(user, friend)
    accept_one_side(friend, user)
  end

  def self.delete_friend(user, friend)
    destroy(find_by_inviter_id_and_invited_id(user, friend))
    destroy(find_by_inviter_id_and_invited_id(friend, user))
  end

private

  def self.accept_one_side(user, friend)
    request = find_by_inviter_id_and_invited_id(user, friend)
    request.status = 'accept'
    request.save!
  end

end


