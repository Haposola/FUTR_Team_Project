class Activity < ActiveRecord::Base
  attr_accessible :contact, :description, :name, :owner, :peoNum, :tim
  has_many :com_for_act
  has_many :q_about_act
  has_many :re_for_ques_for_act, through: :q_about_act
end
