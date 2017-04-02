# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer          not null
#  gist_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:gist_id) }
  it { should validate_presence_of(:gist) }
  it { should belong_to(:user) }
  it { should belong_to(:gist) }
end
