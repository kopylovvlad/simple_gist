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

class Gist < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  scope :search, ->(search_word) do
    where('title LIKE ?', "%#{search_word}%")
  end

  belongs_to :user

  has_many :comments, dependent: :destroy

  LANG_MODES = [
    'apl', 'elm', 'erlang', 'livescript', 'python', 'textile', 'lua',
    'r', 'brainfuck', 'fortran', 'clojure', 'ruby', 'cobol',
    'coffeescript', 'go', 'sass', 'commonlisp', 'groovy', 'scheme',
    'crystal', 'haml', 'nginx', 'shell', 'vb', 'css', 'slim',
    'd', 'haskell', 'smalltalk', 'dart', 'vue', 'django', 'htmlmixed',
    'http', 'perl', 'xml', 'php', 'spreadsheet', 'jade', 'sql', 'javascript',
    'powershell', 'yaml', 'jsx', 'swift'
  ].freeze
  self.per_page = 10

  validates :title, presence: true
  validates :body, presence: true
  validates :lang_mode, presence: true, inclusion: LANG_MODES
  validates :user_id, presence: true
  validates :user, presence: true

  def self.lang_collection
    LANG_MODES.map { |mode| [mode, mode] }
  end

  def short_body
    body_arr = body.split(%r{\n})
    if body_arr.size > 15
      "#{body_arr[0, 15].join("\n")}..."
    else
      body
    end
  end

  def comments_count
    @comments_count ||= comments.count
  end

  def load_comments_count
    comments_count
    self
  end
end
