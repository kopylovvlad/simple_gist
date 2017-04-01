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

require 'rails_helper'

RSpec.describe Gist, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:lang_mode) }
  it do
    should validate_inclusion_of(:lang_mode)
      .in_array(Gist::LANG_MODES)
  end
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:user) }
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }
end
