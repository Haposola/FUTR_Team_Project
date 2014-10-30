class Activity < ActiveRecord::Base
  attr_accessible :contact, :description, :name, :owner, :peoNum, :tim
  has_many :com_for_acts
  has_many :q_about_acts
  has_many :re_for_ques_for_acts, through: :q_about_act
end
