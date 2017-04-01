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

class Comment < ApplicationRecord
  default_scope -> { order(created_at: :asc) }

  belongs_to :user
  belongs_to :gist

  validates :body, presence: true
  validates :user_id, :user, presence: true
  validates :gist_id, :gist, presence: true
end
