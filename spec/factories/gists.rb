# == Schema Information
#
# Table name: gists
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  body       :text             not null
#  lang_mode  :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :gist do
    title 'hello.rb'
    body "puts('hello world')"
    lang_mode 'ruby'
  end
end
