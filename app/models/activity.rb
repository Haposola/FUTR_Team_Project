class Activity < ActiveRecord::Base
	mount_uploader :picture, UserAvatarUploader
  attr_accessible :contact, :description, :name, :owner, :peoNum, :tim, :tag, :picture
  validates :name, :tim, :description ,presence: true
  has_many :act_tags
  has_many :com_for_acts
  has_many :q_about_acts
  has_many :re_for_ques_for_acts, through: :q_about_act
end
