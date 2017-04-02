# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  login                  :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:login) }
  it { should validate_length_of(:login).is_at_least(3) }
  it { should validate_uniqueness_of(:login) }
  it { should have_many(:gists).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }

  describe 'login' do
    describe 'must contains only letters, digits, and underscore' do
      it 'cvsdfsfsd is valid' do
        user = FactoryGirl.build(
          :user,
          login: 'cvsdfsfsd'
        )
        expect(user.valid?).to eq(true)
      end

      it 'vavadf12 is valid' do
        user = FactoryGirl.build(
          :user,
          login: 'vavadf12'
        )
        expect(user.valid?).to eq(true)
      end

      it '234234234 is valid' do
        user = FactoryGirl.build(
          :user,
          login: '234234234'
        )
        expect(user.valid?).to eq(true)
      end

      it 'ivan.vlad@gmail.com is invalid' do
        user = FactoryGirl.build(
          :user,
          login: 'ivan.vlad@gmail.com'
        )
        expect(user.valid?).to eq(false)
        expect(user.errors.keys).to include(:login)
      end

      it 'kkk/kkkk/sdf is invalid' do
        user = FactoryGirl.build(
          :user,
          login: 'kkk/kkkk/sdf'
        )
        expect(user.valid?).to eq(false)
        expect(user.errors.keys).to include(:login)
      end

      it 'fsdf-sdfsdf is invalid' do
        user = FactoryGirl.build(
          :user,
          login: 'kkk/kkkk/sdf'
        )
        expect(user.valid?).to eq(false)
        expect(user.errors.keys).to include(:login)
      end

      it 'fsdf_sdfsd is valid' do
        user = FactoryGirl.build(
          :user,
          login: 'fsdf_sdfsd'
        )
        expect(user.valid?).to eq(true)
      end

      it 'sdfsdf_123 is valid' do
        user = FactoryGirl.build(
          :user,
          login: 'sdfsdf_123'
        )
        expect(user.valid?).to eq(true)
      end
    end
  end
end
